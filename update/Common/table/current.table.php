<?php
FDB::query('TRUNCATE TABLE '.FDB::table($tableTaget));
$sql = 'INSERT INTO '.FDB::table($tableTaget).' SELECT * FROM '.$oldDB->tableName($tableTaget);
FDB::query($sql,'SILENT');
showjsmessage(U('Index/updatetable',array('table'=>$tableIndex + 1)),5);
?>