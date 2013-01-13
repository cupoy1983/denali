<?php
define('MODULE_NAME', 'Fanli');

$actions = array(
		'index',
		'friend'
);
$action = 'index';
if(isset($_REQUEST['action'])){
	$action = strtolower($_REQUEST['action']);
	if(! in_array($action, $actions)){
		$action = 'index';
	}
}

define('Action_NAME', $action);

require dirname(__FILE__).'/core/fanwe.php';
$fanwe = &FanweService::instance();
$fanwe->initialize();

require fimport('module/fanli');

switch(Action_NAME) {
	
	case 'index' :
		FanLiModule::index();
		break;
		case 'friend' :
			FanLiModule::friend();
		break;
}

?>