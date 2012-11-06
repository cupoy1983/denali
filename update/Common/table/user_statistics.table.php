<?php
$item = $oldDB->fetchFirst('SELECT * FROM '.$oldDB->tableName($tableTaget).' LIMIT 0,1');
if($item && isset($item['last_time']))
{
	FDB::query('TRUNCATE TABLE '.FDB::table($tableTaget));
	$sql = 'INSERT INTO '.FDB::table($tableTaget).' SELECT * FROM '.$oldDB->tableName($tableTaget);
	FDB::query($sql,'SILENT');
}
showjsmessage(U('Index/updatetable',array('table'=>$tableIndex + 1)),5);
?>