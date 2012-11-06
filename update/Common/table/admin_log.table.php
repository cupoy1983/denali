<?php
$sql = 'REPLACE INTO '.FDB::table($tableTaget).' SELECT *,\'\' FROM '.$oldDB->tableName($tableTaget);
if(FDB::query($sql,'SILENT') === false)
{
	$sql = 'REPLACE INTO '.FDB::table($tableTaget).' SELECT * FROM '.$oldDB->tableName($tableTaget);
	FDB::query($sql,'SILENT');
}
showjsmessage(U('Index/updatetable',array('table'=>$tableIndex + 1)),5);
?>