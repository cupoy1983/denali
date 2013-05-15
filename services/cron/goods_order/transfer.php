<?php
/**
 * 时间程序
 * 初始化goods_order中的price
 */
require ROOT_PATH.'core/fanwe.php';
$fanwe = &FanweService::instance();
$fanwe->is_session = false;
$fanwe->is_user = false;
$fanwe->is_cron = false;
$fanwe->is_misc = false;
$fanwe->cache_list = array();
$fanwe->initialize();

$_FANWE['request'] = unserialize(REQUEST_ARGS);

@ignore_user_abort(true);
@ob_start();
@ob_end_flush();
@ob_implicit_flush(true);
echo str_repeat(' ',4096);

$list = array();
$res = FDB::query("SELECT num_iid, real_pay_fee FROM ".FDB::table('taobaoke_report'));

while($data = FDB::fetch($res)){
	FDB::query("UPDATE ".FDB::table('goods_order')." SET order_total=".$data['real_pay_fee']. " where status=1 AND type=1 AND keyid='taobao_".$data['num_iid']."'");
}

?>