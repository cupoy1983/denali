<?php
$res = $oldDB->query('SELECT * FROM '.$oldDB->tableName($tableTaget));
while($data = $oldDB->fetchArray($res))
{
	if($data['name'] != 'SYS_VERSION')
	{
		$item = array();
		$item['val'] = addslashes($data['val']);
		FDB::update($tableTaget,$item,"name = '".$data['name']."'");
	}
}
showjsmessage(U('Index/updatetable',array('table'=>$tableIndex + 1)),5);
?>