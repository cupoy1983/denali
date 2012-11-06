<?php
$count = 0;
$res = FDB::query('SELECT * FROM '.FDB::table($tableTaget).' ORDER BY tid LIMIT '.$begin.','.$limit);
while($data = FDB::fetch($res))
{
	$count++;
	$content_match = FS('Words')->segmentToUnicode($data['title']);
	FDB::insert("forum_thread_match",array('tid'=>$data['tid'],'content'=>$content_match),false,true);
	showjsmessage("转换主题 ".$data['tid']." 成功",2);
}

if($count == 0 || $count < $limit)
	$args = array('table'=>$tableIndex + 1);
else
	$args = array('table'=>$tableIndex,'begin'=>$begin + $limit);
	
$total = FDB::resultFirst('SELECT COUNT(tid) FROM '.FDB::table($tableTaget));
$count = $total - $begin - $limit;
if($count < 0)
	$count = 0;
showjsmessage("还有 <b style='color:#f00;'>".$count."</b> 个主题待转换",2);

showjsmessage(U('Index/updatetable',$args),5);
?>