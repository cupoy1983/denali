<?php
// +----------------------------------------------------------------------
// | 方维购物分享网站系统 (Build on ThinkPHP)
// +----------------------------------------------------------------------
// | Copyright (c) 2011 http://fanwe.com All rights reserved.
// +----------------------------------------------------------------------
// | Licensed ( http://www.apache.org/licenses/LICENSE-2.0 )
// +----------------------------------------------------------------------
// | Author: awfigq <awfigq@qq.com>
// +----------------------------------------------------------------------
/**
 +------------------------------------------------------------------------------
 会员资金提现
 +------------------------------------------------------------------------------
 */
class UserAuctionLogAction extends CommonAction
{
	public function index()
	{
		$where = '';
		$parameter = array();
		$uname = trim($_REQUEST['uname']);
		$begin_time_str = trim($_REQUEST['begin_time']);
		$end_time_str = trim($_REQUEST['end_time']);
		
		$begin_time = !empty($begin_time_str) ? strZTime($begin_time_str) : 0;
		$end_time = !empty($end_time_str) ? strZTime($end_time_str) : 0;
		$status = trim($_REQUEST['status']);
		
		$is_empty = false;
		if(!empty($uname))
		{
			$this->assign("uname",$uname);
			$parameter['uname'] = $uname;
			$uid = (int)D('User')->where("user_name = '".$uname."'")->getField('uid');
			if($uid == 0)
				$is_empty = true;
			else
				$where.=" AND ual.uid = ".$uid;
		}
		
		if ($begin_time > 0)
		{
			$this->assign("begin_time",$begin_time_str);
			$parameter['begin_time'] = $begin_time_str;
			$where .= " AND ual.create_day >= '".$begin_time."'";
		}
		
		if ($end_time > 0)
		{
			$this->assign("end_time",$end_time_str);
			$parameter['end_time'] = $end_time_str;
			$where .= " AND ual.create_day < '".($end_time + 86400)."'";
		}
		
		if($status != "" && $status >= 0)
		{
			$this->assign("status",$status);
			$parameter['status'] = $status;
            $where .= ' AND ual.status = '.$status;
		}
		else
			$this->assign("status",-1);
		
		if(!$is_empty)
		{
			$model = M();
	
			if(!empty($where))
				$where = str_replace('WHERE AND','WHERE','WHERE'.$where);
	
			$sql = 'SELECT COUNT(ual.id) AS tcount
				FROM '.C("DB_PREFIX").'user_auction_log AS ual '.$where;
	
			$count = $model->query($sql);
			$count = $count[0]['tcount'];
	
			$sql = 'SELECT ual.*,u.user_name,u.money as user_money 
				FROM '.C("DB_PREFIX").'user_auction_log AS ual 
				LEFT JOIN '.C("DB_PREFIX").'user AS u ON u.uid = ual.uid '.$where;
			$this->_sqlList($model,$sql,$count,$parameter,'ual.id');
			$list = $this->list;
	
			$this->assign('list',$list);
		}
		$this->display();
		return;
	}
	
	public function show()
	{
		$id = intval($_REQUEST['id']);
		$order = D("UserAuctionLog")->where("id = $id")->find();
		$order['status_name'] = L("STATUS_".$order['status']);
		$order['pay_name'] = L("IS_PAY_".$order['is_pay']);
		if($order['is_pay'] == 0 && $order['pay_time'] > 0)
			$order['pay_name'] = L("IS_PAY_2");
			
		$this->assign ( 'order', $order );
		$user = D("User")->where("uid = ".$order['uid'])->find();
		$this->assign ('user',$user );
		$this->display ('show');
	}
	
	public function update()
	{
		$id = intval($_REQUEST['id']);
		$status = intval($_REQUEST['status']);
		$adm = trim($_REQUEST['adm']);
		
		$order = D("UserAuctionLog")->where("id = $id")->find();
		if(($order["is_pay"]==0 && $status==1)||($order["is_pay"]==1 && $status==2)){
			$this->error("状态转换出错");
		}else{
			$order['adm'] = $adm;
			$order['status'] = $status;
			D("UserAuctionLog")->save($order);
			$this->success (L('EDIT_SUCCESS'));
		}
	}
	
