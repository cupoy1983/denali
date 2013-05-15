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
	 * 获取上个月的带徒有功奖
	 */
	function friend(){
		global $_FANWE;
		$args = array();
		$args['type'] = 2;
		$uid = $_FANWE['uid'];
		$date = getdate(TIMESTAMP);
		if($date['mday'] < 15){
			showError("领取带徒有功奖失败", "请在每月15日之后领取带徒有功奖", FU('u/commission', $args));
		}
		$rate = (float)$_FANWE['user_group']['commission_rate'];
		if($rate <= 0){
			showError("领取带徒有功奖失败","领取带徒有功奖失败，请联系系统管理员，旺旺：贾斯特曼",FU('u/commission', $args));
		}
		$result = FS('commission')->getDiscipleReward($uid, $rate);
		
		if(!$result['success']){
			showError("领取带徒有功奖失败", $result['msg'], FU('u/commission', $args));
		}
		
		fHeader('location: '.FU('u/commission', $args));
	}
}

?>