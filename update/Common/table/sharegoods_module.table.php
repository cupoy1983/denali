<?php
FDB::query('TRUNCATE TABLE '.FDB::table($tableTaget));
$res = $oldDB->query('SELECT * FROM '.$oldDB->tableName($tableTaget).' ORDER BY id ASC');
while($data = $oldDB->fetchArray($res))
{
	$data['class'] = trim($data['class']);
	if(in_array($data['class'],array('dangdang','jdbuy','vancl')))
		continue;
	
	$item = array();
	$item['class'] = addslashes($data['class']);
	$item['domain'] = addslashes($data['domain']);
	$item['status'] = (int)$data['status'];
	$item['name'] = addslashes($data['name']);
	$item['url'] = addslashes($data['url']);
	$item['icon'] = addslashes($data['icon']);
	$item['logo'] = addslashes($data['logo']);
	$item['content'] = addslashes($data['content']);
	
	$item['sort'] = (int)$data['sort'];
	if($item['class'] == 'taobao')
	{
		if($api_data  = @unserialize($data['api_data']))
		{
			$temp_data = array();
			$temp_data['app_key'] = $api_data['app_key'];
			$temp_data['app_secret'] = $api_data['app_secret'];
			$temp_data['tk_pid'] = $api_data['tk_pid'];
			$temp_data['session_key'] = $api_data['session_key'];
			$temp_data['expires_in'] = (int)$api_data['expires_in'];
			$item['api_data'] = addslashes(serialize($temp_data));
		}
		else
		{
			$item['api_data'] = 'a:5:{s:7:"app_key";s:0:"";s:10:"app_secret";s:0:"";s:6:"tk_pid";s:0:"";s:11:"session_key";s:0:"";s:10:"expires_in";i:0;}';
		}
	}
	else
		$item['api_data'] = addslashes($data['api_data']);
	
	FDB::insert($tableTaget,$item);
}

$item = array();
$item['class'] = 'yiqifa';
$item['domain'] = '';
$item['status'] = 1;
$item['name'] = '亿起发';
$item['url'] = 'http://www.yiqifa.com';
$item['icon'] = '';
$item['logo'] = '';
$item['content'] = '使用亿起发可通过接口获取当当、凡客、京东等近200个网站的商品数据（注：有少量商品可能无法获取到相关数据），访问 http://www.yiqifa.com/userRegEdit.do?regType=earner 注册成为网站主（注册时在推荐人处填写方维推荐，将有专门的客服人员进行维护），注册成功后进入 http://open.yiqifa.com 创建相关应用。(客服QQ：1153691793)';
$item['api_data'] = 'a:4:{s:7:"app_key";s:0:"";s:10:"app_secret";s:0:"";s:3:"uid";s:0:"";s:7:"site_id";s:0:"";}';
FDB::insert($tableTaget,$item);

showjsmessage(U('Index/updatetable',array('table'=>$tableIndex + 1)),5);
?>