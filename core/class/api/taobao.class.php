<?php
class Taobao{
	
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
	
	public function collectReport(){
		setTimeLimit(3600);
		global $_FANWE;
		
		FDB::query('TRUNCATE TABLE ' . FDB::table('taobaoke_report_temp'));
		
		$results = explode("\n", $_REQUEST['result']);
		
		if((isset($results) && count($results) > 0)){
			foreach($results as $result){
				$is_insert = false;
				$result = explode("\t", $result);
				if($result[4] != "订单结算"){
					continue;
				}
				$item['pay_time'] = str2Time($result[5]);
				$item['outer_code'] = '';
				$pay_day = fToDate($item['pay_time'], 'Y-m-d 00:00:00');
				$item['pay_day'] = str2Time($pay_day);
				$item['commission_rate'] = substr($result[7], 0, -1);
				$item['item_title'] = addslashes($result[1]);
				$item['num_iid'] = $result[10];
				$item['trade_id'] = $result[19];
				$item['commission'] = $result[13];
				$item['real_pay_fee'] = $result[6];
				
				$bln = (int)FDB::resultFirst("SELECT COUNT(id) FROM " . FDB::table('taobaoke_report') . " WHERE num_iid = " . $item['num_iid'] . " AND pay_time = " . $item['pay_time'] . " AND trade_id = " . $item['trade_id']);
				if($bln > 0){
					continue;
				}
				$res = FDB::query('SELECT * FROM ' . FDB::table('goods_order') . ' WHERE keyid = \'taobao_' . $item['num_iid'] . '\' AND status = 0');
				
				while($order = FDB::fetch($res)){
					//淘宝tradeId存在, 且和淘宝客报表一致, 证明该订单已被处理, 跳过!
					if($order['out_trade_id'] > 0){
						continue;
					}
					$e = FDB::resultFirst('SELECT count(*) FROM ' . FDB::table('goods_order') . ' WHERE keyid = \'taobao_' . $item['num_iid'] . '\' AND status = 1 AND out_trade_id = ' . $item['trade_id']);
					if($e > 0){
						continue;
					}
					$commission = ((float)$item['commission']) * ((float)$order['commission_rate'] / 100);
					FDB::query('UPDATE ' . FDB::table('goods_order') . ' SET status = 1,out_trade_id=' . $item['trade_id'] . ',outer_code=\'' . $item['outer_code'] . '\',settlement_time = ' . TIME_UTC . ',commission = ' . $commission . ',order_total = ' . $item['real_pay_fee'] . ' WHERE order_id = ' . $order['order_id'] . ' AND uid = ' . (int)$order['uid']);
					
					//用户返积分
					if($_FANWE['setting']['goods_buy_score_type'] > 0 && $_FANWE['setting']['goods_buy_score_rate'] > 0){
						$score = 0;
						$rate = (float)$_FANWE['setting']['goods_buy_score_rate'];
						//根据用户获得的佣金进行返积分
						$score = (float)$item['commission'] * $rate;
						$score = round($score);
						if($score > 0){
							FS('User')->updateUserScore((int)$order['uid'], 'goods', 'commission', '成功购买商品 ' . $item['item_title'] . ' 获得积分', $order["order_id"], $score);
						}
					}
					
					FDB::query('update ' . FDB::table("user") . ' set is_lock=0 where uid=' . $order['uid']);
					$is_insert = true;
				}
				
				if($is_insert){
					FDB::insert('taobaoke_report_temp', $item);
				}
			}
			FDB::query('INSERT INTO ' . FDB::table('taobaoke_report') . '(id,trade_id,num_iid,item_title,item_num,pay_price,real_pay_fee,commission_rate,commission,outer_code,app_key,pay_time,pay_day) SELECT NULL AS id,trade_id,num_iid,item_title,item_num,pay_price,real_pay_fee,commission_rate,commission,outer_code,app_key,pay_time,pay_day FROM ' . FDB::table('taobaoke_report_temp') . ' ORDER BY pay_time ASC,trade_id ASC');
		}
	}
}
?>