<?php
$count = 0;
$res = FDB::query('SELECT id FROM '.FDB::table('album').' ORDER BY id ASC LIMIT '.$begin.','.$limit);
while($data = FDB::fetch($res))
{
	$count++;
	$id = (int)$data['id'];
	FS('Album')->updateAlbum($id);
	showjsmessage("转换杂志社图片缓存 ".$id." 成功",2);
	usleep(10);
}

if($count == 0 || $count < $limit)
	$args = array('table'=>$tableIndex + 1);
else
	$args = array('table'=>$tableIndex,'begin'=>$begin + $limit);

$total = FDB::resultFirst('SELECT COUNT(id) FROM '.FDB::table('album'));
$count = $total - $begin - $limit;
if($count < 0)
	$count = 0;

showjsmessage("还有 <b style='color:#f00;'>".$count."</b> 个杂志社图片缓存待转换",2);
showjsmessage(U('Index/updatetable',$args),5);
?>