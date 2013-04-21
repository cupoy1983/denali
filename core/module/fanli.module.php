<?php
class FanLiModule{
	
	function index(){
		global $_FANWE;
		$_FANWE['nav_title'] = "淘宝折扣查询-淘宝购物省钱之道";
		$rate = (float)$_FANWE['user_group']['buy_rate'];
		$users = FS('User')->getRandUsers(10);
		
		$t = time();
		$t1 = mktime(8,0,0,date( "m ",$t),date( "d ",$t),date( "Y ",$t));
		
		foreach($users as $key => $user){
			$users[$key]['money'] = rand(1,1000)/10;
			$t1 = $t1 + rand(1000,7200);
			$users[$key]['time'] = date("H:i:s",$t1);
		}
		
		$cache_file = null;
		$cache_file = getTplCache('page/fanli/fanli_index', array('rate'=>"rate_".$rate));
		if(!@include($cache_file)){
			include template('page/fanli/fanli_index');
		}
		display($cache_file);
	}
	
	/**
	 * 生成上个月的朋友佣金奖励
	 */
	function friend(){
		global $_FANWE;
		$args = array();
		$args['type'] = 2;
		$uid = $_FANWE['uid'];
		$rate = (float)$_FANWE['user_group']['buy_rate'];
		if($rate <= 0){
			showError("领取朋友佣金奖励失败","领取朋友佣金奖励失败，请联系系统管理员，旺旺：贾斯特曼",FU('u/commission', $args));
		}
		
		//m1上个月第一秒的utc  m2本月第一秒的utc
		$m1 = mktime(0,0,0,date("m",time())-1,1,date("Y",time()));
		$m2 = mktime(0,0,0,date("m",time()),1,date("Y",time()));
		
		//该用户当月已领取朋友佣金，则不进行生成，否则取出最后一次生成佣金的时间
		$sql = 'SELECT create_time FROM '.FDB::table('goods_order')." WHERE uid = "
				.$uid." AND status = 1 AND type = 2 ORDER BY create_time DESC";
		$last = intval(FDB::resultFirst($sql));
		if($last > $m2){
			showError("亲，您本月已经领取过朋友佣金奖励，请下月再来领取！",FU('u/commission', $args));
		}elseif(!empty($last)){
			$prefix = fToDate($last,'Y-m')." 至 ";
		}
		
		//该用户当月未有成交，则朋友佣金比例降低，变为设定值的1/3
		$sql = 'SELECT count(order_id) FROM '.FDB::table('goods_order')." WHERE uid = "
				.$uid." AND status = 1 AND type = 1 AND is_pay = 1 AND pay_time > ".$m1." AND pay_time < ".$m2;
		$buy_count = intval(FDB::resultFirst($sql));
		if($buy_count === 0 ){
			$rate = $rate * 0.3;
		}
		$sql = 'SELECT uid, user_name FROM '.FDB::table('user').' WHERE is_lock=0 AND invite_id='.$uid;
		$res = FDB::query($sql);
		$uids = array();
		while($friend = FDB::fetch($res)){
			$uids[] = $friend['uid'];
			
			$sql = 'SELECT order_id, commission FROM '.FDB::table('goods_order')." WHERE uid = "
					.$friend['uid']." AND status = 1 AND type = 1 AND is_pay = 1 AND hand_in_id = 0 AND pay_time > "
					.$m1." AND pay_time < ".$m2;
			$orders = FDB::query($sql);
			$amount = 0;
			$ids = array();
			while($o = FDB::fetch($orders)){
				$amount = $amount + $o['commission'];
				$ids[] = $o['order_id'];
			}
			if(empty($ids) || $amount < 0.01){
				continue;
			}
			
			//金额小于0.01元，则累计到下次再生成。
			if(($amount * $rate / 100) < 0.01){
				showError("领取朋友佣金奖励失败","当前佣金不足1分，请您累积到下个月再来领取",FU('u/commission', $args));
			}else{
				$amount= $amount * $rate / 100;
			}
			$orderId = FDB::insert('goods_order_index', array('id' => 'NULL', 'create_day' => getTodayTime()), true);
			$order = array();
			$order['order_id'] = $orderId;
			$order['uid'] = $uid;
			$order['type'] = 2;
			$order['status'] = 1;
			$order['is_pay'] = 0;
			$order['commission_rate'] = $rate;
			$order['commission'] = $amount;
			$order['title'] = "您介绍的朋友 ".$friend['user_name']." 在 ".$prefix.fToDate($m1,'Y-m')." 贡献给您的佣金";
			$order['create_time'] = TIME_UTC;
			
			FDB::insert('goods_order', $order, true);
			FDB::query('update '.FDB::table("goods_order").' set hand_in_id='.$orderId.' where order_id in ('.implode(',',$ids).')');
		}
		//锁定无返利订单的用户，在该用户订单返现完成后释放该锁
		if(!empty($uids)){
			FDB::query('update '.FDB::table("user").' set is_lock=1 where uid in ('.implode(',',$uids).')');
		}
		fHeader('location: '.FU('u/commission', $args));
	}
}

?>