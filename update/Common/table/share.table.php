<?php
$count = 0;
$res = FDB::query('SELECT share_id,create_time FROM '.FDB::table('share').' ORDER BY share_id ASC LIMIT '.$begin.','.$limit);
while($data = FDB::fetch($res))
{
	$count++;
	$share_id = (int)$data['share_id'];
	$day_time = fToDate($data['create_time'],'Y-m-d 00:00:00');
	$day_time = str2Time($day_time);
	FDB::query('UPDATE '.FDB::table('share').' SET day_time = '.$day_time.' WHERE share_id = '.$share_id);
	FS('Share')->updateShareCache($share_id);
	showjsmessage("转换分享图片缓存 ".$share_id." 成功",2);
	usleep(10);
}

if($count == 0 || $count < $limit)
	$args = array('table'=>$tableIndex + 1);
else
	$args = array('table'=>$tableIndex,'begin'=>$begin + $limit);

$total = FDB::resultFirst('SELECT COUNT(share_id) FROM '.FDB::table('share'));
$count = $total - $begin - $limit;
if($count < 0)
	$count = 0;

showjsmessage("还有 <b style='color:#f00;'>".$count."</b> 个分享图片缓存待转换",2);
showjsmessage(U('Index/updatetable',$args),5);
?>