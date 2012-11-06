<?php
$count = 0;
$res = $oldDB->query('SELECT * FROM '.$oldDB->tableName($tableTaget).' ORDER BY shop_id LIMIT '.$begin.','.$limit);
while($data = $oldDB->fetchArray($res))
{
	$count++;
	$shop_id = (int)$data['shop_id'];
	$shop_new = FDB::fetchFirst('SELECT * FROM '.FDB::table('shop').' WHERE shop_id = '.$shop_id);
	if(!$shop_new)
	{
		if(!empty($data['shop_logo']))
		{
			$img_id = addUpdateImage($data['shop_logo'],'shop',$data['server_code']);
			if($img_id > 0)
				$data['shop_logo'] = $img_id;
		}
		else
			$data['shop_logo'] = 0;
		$data['shop_name'] = addslashes($data['shop_name']);
		unset($data['server_code'],$data['data']);
		FDB::insert('shop',$data,false,true);
	}

	$shop_match = FS('Words')->segmentToUnicode($data['shop_name']);
	FDB::insert('shop_match',array('id'=>$shop_id,'shop_name'=>$shop_match),false,true);
	showjsmessage("转换店铺 ".$shop_id." 成功",2);
}

if($count == 0 || $count < $limit)
	$args = array('table'=>$tableIndex + 1);
else
	$args = array('table'=>$tableIndex,'begin'=>$begin + $limit);
	
$total = $oldDB->resultFirst('SELECT COUNT(shop_id) FROM '.$oldDB->tableName($tableTaget));
$count = $total - $begin - $limit;
if($count < 0)
	$count = 0;

showjsmessage("还有 <b style='color:#f00;'>".$count."</b> 个商品待转换",2);

showjsmessage(U('Index/updatetable',$args),5);
?>