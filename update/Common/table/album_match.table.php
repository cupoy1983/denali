<?php
$count = 0;
$res = FDB::query('SELECT * FROM '.FDB::table('album').' ORDER BY id LIMIT '.$begin.','.$limit);
while($data = FDB::fetch($res))
{
	$count++;
	$id = (int)$data['id'];
	$content_match = trim($data['title'].' '.$data['tags']);
	$content_match = FS('Words')->segmentToUnicode($content_match);
	FDB::insert("album_match",array('id'=>$id,'content'=>$content_match),false,true);
	
	FS('Album')->updateAlbum($id);
	showjsmessage("转换杂志社 ".$id." 成功",2);
}

if($count == 0 || $count < $limit)
	$args = array('table'=>$tableIndex + 1);
else
	$args = array('table'=>$tableIndex,'begin'=>$begin + $limit);

$total = FDB::resultFirst('SELECT COUNT(id) FROM '.FDB::table('album'));
$count = $total - $begin - $limit;
if($count < 0)
	$count = 0;
	
showjsmessage("还有 <b style='color:#f00;'>".$count."</b> 个杂志社待转换",2);
showjsmessage(U('Index/updatetable',$args),5);
?>