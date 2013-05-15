<?php
class Taobao
{
	public function collectCates()
	{
		setTimeLimit(3600);
		$ccate = FDB::fetchFirst('SELECT * FROM '.FDB::table('goods_cate_collect').' LIMIT 0,1');
		if(!$ccate)
			return false;
		
		FDB::query('DELETE FROM '.FDB::table('goods_cate_collect')." WHERE id = '$ccate[id]'");
		
		global $_FANWE;
		include_once FANWE_ROOT.'sdks/taobao/TopClient.php';
        include_once FANWE_ROOT.'sdks/taobao/request/ItemcatsGetRequest.php';
		Cache::getInstance()->loadCache('business');
		$sort_file = FANWE_ROOT.'/public/records/cate.sort.php';
		$sort = (int)@file_get_contents($sort_file);
		
		$client = new TopClient;
        $client->appkey = trim($_FANWE['cache']['business']['taobao']['app_key']);
        $client->secretKey = trim($_FANWE['cache']['business']['taobao']['app_secret']);
		
		$req = new ItemcatsGetRequest;
		$req->setFields("cid,parent_cid,name,is_parent");
		$req->setParentCid($ccate['cid']);
		$resp = $client->execute($req);
		if(isset($resp->item_cats) && isset($resp->item_cats->item_cat))
		{
			foreach($resp->item_cats->item_cat as $item)
			{
				$item = (array)$item;
				$cate = array();
				$cate['type'] = 'taobao';
				$cate['id'] = $item['cid'];
				$cate['pid'] = $item['parent_cid'] == 0 ? '' : $item['parent_cid'];
				$cate['name'] = $item['name'];
				$cate['pids'] = empty($ccate['pids']) ? $cate['pid'] : $ccate['pids'].','.$cate['pid'];
				$cate['sort'] = ++$sort;
				FDB::insert('goods_cates',$cate,false,true);
				if($item['is_parent'] == 'true')
					FDB::insert('goods_cate_collect',array('id'=>'NULL','cid'=>$item['cid'],'pids'=>$cate['pids']));
			}
			@file_put_contents($sort_file,$sort);
		}
		return true;
	}
	
	public function collectShopCates()
	{
		setTimeLimit(3600);
		global $_FANWE;
		include_once FANWE_ROOT.'sdks/taobao/TopClient.php';
        include_once FANWE_ROOT.'sdks/taobao/request/ShopcatsListGetRequest.php';
		Cache::getInstance()->loadCache('business');
		$sort_file = FANWE_ROOT.'/public/records/cate.sort.php';
		$sort = (int)@file_get_contents($sort_file);
		
		$client = new TopClient;
        $client->appkey = trim($_FANWE['cache']['business']['taobao']['app_key']);
        $client->secretKey = trim($_FANWE['cache']['business']['taobao']['app_secret']);
		
		$req = new ShopcatsListGetRequest;
		$req->setFields("cid,parent_cid,name,is_parent");
		$resp = $client->execute($req);
		$sort = 0;
		if(isset($resp->shop_cats) && isset($resp->shop_cats->shop_cat))
		{
			foreach($resp->shop_cats->shop_cat as $item)
			{
				$item = (array)$item;
				$cate = array();
				$cate['type'] = 'taobao';
				$cate['id'] = $item['cid'];
				$cate['pid'] = $item['parent_cid'] == 0 ? '' : $item['parent_cid'];
				$cate['name'] = $item['name'];
				$cate['pids'] = '';
				$cate['sort'] = ++$sort;
				FDB::insert('shop_cates',$cate,false,true);
			}
		}
		return true;
	}

