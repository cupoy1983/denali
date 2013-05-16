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
		//1.佣金计算时间程序
		//FIXME frankie 修改前暂时关闭
		//FS('Cron')->createRequest(array('m'=>'goods_order','a'=>'taobao'),true);
		
		//2.每月执行三次，计算每月师傅奖励，并计算其各个徒弟的资金明细单(每月18-20日运行)
		$date = getdate(TIMESTAMP);
		if($date['mday'] >= 18 && $date['mday'] <= 20){
			FS('Cron')->createRequest(array('m'=>'goods_order','a'=>'month'),true);
		}
		
		$cron = array();
		$cron['server'] = 'commission';
		$cron['run_time'] = getTodayTime() + 86400;
		FDB::insert('cron',$cron);
	}
	
	/**
	 * 邀请徒弟注册双方都获得现金奖励
	 */
	public function reward($users){
		$orderId = FDB::insert('goods_order_index', array('id' => 'NULL', 'create_day' => getTodayTime()), true);
		$order = array();
		$order['order_id'] = $orderId;
		$order['uid'] = $users['from']['uid'];
		$order['type'] = 3;
		$order['status'] = 1;
		$order['is_pay'] = 0;
		$order['commission_rate'] = 0;
		$order['commission'] = 2;
		$order['title'] = "您的徒弟 ".$users['me']['nick']." ". fToDate(TIME_UTC,'Y-m-d')." 注册给您的奖励，期待您对他耐心指导！";
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
		$order['commission'] = 2;
		$order['title'] = $users['me']['nick']." 感谢您在".fToDate(TIME_UTC,'Y-m-d')."成功注册妖精猫 ";
		$order['create_time'] = TIME_UTC;
		FDB::insert('goods_order', $order, true);
	}
	
	/**
	 * 1.获取带徒有功奖
	 * 2.获取徒弟的资金明细情况
	 */
	public function getDiscipleReward($uid, $rate){
		
		$result = array('success' => false, 'msg' => '');
		
		//m1上个月第一秒的utc  m2本月第一秒的utc
		$m1 = mktime(0,0,0,date("m",time())-1,1,date("Y",time()));
		$m2 = mktime(0,0,0,date("m",time()),1,date("Y",time()));
		
		//该用户当月已领取带徒有功奖，则不进行生成，否则取出最后一次生成奖励的时间
		$sql = 'SELECT create_time FROM '.FDB::table('goods_order')." WHERE uid = "
		.$uid." AND status = 1 AND type = 2 ORDER BY create_time DESC";
		$last = intval(FDB::resultFirst($sql));
		if($last > $m2){
			$result['msg'] = "亲，您本月已经领取过带徒有功奖，请下月再来领取！";
			return $result;
		}elseif(!empty($last)){
			$prefix = fToDate($last,'Y-m')." 至 ";
		}
		
		//该用户当月未有成交，则带徒有功奖比例降低，变为设定值的1/2
		$sql = 'SELECT count(order_id) FROM '.FDB::table('goods_order')." WHERE uid = "
		.$uid." AND status = 1 AND type = 1 AND is_pay = 1 AND pay_time > ".$m1." AND pay_time < ".$m2;
		$buy_count = intval(FDB::resultFirst($sql));
		if($buy_count === 0 ){
			$rate = $rate * 0.5;
		}
		
		//获取该用户的徒弟及徒弟的消费信息
		$sql = 'SELECT uid, user_name FROM '.FDB::table('user').' WHERE is_lock=0 AND invite_id='.$uid;
		$res = FDB::query($sql);
		$uids = array();
		while($disciple = FDB::fetch($res)){
			$uids[] = $disciple['uid'];
			$sql = 'SELECT order_id, commission, order_total FROM '.FDB::table('goods_order')." WHERE uid = "
			.$disciple['uid']." AND status = 1 AND type = 1 AND is_pay = 1 AND hand_in_id = 0 AND pay_time < ".$m2;
			$orders = FDB::query($sql);
			
			$mFee = 0;
			$mFan = 0;
			$amount = 0;
			$ids = array();
			while($o = FDB::fetch($orders)){
				$mFan = $mFan + $o['commission'];
				$mFee = $mFee + $o['order_total'];
				$ids[] = $o['order_id'];
			}
			if(empty($ids) || $mFan < 0.01){
				continue;
			}
				
			//金额小于0.01元，则累计到下次再生成。
			if(($mFan * $rate / 100) < 0.01){
				$result['msg'] = "当前佣金不足1分，请您累积到下个月再来领取";
				return $result;
			}else{
				$amount= $mFan * $rate / 100;
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
			$order['title'] = "您的徒弟 ".$disciple['user_name']." 表现突出，您获得 ".$prefix.fToDate($m1,'Y-m')." 的带徒有功奖";
			$order['create_time'] = TIME_UTC;
			
			//将该带徒有功奖录入师父账户
			FDB::insert('goods_order', $order, true);
			//获取该徒弟上个月的资金明细情况
			CommissionService::getCashDetail($disciple['uid'], $uid, $rate, $mFee, $mFan);
			//更新徒弟订单为已处理
			FDB::query('update '.FDB::table("goods_order").' set hand_in_id='.$orderId.' where order_id in ('.implode(',',$ids).')');
		}
		//锁定无返利订单的用户，在该用户订单返现完成后释放该锁
		if(!empty($uids)){
			FDB::query('update '.FDB::table("user").' set is_lock=1 where uid in ('.implode(',',$uids).')');
		}
		$result['success']=true;
		
		return $result;
	}
	
	/**
	 * 每月获取徒弟上个月的资金明细情况
	 */
	public function getCashDetail($uid, $invite_id, $rate, $mFee, $mFan){
		$result = array('success' => true, 'msg' => '');
		
		//m1本月第一秒的utc
		$m1 = mktime(0,0,0,date("m",time()),1,date("Y",time()));
		//查询该用户当月是否已获取过
		$order = FDB::fetchFirst("SELECT * FROM ".FDB::table('disciple_detail') ." WHERE status=1 AND uid=".$uid." ORDER BY gmt_create DESC");
		if(!empty($order)){
			$m = strtotime($order['gmt_create']);
			if($m > $m1){
				$result['success'] = false;
				$result['msg'] = "本月已完成资金明细情况统计";
				return $result;
			}
		}
		
		//当月非2月时并且上月数据不为空，不需要将年数据清零；否则清零
		if(!empty($order) && (int)date("n", $m1) != 2){
			$yFee = $mFee + $order['year_fee'];
			$yFan = $mFan + $order['year_fan'];
		}else{
			$yFee = $mFee;
			$yFan = $mFan;
		}
		
		$disciple = array();
		$disciple['uid'] = $uid;
		$disciple['master_id'] = $invite_id;
		$disciple['status'] = 1;
		$disciple['month_fee'] = $mFee;
		$disciple['month_fan']=$mFan;
		$disciple['year_fee']=$yFee;
		$disciple['year_fan']=$yFan;
		$disciple['master_rate']=$rate;
		$disciple['gmt_create'] = date('Y-m-d H:i:s');;
		$id = FDB::insert('disciple_detail', $disciple, true);
		//更新disciple，标记之前的徒弟资金明细为历史信息
		if($id>0 && isset($order['id'])){
			FDB::query('update '.FDB::table("disciple_detail").' set status=0 where id ='. $order['id']);
		}
	}
	
}
?>