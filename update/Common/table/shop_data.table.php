<?php
$count = 0;
$res = FDB::query('SELECT * FROM '.FDB::table('shop').' ORDER BY shop_id LIMIT '.$begin.','.$limit);
while($data = FDB::fetch($res))
{
	$count++;
	FS('Shop')->updateShopStatistic($data['shop_id']);
	showjsmessage("转换店铺 ".$data['shop_id']." 缓存成功",2);
}

if($count == 0 || $count < $limit)
	$args = array('table'=>$tableIndex + 1);
else
	$args = array('table'=>$tableIndex,'begin'=>$begin + $limit);
	
$total = FDB::resultFirst('SELECT COUNT(shop_id) FROM '.FDB::table('shop'));
$count = $total - $begin - $limit;
if($count < 0)
	$count = 0;

showjsmessage("还有 <b style='color:#f00;'>".$count."</b> 个店铺待缓存",2);

showjsmessage(U('Index/updatetable',$args),5);
?>