	public function collectReport($time,$page)
	{
		setTimeLimit(3600);
		global $_FANWE;
		
		if($page <= 1){
			FDB::query('TRUNCATE TABLE '.FDB::table('taobaoke_report_temp'));
		}

		include_once FANWE_ROOT.'sdks/taobao/TopClient.php';
        include_once FANWE_ROOT.'sdks/taobao/request/TaobaokeReportGetRequest.php';
        include_once FANWE_ROOT.'sdks/taobao/request/TaobaokeItemsDetailGetRequest.php';
        
		Cache::getInstance()->loadCache('business');
		
		$client = new TopClient;
        $client->appkey = trim($_FANWE['cache']['business']['taobao']['app_key']);
        $client->secretKey = trim($_FANWE['cache']['business']['taobao']['app_secret']);
		
		$req = new TaobaokeReportGetRequest();
		$req->setFields("num_iid,outer_code,commission_rate,real_pay_fee,app_key,outer_code,pay_time,pay_price,commission,item_title,item_num,trade_id");
		$page_size = 100;
		$time = fToDate($time,'Ymd');
		$req->setDate($time);
		$req->setPageNo($page);
		$req->setPageSize($page_size);
		$resp = (array)$client->execute($req,trim($_FANWE["cache"]["business"]["taobao"]["session_key"]));
		$is_complete = false;
		$total_results = 0;
		$is_insert = false;
		$success = 1;
		
		if(isset($resp['taobaoke_report'])){
			$taobaoke_report = (array)$resp['taobaoke_report'];
			$total_results = (int)$taobaoke_report['total_results'];
			$reports = $taobaoke_report['taobaoke_report_members'];
			$results = null;
			if(isset($reports)){
				$results = $reports->xpath('taobaoke_report_member');
			}
			if((isset($results) && count($results) > 0)){
				foreach($reports->taobaoke_report_member as $item){
					$item = (array)$item;
					$item['pay_time'] = str2Time($item['pay_time']);
					$item['outer_code'] = isset($item['outer_code']) ? $item['outer_code'] : '';
					$pay_day = fToDate($item['pay_time'],'Y-m-d 00:00:00');
					$item['pay_day'] = str2Time($pay_day);
					$item['commission_rate'] = $item['commission_rate'] * 100;
					$item['item_title'] = addslashes($item['item_title']);

					if(!empty($item['outer_code']) && preg_match("/^o\d+$/",$item['outer_code'])){
						$order_id = (float)substr($item['outer_code'],1);
						if($order_id == 0){
							continue;
						}

						$bln = (int)FDB::resultFirst('SELECT COUNT(id) FROM '.FDB::table('taobaoke_report')." 
							WHERE outer_code = '".addslashes($item['outer_code'])."' 
								AND num_iid = '".addslashes($item['num_iid'])."' 
								AND pay_time = '".addslashes($item['pay_time'])."'");

						if($bln > 0){
							continue;
						}
						//FIXME frankie 考虑将该无用判断去除
						$res = FDB::query('SELECT * FROM '.FDB::table('goods_order').' 
							WHERE order_id = '.$order_id);
						
						while($order = FDB::fetch($res)){
							//淘宝tradeId存在, 且和淘宝客报表一致, 证明该订单已被处理, 跳过!
							if($order['out_trade_id'] == $item['trade_id']){
								continue;
							}
							
							$commission = ((float)$item['commission']) * ((float)$order['commission_rate'] / 100);
							
							//搜索子订单:
							// 1.遍历查询该子订单是否存在，是否已更新，存在并且未更新则更新订单的tradeId, status等字段
							// 2.子订单不存在，新建goods_order, 并设置tradeId, status等字段
							
							$res = FDB::query('SELECT * FROM '.FDB::table('goods_order').' WHERE keyid=\'taobao_'.$item['num_iid'].'\' AND uid='.$order['uid']);
							$o = null;
							$completed = false;
							while($t = FDB::fetch($res)){
								//if 遍历子订单, 存在该淘宝客报表中的tradeId, 证明该报表已被处理过
								//elseif 遍历子订单的tradeId为空全部为空,选取一个进行更新
								// else 遍历子订单的tradeId不为空, 且不为当前淘宝客报表中tradeId, 跳过
								if(empty($t['out_trade_id'])){
									$o = $t;
								}elseif($t['out_trade_id'] == $item['trade_id']){
									$completed = true;
								}else{
									continue;
								}
							}
							//该报表已处理则跳过，处理下一条报表数据
							if($completed){
								continue;
							}
								
							if(empty($o)){
								$req = new TaobaokeItemsDetailGetRequest;
								$req->setFields("num_iid,title,click_url,detail_url,num_iid");
								$req->setPid($_FANWE['cache']['business']['taobao']['tk_pid']);
								$req->setNumIids($item['num_iid']);
								
								$resp = (array)$client->execute($req);
								if((int)$resp['total_results'] > 0){
									$details = $resp['taobaoke_item_details'];
									$d = $details->taobaoke_item_detail;
									$i = $d->item;
									$o['click_url'] = (string)$d->click_url;
									$o['item_url'] = (string)$i->detail_url;
								}
								$orderId = FDB::insert('goods_order_index', array('id' => 'NULL', 'create_day' => getTodayTime()), true);
								$o['order_id'] = $orderId;
								$o['uid'] = $order['uid'];
								$o['type'] = 1;
								$o['status'] = 1;
								$o['is_pay'] = 0;
								$o['commission_rate'] = $order['commission_rate'];
								$o['commission'] = $commission;
								$o['title'] = $item['item_title'];
								$o['price'] = $item['real_pay_fee'];
								$o['keyid'] = 'taobao_'.$item['num_iid'];
								$o['out_trade_id'] = $item['trade_id'];
								$o['outer_code'] = $item['outer_code'];
								$o['create_time'] = TIME_UTC;
								FDB::insert('goods_order', $o, true);
							}else{
								FDB::query('UPDATE '.FDB::table('goods_order').' SET status = 1,out_trade_id='.$item['trade_id'].',outer_code=\''.$item['outer_code'].
								'\',settlement_time = '.TIME_UTC.',commission = '.$commission.',order_total = '.$item['real_pay_fee'].' WHERE order_id = '.$o['order_id'].' AND uid = '.(int)$o['uid']);
							}
							
							//用户返积分
							if($_FANWE['setting']['goods_buy_score_type'] > 0 && $_FANWE['setting']['goods_buy_score_rate'] > 0){
								$score = 0;
								$rate = (float)$_FANWE['setting']['goods_buy_score_rate'];
								//根据用户获得的佣金进行返积分
								$score = (float)$item['commission'] * $rate;
								$score = round($score);
								if($score > 0){
									FS('User')->updateUserScore((int)$order['uid'],'goods','commission','成功购买商品 '.$item['item_title'].' 获得积分',$order_id,$score);
								}
							}
							
							FDB::query('update '.FDB::table("user").' set is_lock=0 where uid='.$order['uid']);
							$is_insert = true;
						}
						
						if($is_insert){
							FDB::insert('taobaoke_report_temp',$item);
						}
					}
				}
			}
			//$page_size等于result的数量时，需要翻下一页
			if(count($results) == $page_size){
				$success = 0;
			}
			
			//(当前页数据量小于$page_size则插入数据，否则翻下一页)
			elseif((count($results) < $page_size) || (!isset($results) && $page > 1)){
				FDB::query('INSERT INTO '.FDB::table('taobaoke_report').'(id,trade_id,num_iid,item_title,item_num,pay_price,real_pay_fee,commission_rate,commission,outer_code,app_key,pay_time,pay_day) SELECT NULL AS id,trade_id,num_iid,item_title,item_num,pay_price,real_pay_fee,commission_rate,commission,outer_code,app_key,pay_time,pay_day FROM '.FDB::table('taobaoke_report_temp').' ORDER BY pay_time ASC,trade_id ASC');
			}
			
		}else{
			$success = -1;
		}
		return $success;
	}
}
?>