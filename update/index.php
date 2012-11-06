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

define('SUB_DIR','/update');
define('FANWE_ROOT',str_replace('\\', '/',substr(dirname(__FILE__), 0, -6)));
define('APP_NAME', 'update');
define('APP_PATH', './');
@ini_set('memory_limit', '128M');
define('RUNTIME_PATH', FANWE_ROOT.'update/runtime/');
require(FANWE_ROOT."admin/ThinkPHP/ThinkPHP.php");
?>