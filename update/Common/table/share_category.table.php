<?php
FDB::query('TRUNCATE TABLE '.FDB::table($tableTaget));
$sql = 'INSERT INTO '.FDB::table($tableTaget).'(share_id,cate_id) SELECT share_id,cate_id FROM '.$oldDB->tableName($tableTaget);
FDB::query($sql,'SILENT');

$sql = 'UPDATE '.FDB::table($tableTaget).' SET uid = (SELECT uid FROM '.$oldDB->tableName('share').' WHERE share_id = '.FDB::table($tableTaget).'.share_id)';
FDB::query($sql,'SILENT');

Cache::getInstance()->updateCache('goodscate');

showjsmessage(U('Index/updatetable',array('table'=>$tableIndex + 1)),5);
?>