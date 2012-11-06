<?php
$sql = 'REPLACE INTO '.FDB::table($tableTaget).'(`gid`,`name`,`type`,`stars`,`color`,`icon`,`credits_higher`,`credits_lower`,`status`) SELECT `gid`,`name`,`type`,`stars`,`color`,`icon`,`credits_higher`,`credits_lower`,`status` FROM '.$oldDB->tableName($tableTaget);
FDB::query($sql,'SILENT');
showjsmessage(U('Index/updatetable',array('table'=>$tableIndex + 1)),5);
?>