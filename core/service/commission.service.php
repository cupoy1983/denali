<?php
// +----------------------------------------------------------------------
// | 方维购物分享网站系统 (Build on ThinkPHP)
// +----------------------------------------------------------------------
// | Copyright (c) 2011 http://fanwe.com All rights reserved.
// +----------------------------------------------------------------------

/**  
 * commission.service.php
 *
 * 佣金服务
 *
 * @package class
 * @author awfigq <awfigq@qq.com>
 */
class CommissionService{
	
	public function runCron($crons){
		FS('Cron')->createRequest(array('m'=>'goods_order','a'=>'taobao'),true);
			
		$cron = array();
		$cron['server'] = 'commission';
		$cron['run_time'] = getTodayTime() + 86400;
		FDB::insert('cron',$cron);
	}
	
	public function reward($users){
		$orderId = FDB::insert('goods_order_index', array('id' => 'NULL', 'create_day' => getTodayTime()), true);
		$order = array();
		$order['order_id'] = $orderId;
		$order['uid'] = $users['from']['uid'];
		$order['type'] = 3;
		$order['status'] = 1;
		$order['is_pay'] = 0;
		$order['commission_rate'] = 0;
		$order['commission'] = 3;
		$order['title'] = "您介绍的朋友 ".$users['me']['nick']." 在 ". fToDate(TIME_UTC,'Y-m-d')." 注册成功给您的奖励";
		$order['create_time'] = TIME_UTC;
		FDB::insert('goods_order', $order, true);
		
		$orderId = FDB::insert('goods_order_index', array('id' => 'NULL', 'create_day' => getTodayTime()), true);
		$order = array();
		$order['order_id'] = $orderId;
		$order['uid'] = $users['me']['uid'];
		$order['type'] = 4;
		$order['status'] = 1;
		$order['is_pay'] = 0;
		$order['commission_rate'] = 0;
		$order['commission'] = 3;
		$order['title'] = $users['me']['nick']." 感谢您在".fToDate(TIME_UTC,'Y-m-d')."成功注册妖精猫 ";
		$order['create_time'] = TIME_UTC;
		FDB::insert('goods_order', $order, true);
	}
}
?>