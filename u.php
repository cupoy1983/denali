<?php
define('MODULE_NAME','u');

$actions = array('index','me','book','fav','bao','photo','topic','talk','atme','comments','all','group','ask','follow','fans','feed','attention','message','sendmsg','msgview','exchange','album','commission','notic','look','dapei','sysmsg');

if(isset($_REQUEST['action']))
{
	$action = strtolower($_REQUEST['action']);
	if(!in_array($action,$actions))
		$action = 'index';
}

define('ACTION_NAME',$action);

require dirname(__FILE__).'/core/fanwe.php';
$fanwe = &FanweService::instance();
$fanwe->initialize();

$home_uid = intval($_FANWE['request']['uid']);
if($home_uid == 0)
	$home_uid = $_FANWE['uid'];

if($home_uid == 0)
	fHeader("location: ".FU('user/login'));

$action = ACTION_NAME;
$m_action = array('comments');
if(in_array($action,$m_action) && $home_uid != $_FANWE['uid'])
	fHeader("location: ".FU('u/talk',array('uid'=>$home_uid)));

if($action == 'index')
{
	if($home_uid == $_FANWE['uid'])
		fHeader("location: ".FU('u/me'));
	else
		fHeader("location: ".FU('u/talk',array('uid'=>$home_uid)));
}
elseif(in_array($action,array('exchange')))
{
	if($home_uid != $_FANWE['uid'])
		fHeader("location: ".FU('u/exchange',array('uid'=>$_FANWE['uid'])));
}
elseif(in_array($action,array('commission')))
{	
	if($_FANWE['setting']['is_open_commission'] == 0)
		fHeader("location: ".FU('index'));
		
	if($home_uid != $_FANWE['uid'])
		fHeader("location: ".FU('u/commission',array('uid'=>$_FANWE['uid'])));
}
elseif(in_array($action,array('atme')))
{
	if($home_uid != $_FANWE['uid'])
		fHeader("location: ".FU('u/atme',array('uid'=>$_FANWE['uid'])));
}
elseif(in_array($action,array('message','sendmsg','msgview')))
{
	if($home_uid != $_FANWE['uid'])
		fHeader("location: ".FU('u/message',array('uid'=>$_FANWE['uid'])));
}
elseif(in_array($action,array('notic')))
{
	if($home_uid != $_FANWE['uid'])
		fHeader("location: ".FU('u/notic',array('uid'=>$_FANWE['uid'])));
}


$_FANWE['home_uid'] = $home_uid;
$_FANWE['home_user_names'] = FS('User')->getUserShowName($home_uid);
if(empty($_FANWE['home_user_names']['name'])){
	fHeader("location: ".FU('index/index'));
}
$_FANWE['nav_title'] = $_FANWE['home_user_names']['name'].lang('common','space');
require fimport('module/u');

if(class_exists("UModule"))
{
	$module = new UModule();
	if(method_exists($module,$action))
	{
		call_user_func(array($module,$action));
	}
	else
	{
		die("error access");
	}
}
else
{
	die("error access");
}
?>