<?php
define('MODULE_NAME', 'Tgo');
define('ACTION_NAME', 'index');
require dirname(__FILE__) . '/core/fanwe.php';
require fimport('module/util');
$fanwe = &FanweService::instance();
$fanwe->cache_list = array(
		'user_group'
);
$fanwe->initialize();

$from = $_REQUEST["from"];
$url = null;
if(empty($from)){
	$url = base64_decode($_REQUEST['url']);
}else if($from == "fanli"){
	$url = $_REQUEST['url'];
}

if(!empty($url)){
	//fuid：发布宝贝用户id sid：分享的id gid：商品的id kid：商品的key
	$sid = 0;
	$gid = 0;
	$kid = '';
	if(isset($_REQUEST['args'])){
		$args = unserialize(base64_decode($_REQUEST['args']));
		if(! $args)
			exit();
		$sid = (int)$args['sid'];
		$gid = (int)$args['gid'];
		$kid = $args['kid'];
	}
	$item = $_REQUEST['item'];
	$title = $_REQUEST['title'];
	
	include dirname(__FILE__) . '/public/data/caches/system/setting.cache.php';
	$is_open_commission = (int)$data['setting']['is_open_commission'];
	
	if($is_open_commission == 1 && $sid > 0 && $gid > 0 && ! empty($kid)){
		
		$uid = $_FANWE['uid'];
		$order = array();
		$order['create_time'] = TIME_UTC;
		$order['keyid'] = addslashes($kid);
		
		$is_special = (int)$_FANWE['user_group']['is_special'];
		$rate = (float)$_FANWE['user_group']['buy_rate'];
		if($uid > 0 && $is_special == 0 && $rate > 0){
			
			$id = FDB::insert('goods_order_index', array('id' => 'NULL', 'create_day' => getTodayTime()), true);
			$goods = FS('Goods')->getById($gid);
			if($goods){
				$order['title'] = $goods['name'];
				$order['item_url'] = $goods['url'];
				$order['click_url'] = $goods['taoke_url'];
			}
			
			$order['order_id'] = $id;
			$order['commission_rate'] = $rate;
			$order['uid'] = $uid;
			$order['type'] = '1';
			FDB::insert('goods_order', $order);
		}
		
		if($id > 0){
			$url .= '&unid=o' . $id;
		}
	}else if($is_open_commission == 1 && ! empty($title) && ! empty($item)){
		$uid = $_FANWE['uid'];
		$order = array();
		$order['create_time'] = TIME_UTC;
		
		$is_special = (int)$_FANWE['user_group']['is_special'];
		$rate = (float)$_FANWE['user_group']['buy_rate'];
		if($uid > 0 && $is_special == 0 && $rate > 0){
				
			$id = FDB::insert('goods_order_index', array('id' => 'NULL', 'create_day' => getTodayTime()), true);
			$keyId = UtilModule::URL_getQuery($item, "id");
			$order['title'] = $title;
			$order['keyid'] = "taobao_".$keyId;
			$order['item_url'] = $item;
			$order['click_url'] = $url;
			$order['order_id'] = $id;
			$order['commission_rate'] = $rate;
			$order['uid'] = $uid;
			$order['type'] = '1';
			FDB::insert('goods_order', $order);
		}
		
		if($id > 0){
			$url .= '&unid=o' . $id;
		}
	}
}else{

	exit;
}

header('Location: ' . $url);
?>