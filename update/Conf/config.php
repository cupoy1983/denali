<?php
if (!defined('THINK_PATH')) exit();
if(file_exists(FANWE_ROOT.'./public/db.global.php'))
	$db_config	=	require FANWE_ROOT.'./public/db.global.php';

$array=array(
	'APP_AUTOLOAD_PATH'     => '@.ORG.,Think.Util.',// __autoLoad 机制额外检测路径设置,注意搜索顺序
	'URL_MODEL'	=>	0,
	'DEFAULT_THEME'         =>'default',
	'DIRS_CHECK' => array(
		array('type'=>'file','path'=>'shou/shou.js'),
		array('type'=>'dir','path'=>'public/records/'),
		array('type'=>'dir','path'=>'public/seos/result/'),
		array('type'=>'dir','path'=>'public/table/anchor/'),
		array('type'=>'dir','path'=>'public/table/goodsDictionary/'),
		array('type'=>'file','path'=>'public/taobao/report.time.php'),
	),
);
if(is_array($db_config))
	$config = array_merge($array,$db_config);
else
	$config = $array;

return $config;
?>