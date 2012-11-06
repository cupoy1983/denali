<?php
$get_table = $oldDB->resultFirst("SHOW TABLES LIKE '".$oldDB->tableName('goods_category_tags')."'");
if(empty($get_table))
{
	showjsmessage(U('Index/updatetable',array('table'=>$tableIndex + 1)),5);
	exit;
}

FDB::query('TRUNCATE TABLE '.FDB::table('goods_category_tags'));
$sql = 'INSERT INTO '.FDB::table('goods_category_tags').' SELECT `cate_id`,`tag_id`,`weight`,0,0,100 FROM '.$oldDB->tableName('goods_category_tags');
FDB::query($sql,'SILENT');
showjsmessage(U('Index/updatetable',array('table'=>$tableIndex + 1)),5);
?>