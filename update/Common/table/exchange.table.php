<?php
$count = 0;
$res = FDB::query('SELECT id,img FROM '.FDB::table('exchange_goods').' ORDER BY id ASC LIMIT '.$begin.','.$limit);
while($data = FDB::fetch($res))
{
	$count++;
	$id = (int)$data['id'];
	$goods = array();
	$goods['apply_type'] = 1;
	$goods['img_id'] = 0;
	if(!empty($data['img']))
	{
		$image = array();
		$image['type'] = 'share';
		$image['src'] = FANWE_ROOT.$data['img'];
		$image = FS('Image')->addImage($image);
		$goods['img_id'] = $image['id'];
	}
	FDB::update('exchange_goods',$goods,'id = '.$id);
	showjsmessage("转换兑换商品 ".$id." 成功",2);
	usleep(10);
}

if($count == 0 || $count < $limit)
{
	FDB::query("ALTER TABLE ".FDB::table('exchange_goods')." DROP COLUMN `img`");
	$args = array('table'=>$tableIndex + 1);
}
else
	$args = array('table'=>$tableIndex,'begin'=>$begin + $limit);

$total = FDB::resultFirst('SELECT COUNT(id) FROM '.FDB::table('exchange_goods'));
$count = $total - $begin - $limit;
if($count < 0)
	$count = 0;

showjsmessage("还有 <b style='color:#f00;'>".$count."</b> 个兑换商品待转换",2);
showjsmessage(U('Index/updatetable',$args),5);
?>