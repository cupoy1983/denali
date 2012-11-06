<?php
$count = 0;
$res = FDB::query('SELECT * FROM '.FDB::table('share_look_index').' GROUP BY uid ORDER BY uid ASC LIMIT '.$begin.','.$limit);
while($data = FDB::fetch($res))
{
	$count++;
	FS('Look')->setUserCache($data['uid']);
	showjsmessage("转换会员 ".$data['uid']." 晒货缓存成功",2);
}

if($count == 0 || $count < $limit)
	$args = array('table'=>$tableIndex + 1);
else
	$args = array('table'=>$tableIndex,'begin'=>$begin + $limit);

$total = FDB::resultFirst('SELECT COUNT(DISTINCT uid) FROM '.FDB::table('share_look_index'));
$count = $total - $begin - $limit;
if($count < 0)
	$count = 0;
	
showjsmessage("还有 <b style='color:#f00;'>".$count."</b> 个会员的晒货待缓存",2);
showjsmessage(U('Index/updatetable',$args),5);
?>