	public function toggleStatus(){
		vendor('common');
		$id = (float)$_REQUEST['id'];
		$val = intval($_REQUEST['val']) == 0 ? 1 : 0;
		$field = trim($_REQUEST['field']);
		if($id == 0 || empty($field) || $field != 'is_pay'){
			exit;
		}
		
		$order = D('UserAuctionLog')->where('id = '.$id)->find();
		$money = (float)$order['money'];
		$logType = null;
		//is_pay为相同状态不允许转换
		if($val == $order['is_pay']){
			$result['isErr'] = 1;
			$result['errMsg']="错误状态装换！";
			die(json_encode($result));
		}elseif($val == 1){
			$total = FS('User')->getUserMoney($order["uid"]);
			if($money > $total){
				$result['isErr'] = 1;
				$result['errMsg']="用户提现余额不足！";
				die(json_encode($result));
			}
			$money = -$money;
			$logType=3;
		}else{
			$logType=4;
		}
		
		$data = array($field=>$val,'pay_time'=>gmtTime());
		$result = array('isErr'=>0,'content'=>'');
		if(false !== D('UserAuctionLog')->where('id = '.$id)->setField($data)){
			$this->saveLog(1,$id,$field);
			$result['content'] = $val;
			$msg = L('PAY_'.$val);
			
			$log = array();
			$log['uid']=$order['uid'];
			$log['model']="UserAuctionLog";
			$log['action']="pay";
			$log['msg']=$msg;
			$log['order_id']=$id;
			$log['money']=$money;
			$log['type']=$logType;
			FS('User')->updateUserMoney($log);
		}else{
			$this->saveLog(0,$id,$field);
			$result['isErr'] = 1;
		}
		
		die(json_encode($result));
	}
	
	/**
	 * 会员充值
	 */
	public function charge(){
		$this->display();
	}
	/**
	 * 会员充值，操作user_money_log表
	 */
	public function doCharge(){

		$uid = intval($_REQUEST['uid']);
		$amount = intval($_REQUEST['amount']);
		if($uid <= 0 || $amount <= 0){
			$this->error("充值错误");
		}else{
			Vendor("common");
			
			$log['uid'] = $uid;
			$log['money'] = $amount;
			$log['create_time'] = TIME_UTC;
			$log['create_day'] = getTodayTime();
			$log['type'] = 0;
			$log['rec_id'] = 0;
			$log['rec_module'] = "userauctionlog";
			$log['rec_action'] = "charge";
			$log['content'] = "会员充值成功，充值金额".$amount."元";
			$success = FDB::insert('user_money_log',$log);
			if(!empty($success)){
				FDB::query("UPDATE ".FDB::table('user')." SET money = money + ".(float)$amount." WHERE uid = $uid", 'UNBUFFERED');
			}
			
			$this->success ("充值成功");
		}
	}
	/**
	 * 充值列表，操作user_money_log表
	 */
	public function listCharge(){
		$where = 'where type=0';
		$model = M();
		
		$sql = 'SELECT COUNT(id) AS tcount FROM '.C("DB_PREFIX").'user_money_log '.$where;
		$count = $model->query($sql);
		$count = $count[0]['tcount'];
		
		$sql = 'SELECT * FROM '.C("DB_PREFIX").'user_money_log '.$where;
		$list = $this->_sqlList($model,$sql,$count);
		foreach($list as &$t){
			$uid = $t['uid'];
			$user_nick = D('User')->where("uid = '".$uid."'")->getField('user_name');
			$t['user_nick'] = $user_nick;
		}
		$this->assign ( 'list', $list );
		$this->display();
		return;
	}
}

function getHandlerStatus($status)
{
	return L("STATUS_".$status);
}

function getIsEdit($id,$status)
{
	if($status == 0)
		return "<a href='javascript:showMoneyLog(".$id.");'>". L('EDIT')."</a>&nbsp;&nbsp;<a href=\"javascript:;\" onclick=\"removeData(this,'$id','id')\">". L('REMOVE')."</a>";
	elseif ($status == 1)
		return "<a href='javascript:showMoneyLog(".$id.");'>". L('VIEW')."</a>";
	else
		return "<a href='javascript:showMoneyLog(".$id.");'>". L('VIEW')."</a>&nbsp;&nbsp;<a href=\"javascript:;\" onclick=\"removeData(this,'$id','id')\">". L('REMOVE')."</a>";
}
?>