<?php
FDB::query('TRUNCATE TABLE '.FDB::table($tableTaget));
$sql = 'REPLACE INTO '.FDB::table($tableTaget).'(`album_id`,`share_id`,`cid`) SELECT `album_id`,`share_id`,`cid` FROM '.$oldDB->tableName($tableTaget);
FDB::query($sql,'SILENT');

$sql = 'REPLACE INTO '.FDB::table('album_share_index').'(`album_id`,`share_id`,`cid`) SELECT `album_id`,`share_id`,`cid` FROM '.$oldDB->tableName($tableTaget);
FDB::query($sql,'SILENT');

FDB::query('UPDATE '.FDB::table('album_share_index').' SET collect_count = (SELECT collect_count FROM '.$oldDB->tableName('share').' WHERE share_id = '.FDB::table('album_share_index').'.share_id)','SILENT');
FDB::query($sql,'SILENT');

showjsmessage(U('Index/updatetable',array('table'=>$tableIndex + 1)),5);
?>