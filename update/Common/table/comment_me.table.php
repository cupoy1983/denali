<?php
FDB::query('TRUNCATE TABLE '.FDB::table($tableTaget));
$sql = 'INSERT INTO '.FDB::table($tableTaget).' SELECT comment_id,share_id FROM '.$oldDB->tableName('share_comment');
FDB::query($sql,'SILENT');

$sql = 'UPDATE '.FDB::table($tableTaget).' SET uid = (SELECT uid FROM '.$oldDB->tableName('share').' WHERE share_id = '.FDB::table($tableTaget).'.share_id)';
FDB::query($sql,'SILENT');

showjsmessage(U('Index/updatetable',array('table'=>$tableIndex + 1)),5);
?>