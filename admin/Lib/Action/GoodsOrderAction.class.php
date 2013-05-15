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
 会员佣金列表
 +------------------------------------------------------------------------------
 */
class GoodsOrderAction extends CommonAction
{
	public function index()
	{
		$where = '';
		$parameter = array();
		$uname = trim($_REQUEST['uname']);
		$commission_id = trim($_REQUEST['commission_id']);
		$status = (int)$_REQUEST['status'];
		
		$is_empty = false;
		if(!empty($uname))
		{
			$this->assign("uname",$uname);
			$parameter['uname'] = $uname;
			$uid = (int)D('User')->where("user_name = '".$uname."'")->getField('uid');
			if($uid == 0)
				$is_empty = true;
			else
				$where.=" AND uid = ".$uid;
		}
		
		if (!empty($commission_id) && preg_match("/^o\d+$/",$commission_id))
		{
			$this->assign("commission_id",$commission_id);
			$parameter['outer_code'] = $commission_id;
			$where .= " AND outer_code = '".$commission_id."'";
		}
		
		if($status > 0)
		{
			if($status == 1)
				$where .= " AND status = 1 AND is_pay = 0";
			elseif($status == 2)
				$where .= " AND is_pay = 1";
			
			$this->assign("status",$status);
			$parameter['status'] = $status;
		}
		
		if(!$is_empty)
		{
			$model = M();

			if(!empty($where))
				$where = str_replace('WHERE AND','WHERE','WHERE'.$where);

			$sql = 'SELECT COUNT(DISTINCT order_id) AS tcount
				FROM '.C("DB_PREFIX").'goods_order '.$where;

			$count = $model->query($sql);
			$count = $count[0]['tcount'];
			
			if($count > 0)
			{
				$sql = 'SELECT * FROM '.C("DB_PREFIX").'goods_order '.$where;
				$this->_sqlList($model,$sql,$count,$parameter,'order_id');
				$list = $this->list;
				
				$orders = array();
				$users = array();
				$goods_ids = array();
				foreach($list as $k=>$v)
				{
					$goods_ids[$v['goods_id']] = '';
					$list[$k]['status'] = L('STATUS_'.$v['status']);
					if($v['settlement_time'] > 0){
						$list[$k]['settlement_time'] = toDate($v['settlement_time'],'Y-m-d').'<br/>'.toDate($v['settlement_time'],'H:i:s');
					}else{
						$list[$k]['settlement_time'] = '&nbsp;';
					}
					$list[$k]['create_time'] = toDate($v['create_time'],'Y-m-d').'<br/>'.toDate($v['create_time'],'H:i:s');
					
					$users[$v['uid']] = '';
					$commission = (float)$v['commission'] > 0 ? (float)$v['commission'] : L('GET_COMMISSION');
					$pay_time = L('NO_PAY');
					if($v['pay_time'] > 0){
						$pay_time = L('PAY_TIME_'.$v['is_pay']).':'.toDate($v['pay_time']);
					}
					$type = L('TYPE_'.$v['type']);
					
					$list[$k]['goods_name']  = '<a href="'.$v['item_url'].'" target="_blank">'.$v['title'].'</a>';
					$list[$k]['cuser']['uid'] = $v['uid'];
					$list[$k]['cuser']['name'] = &$users[$v['uid']];
					$list[$k]['cuser']['commission'] = $commission;
					$list[$k]['cuser']['is_commission'] = (float)$v['commission'] > 0 ? true : false;
					$list[$k]['cuser']['is_pay'] = $v['is_pay'];
					$list[$k]['cuser']['commission_rate'] = (float)$v['commission_rate'].'%';
					$list[$k]['cuser']['pay_time'] = $pay_time;
					$list[$k]['cuser']['type'] = $type;
					
				}
				
				$where = array();
				$where['uid'] = array('in',array_keys($users));
				$temps = D('User')->where($where)->field('uid,user_name')->select();
				foreach($temps as $temp)
				{
					$users[$temp['uid']] = $temp['user_name'];
				}
			}
		}
		else
			$list = array();

		$this->assign('list',$list);
		$this->display();
		return;
	}

	public function remove() {
		//删除指定记录
		$result = array('isErr'=>0,'content'=>'');
		$id = $_REQUEST['id'];
		if(!empty($id))
		{
			$condition = array ('order_id' => array ('in', explode ( ',', $id ) ) );
			if(false !== D('GoodsOrder')->where ( $condition )->delete ())
			{
				$condition = array ('id' => array ('in', explode ( ',', $id ) ) );
				D('GoodsOrderIndex')->where($condition)->delete();
				$this->saveLog(1,$id);
			}
			else
			{
				$this->saveLog(0,$id);
				$result['isErr'] = 1;
				$result['content'] = L('REMOVE_ERROR');
			}
		}
		else
		{
			$result['isErr'] = 1;
			$result['content'] = L('ACCESS_DENIED');
		}
		
		die(json_encode($result));
	}

	public function toggleStatus()
	{
		$id = (float)$_REQUEST['id'];
		$uid = (float)$_REQUEST['uid'];
		$val = intval($_REQUEST['val']) == 0 ? 1 : 0;
		$field = trim($_REQUEST['field']);
		if($id == 0 || $uid == 0 || empty($field)){
			exit;
		}
		
		$data = array($field=>$val,'pay_time'=>gmtTime());
		$result = array('isErr'=>0,'content'=>'');
		if(false !== D('GoodsOrder')->where('order_id = '.$id.' AND uid = '.$uid)->setField($data))
		{
			$this->saveLog(1,$id,$field);
			$result['content'] = $val;
			if($field == 'is_pay')
			{
				$order = D('GoodsOrder')->where('order_id = '.$id.' AND uid = '.$uid)->find();
				$msg = L('PAY_'.$val);
				$money = (float)$order['commission'];
				$log = array();
				if($val == 0){
					$money = -$money;
					$log['type']=2;
				}else{
					$log['type']=1;
				}

				if($order['type'] == 1){
					$action = 'buy';
				}
				if(empty($order['item_url'])){
					$msg .= '&nbsp;'.':'.'<a>'.$order['title'].'</a>';
				}else{
					$msg .= '&nbsp;'.L('GOODS').':'.'<a href="'.$order['item_url'].'" target="_blank">'.$order['title'].'</a>&nbsp;'.L('TYPE_'.$order['type']);
				}	
				
				vendor('common');
				
				$log['uid']=$uid;
				$log['model']="GoodsOrder";
				$log['action']=$action;
				$log['msg']=$msg;
				$log['order_id']=$id;
				$log['money']=$money;
				FS('User')->updateUserMoney($log);
			}
		}
		else
		{
			$this->saveLog(0,$id,$field);
			$result['isErr'] = 1;
		}
		
		die(json_encode($result));
	}
}
?>