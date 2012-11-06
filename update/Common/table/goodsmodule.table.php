<?php
$modules = array(
	'dangdang'=>array(
		'content'=>'优先级高于亿起发接口，使用正则式获取商品信息，如果因当当页面结构调整无法获取，请先禁用此商品采集模块，提交问题给我们进行处理，也可自行修改core\class\sharegoods\dangdang_sharegoods.class.php文件中的正则规则',
		'sql'=>'(\'dangdang\', \'http://product.dangdang.com\', 1, \'当当\', \'http://www.dangdang.com/\', \'./public/upload/business/dangdang.png\', \'\', \'优先级高于亿起发接口，使用正则式获取商品信息，如果因当当页面结构调整无法获取，请先禁用此商品采集模块，提交问题给我们进行处理，也可自行修改core\class\sharegoods\dangdang_sharegoods.class.php文件中的正则规则\', \'a:1:{s:4:"from";s:0:"";}\', 100)'
	),
	'vancl'=>array(
		'content'=>'优先级高于亿起发接口，使用正则式获取商品信息，如果因凡客页面结构调整无法获取，请先禁用此商品采集模块，提交问题给我们进行处理，也可自行修改core\class\sharegoods\vancl_sharegoods.class.php文件中的正则规则',
		'sql'=>'(\'vancl\', \'http://item.vancl.com,http://item.vjia.com\', 1, \'凡客\', \'http://www.vancl.com/\', \'./public/upload/business/vancl.png\', \'\', \'优先级高于亿起发接口，使用正则式获取商品信息，如果因凡客页面结构调整无法获取，请先禁用此商品采集模块，提交问题给我们进行处理，也可自行修改core\class\sharegoods\vancl_sharegoods.class.php文件中的正则规则\', \'a:1:{s:6:"Source";s:0:"";}\', 100)'
	),
	'jdbuy'=>array(
		'content'=>'优先级高于亿起发接口，使用正则式获取商品信息，如果因凡客页面结构调整无法获取，请先禁用此商品采集模块，提交问题给我们进行处理，也可自行修改core\class\sharegoods\vancl_sharegoods.class.php文件中的正则规则',
		'sql'=>'(\'jdbuy\', \'http://www.360buy.com\', 1, \'京东\', \'http://www.360buy.com/\', \'./public/upload/business/360buy.png\', \'\', \'优先级高于亿起发接口，使用正则式获取商品信息，如果因京东页面结构调整无法获取，请先禁用此商品采集模块，提交问题给我们进行处理，也可自行修改core\class\sharegoods\jdbuy_sharegoods.class.php文件中的正则规则，现只支持 http://www.360buy.com/product/***.html格式的商品\', \'a:1:{s:7:"unionId";s:0:"";}\', 100)'
	),
	'amazon'=>array(
		'content'=>'优先级高于亿起发接口，使用正则式获取商品信息，如果因亚马逊页面结构调整无法获取，请先禁用此商品采集模块，提交问题给我们进行处理，也可自行修改core\class\sharegoods\amazon_sharegoods.class.php文件中的正则规则',
		'sql'=>'(\'amazon\', \'http://www.amazon.cn\', 1, \'亚马逊\', \'http://www.amazon.cn/\', \'./public/upload/business/amazon.png\', \'\', \'优先级高于亿起发接口，使用正则式获取商品信息，如果因亚马逊页面结构调整无法获取，请先禁用此商品采集模块，提交问题给我们进行处理，也可自行修改core\class\sharegoods\amazon_sharegoods.class.php文件中的正则规则\', \'a:1:{s:3:"tag";s:0:"";}\', 100)'
	)
);

$res = FDB::query('SELECT * FROM '.FDB::table('sharegoods_module'));
while($data = FDB::fetch($res))
{
	if(isset($modules[$data['class']]))
	{
		unset($modules[$data['class']]);
		FDB::query('UPDATE '.FDB::table('share').' SET content = '.$modules[$data['class']]['content'].' WHERE id = '.$data['id']);
	}
}

$sql = 'INSERT INTO '.FDB::table('sharegoods_module').' (`class`, `domain`, `status`, `name`, `url`, `icon`, `logo`, `content`, `api_data`, `sort`) VALUES';
foreach($modules as $module)
{
	FDB::query($sql.$module['sql']);
}

showjsmessage("升级商品接口数据表成功",2);
showjsmessage(U('Index/updatetable',array('table'=>$tableIndex + 1)),5);
?>