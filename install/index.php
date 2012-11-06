<?php
// +----------------------------------------------------------------------
// | ThinkPHP
// +----------------------------------------------------------------------
// | Copyright (c) 2008 http://thinkphp.cn All rights reserved.
// +----------------------------------------------------------------------
// | Licensed ( http://www.apache.org/licenses/LICENSE-2.0 )
// +----------------------------------------------------------------------
// | Author: liu21st <liu21st@gmail.com>
// +----------------------------------------------------------------------
// $Id$

define('SUB_DIR','/install');
define('FANWE_ROOT',str_replace('\\', '/',substr(dirname(__FILE__), 0, -7)));
define('APP_NAME', 'install');
define('APP_PATH', './');
define('RUNTIME_PATH', FANWE_ROOT.'install/runtime/');
@ini_set('memory_limit', '128M');
require(FANWE_ROOT."admin/ThinkPHP/ThinkPHP.php");
?>