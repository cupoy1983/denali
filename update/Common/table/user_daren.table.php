<?php
$sql = 'REPLACE INTO '.FDB::table($tableTaget).'(`id`,`uid`,`img`,`gift_name`,`gift_url`,`sponsor_name`,`sponsor_url`,`is_best`,`is_index`,`index_img`,`day_time`,`reason`,`create_time`) SELECT `id`,`uid`,`img`,`gift_name`,`gift_url`,`sponsor_name`,`sponsor_url`,`is_best`,`is_index`,`index_img`,`day_time`,`reason`,`create_time` FROM '.$oldDB->tableName($tableTaget);
FDB::query($sql,'SILENT');
showjsmessage(U('Index/updatetable',array('table'=>$tableIndex + 1)),5);
?>