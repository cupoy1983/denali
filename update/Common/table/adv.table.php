<?php
FDB::query('TRUNCATE TABLE '.FDB::table($tableTaget));
$sql = 'INSERT INTO '.FDB::table($tableTaget).' SELECT * FROM '.$oldDB->tableName($tableTaget);
if(FDB::query($sql,'SILENT') === false)
{
	$res = $oldDB->query('SELECT * FROM '.$oldDB->tableName($tableTaget).' ORDER BY id ASC');
	while($data = $oldDB->fetchArray($res))
	{
		$item = array();
		$item['id'] = (int)$data['id'];
		$item['position_id'] = (int)$data['position_id'];
		$item['name'] = addslashes($data['name']);
		$item['code'] = addslashes( $data['code']);
		$item['type'] = (int)$data['type'];
		$item['status'] = (int)$data['status'];
		$item['url'] = addslashes($data['url']);
		$item['desc'] = addslashes($data['desc']);
		$item['target_key'] = addslashes($data['target_key']);
		$item['sort'] = (int)$data['sort'];
		$item['small'] = addslashes($data['small']);
		FDB::insert($tableTaget,$item,false,true);
	}
}
showjsmessage(U('Index/updatetable',array('table'=>$tableIndex + 1)),5);
?>