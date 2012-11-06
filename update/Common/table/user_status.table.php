<?php
$item = $oldDB->fetchFirst('SELECT * FROM '.$oldDB->tableName($tableTaget).' LIMIT 0,1');
if($item)
{
	FDB::query('TRUNCATE TABLE '.FDB::table($tableTaget));
	if(isset($item['medals']))
		$sql = 'INSERT INTO '.FDB::table($tableTaget).' SELECT *,0,\'\' FROM '.$oldDB->tableName($tableTaget);
	else
		$sql = 'INSERT INTO '.FDB::table($tableTaget).' SELECT *,\'\',0,\'\' FROM '.$oldDB->tableName($tableTaget);
	FDB::query($sql,'SILENT');
}
showjsmessage(U('Index/updatetable',array('table'=>$tableIndex + 1)),5);
?>