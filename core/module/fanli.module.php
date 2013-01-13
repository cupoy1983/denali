<?php
class FanLiModule{
	
	function index(){
		global $_FANWE;
		$_FANWE['nav_title'] = "返利查询";
		$cache_file = null;
		$cache_file = getTplCache('page/fanli/fanli_index');
		if(!@include($cache_file))
		{
			include template('page/fanli/fanli_index');
		}
		display($cache_file);
	}
	
	
	function friend(){
		global $_FANWE;
		$uid = $_FANWE['uid'];
		$sql = 'SELECT uid, user_name FROM '.FDB::table('user').' WHERE is_lock=0 AND invite_id='.$uid;
		$res = FDB::query($sql);
		$uids = array();
		while($friend = FDB::fetch($res)){
			$uids[] = $friend['uid'];
			$sql = 'SELECT order_id, commission FROM '.FDB::table('goods_order')." WHERE uid = "
					.$friend['uid']." AND status = 1 AND type = 1 AND is_pay = 1 AND hand_in_id = 0 ";
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
			$orderId = FDB::insert('goods_order_index', array('id' => 'NULL', 'create_day' => getTodayTime()), true);
			$order = array();
			$order['order_id'] = $orderId;
			$order['uid'] = $uid;
			$order['type'] = 2;
			$order['status'] = 1;
			$order['is_pay'] = 0;
			$order['commission_rate'] = 10;
			$order['commission'] = $amount/10;
			$order['title'] = "您介绍的朋友 ".$friend['user_name']." 在 ". fToDate(TIME_UTC,'Y-m-d')." 贡献给您的佣金";
			$order['create_time'] = TIME_UTC;
			
			FDB::insert('goods_order', $order, true);
			FDB::query('update '.FDB::table("goods_order").' set hand_in_id='.$orderId.' where order_id in ('.implode(',',$ids).')');
		}
		//锁定无返利订单的用户，在该用户订单返现完成后释放该锁
		if(!empty($uids)){
			FDB::query('update '.FDB::table("user").' set is_lock=1 where uid in ('.implode(',',$uids).')');
		}
	}
}

?>