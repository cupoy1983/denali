<?php
/**
 * 时间程序
 * 每月初执行三次，计算每月师傅奖励，并计算其各个徒弟的资金明细单
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

$pageSize = 50;
//正常状态且不为测试组用户
$where=" WHERE status=1 AND gid!=8 ";
$sql = 'SELECT COUNT(uid) FROM '.FDB::table('user') . $where;
$amount = FDB::resultFirst($sql);
$count = (int)($amount / $pageSize) + 1;
//获取组Id及对应的佣金比率
$list = array();
$res = FDB::query("SELECT gid, commission_rate FROM ".FDB::table('user_group')." WHERE status = 1 ORDER BY gid ASC");
while($data = FDB::fetch($res)){
	$list[$data['gid']] = $data['commission_rate'];
}
for($i=1; $i<=$count; $i++){
	$res = FDB::query("SELECT uid, gid FROM ".FDB::table('user') .$where." LIMIT ".($i-1) * $pageSize. ", ". $pageSize);
	while($u = FDB::fetch($res)){
		$rate = $list[$u['gid']];
		FS('commission')->getDiscipleReward($u['uid'], $rate);
	}
}

?>