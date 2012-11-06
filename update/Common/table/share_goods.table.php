<?php
$item = $oldDB->fetchFirst('SELECT * FROM '.$oldDB->tableName($tableTaget).' LIMIT 0,1');
if($item)
{
	if(!isset($item['goods_key']))
		$oldDB->query('ALTER TABLE '.$oldDB->tableName($tableTaget).' ADD `goods_key` VARCHAR(60) NOT NULL DEFAULT \'\'');
}
showjsmessage(U('Index/updatetable',array('table'=>$tableIndex + 1)),5);
?>