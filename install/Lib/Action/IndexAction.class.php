<?php
// +----------------------------------------------------------------------
// | Fanwe 多语商城建站系统 (Build on ThinkPHP)
// +----------------------------------------------------------------------
// | Copyright (c) 2009 http://www.fanwe.com All rights reserved.
// +----------------------------------------------------------------------
// | Licensed ( http://www.apache.org/licenses/LICENSE-2.0 )
// +----------------------------------------------------------------------
// | Author: 云淡风轻(97139915@qq.com)
// +----------------------------------------------------------------------


//系统安装
class IndexAction extends Action{
	private $install_lock;
	public function __construct()
	{
		import("ORG.Io.Dir");
		parent::__construct();
		$this->install_lock = FANWE_ROOT."public/install.lock";
	}

    public function index()
    {
		clear_cache();
		//系统安装
		if(file_exists($this->install_lock))
		{
			$this->assign("jumpUrl",__ROOT__."/index.php");
			$this->error("系统已经安装");
		}
		else
		{
			$this->assign("is_short_open_tag",ini_get('short_open_tag'));
			$_SESSION['from_items'] = "";
			$rs = $this->checkEnv();  //检测系统环境
			$this->assign("result",$rs);
			$this->display();//输出检测结果
		}
    }

    public function database()
    {
    	//系统安装
		if(file_exists($this->install_lock))
		{
			$this->assign("jumpUrl",__ROOT__."/admin.php");
			$this->error("系统已经安装");
		}
		else
		{
			$rs = $this->checkEnv();  //检测系统环境
			if($rs['status'])
			{
				if(isset($_SESSION['from_items']) && !empty($_SESSION['from_items']))
					$froms = $_SESSION['from_items'];
				else
				{
					$froms = C("FROM_ITEMS");
				}

				$this->assign("froms",$froms);
				$this->assign("DEMO_DATA",1);
				$this->display();
			}
			else
			{
				$this->assign("result",$rs);
				$this->display("index");//输出检测结果
			}
		}
    }

    public function install()
    {
        @set_time_limit(3600);
        if(function_exists('ini_set'))
            ini_set('max_execution_time',3600);

		$from_items = C("FROM_ITEMS");
		$submit = true;
		$error_msg = array();

		foreach($from_items as $key => $items)
		{
			if(isset($_REQUEST[$key]) && is_array($_REQUEST[$key]))
			{
				foreach($items as $k => $v)
				{
					$from_items[$key][$k]['value'] = $_REQUEST[$key][$k];

					if(empty($_REQUEST[$key][$k]) || !preg_match($v['reg'],$_REQUEST[$key][$k]))
					{
						if(empty($_REQUEST[$key][$k]) && !$v['required'])
							continue;
						else
						{
							$submit = false;
							$from_items[$key][$k]['error'] = 1;
						}
					}
				}
			}
		}

		if($from_items['admin']['ADM_PWD']['error'] == 1)
		{
			$from_items['admin']['ADM_PWD2']['error'] = 0;
		}
		else
		{
			$from_items['admin']['ADM_PWD']['notice'] = '';

			if($_REQUEST['admin']['ADM_PWD'] != $_REQUEST['admin']['ADM_PWD2'])
			{
				$submit = false;
				$from_items['admin']['ADM_PWD2']['error'] = 1;
			}
		}

		$_SESSION['from_items'] = $from_items;

		if(!$submit)
		{
			$this->assign("froms",$from_items);
			$this->assign("DEMO_DATA",$demo_data);
			$this->display("database");
			exit;
		}

		$db_config = $_REQUEST['dbinfo'];
		$user_config = $_REQUEST['admin'];

		$_SESSION['user_config'] = $user_config;

		$this->display();

		$status = true;

		$connect = @mysql_connect($db_config['DB_HOST'].":".$db_config['DB_PORT'],$db_config['DB_USER'],$db_config['DB_PWD']);
		if(mysql_error()=="")
    	{
    		$rs = mysql_select_db($db_config['DB_NAME'],$connect);
    		if(!$rs)
    		{
    			$db_rs = mysql_query("CREATE DATABASE IF NOT EXISTS `".$db_config['DB_NAME']."` DEFAULT CHARACTER SET utf8");
    			if(!$db_rs)
    			{
    				$status = false;
					showjsmessage('',-1);
					showjsmessage("创建数据库失败",1);
    			}
    		}
    	}
    	else
    	{
    		$status = false;
			showjsmessage('',-1);
			showjsmessage("连接数据库失败",1);
    	}

		if(!$status)
			exit;

		flush();
		ob_flush();

		showjsmessage('',-1);
		showjsmessage("开始安装程序",2);

		//开始将$db_config写入配置
		$db_config_str 	 = 	"<?php\r\n";
		$db_config_str	.=	"return array(\r\n";
		foreach($db_config as $key=>$v)
		{
			$db_config_str.="'".$key."'=>'".$v."',\r\n";
		}
		$db_config_str.=");\r\n";
		$db_config_str.="?>";
		@file_put_contents(FANWE_ROOT."public/db.global.php",$db_config_str);

		showjsmessage(U('Index/runsql',array('index'=>0)),3);
    }

	public function runsql()
	{
		@set_time_limit(3600);
        if(function_exists('ini_set'))
            ini_set('max_execution_time',3600);
		
		$db_config = @include FANWE_ROOT."public/db.global.php";
		$index = isset($_REQUEST['index']) ? (int)$_REQUEST['index'] : 0;
		$sql_file = FANWE_ROOT."install/sqls/install_".$index.".sql";
		$this->display();

		flush();
		ob_flush();

		showjsmessage('',-1);

		if(file_exists($sql_file))
		{
			showjsmessage("正在执行SQL install_".$index.".sql",2);
			if($this->restore($sql_file,$db_config))
			{
				$index++;
				showjsmessage(U('Index/runsql',array('index'=>$index)),3);
			}	
			else
				showjsmessage("执行SQL install_".$index.".sql 发生错误",1);
		}
		else
		{
			$host = $db_config['DB_HOST'];
			if(!empty($db_config['DB_PORT']))
				$host = $db_config['DB_HOST'].':'.$db_config['DB_PORT'];

			Vendor("mysql");
			$db = new mysqldb(array('dbhost'=>$host,'dbuser'=>$db_config['DB_USER'],'dbpwd'=>$db_config['DB_PWD'],'dbname'=>$db_config['DB_NAME'],'dbcharset'=>'utf8','pconnect'=>0));
			
			$user_config = $_SESSION['user_config'];
			if($user_config['ADM_NAME'] != "fanwe" || $user_config['ADM_PWD'] != "fanwe")
			{
				$sql = "UPDATE ".$db_config['DB_PREFIX']."admin SET admin_name = '".$user_config['ADM_NAME']."',admin_pwd = '".md5($user_config['ADM_PWD'])."' WHERE id = 1";
				$db->query($sql);

				if($admins['ADM_NAME'] != "fanwe")
				{
					$sql = "UPDATE ".$db_config['DB_PREFIX']."sys_conf SET val = '".$user_config['ADM_NAME']."' WHERE name = 'SYS_ADMIN'";
					$db->query($sql);
				}
			}
			
			$db->query('DROP TRIGGER IF EXISTS `Archive`','SILENT');
			$archive_sql = 'CREATE TRIGGER `Archive` BEFORE UPDATE ON `%DB_PREFIX%apns_devices`
				 FOR EACH ROW INSERT INTO `%DB_PREFIX%apns_device_history` VALUES (
					NULL,
					OLD.`clientid`,
					OLD.`appname`,
					OLD.`appversion`,
					OLD.`deviceuid`,
					OLD.`devicetoken`,
					OLD.`devicename`,
					OLD.`devicemodel`,
					OLD.`deviceversion`,
					OLD.`pushbadge`,
					OLD.`pushalert`,
					OLD.`pushsound`,
					OLD.`development`,
					OLD.`status`,
					NOW()
				)';
			$db->query(str_replace("%DB_PREFIX%",$db_config['DB_PREFIX'],$archive_sql),'SILENT');

			$authkey = substr(md5($_SERVER['SERVER_ADDR'].$_SERVER['HTTP_USER_AGENT'].$db_config['DB_HOST'].$db_config['DB_USER'].$db_config['DB_PWD'].$db_config['DB_NAME'].$user_config['ADM_NAME'].$user_config['ADM_PWD'].'0'.substr(time(), 0, 6)), 8, 6).random1(10);
			$cookiepre = random1(4).'_';
			$memory_prefix = random1(6).'_';

			$configfile = @file_get_contents(FANWE_ROOT.'public/config.global.php');
			$configfile = trim($configfile);
			$configfile = preg_replace("/[$]config\['memory'\]\['prefix'\].*?=.*?'.*?'.*?;/is", "\$config['memory']['prefix'] = '".$memory_prefix."';", $configfile);
			$configfile = preg_replace("/[$]config\['cookie'\]\['cookie_pre'\].*?=.*?'.*?'.*?;/is", "\$config['cookie']['cookie_pre'] = '".$cookiepre."';", $configfile);
			$configfile = preg_replace("/[$]config\['security'\]\['authkey'\].*?=.*?'.*?'.*?;/is", "\$config['security']['authkey'] = '".$authkey."';", $configfile);
			@file_put_contents(FANWE_ROOT.'public/config.global.php', $configfile);
            @file_put_contents($this->install_lock,"");
			Vendor('common');            
            include_once fimport('class/cache');
            Cache::getInstance()->updateCache();
			showjsmessage("安装成功",4);
		}
	}

    private function checkEnv()
    {
		$rs['status'] = 1;

		$systems[0]['name'] = '操作系统';
		$systems[0]['ask'] = '不限制';
		$systems[0]['msg'] = PHP_OS;
		$systems[0]['status'] = 1;

		$systems[1]['name'] = 'PHP 版本';
		$systems[1]['ask'] = '5.0';
		$systems[1]['msg'] = PHP_VERSION;
		$systems[1]['status'] = (substr(PHP_VERSION, 0, 1) < 5) ? 0 : 1;
		$rs['status'] = $systems[1]['status'];

		$systems[2]['name'] = '附件上传';
		$systems[2]['ask'] = '需开启';
		$systems[2]['msg'] = @ini_get('file_uploads') ? ini_get('upload_max_filesize') : 'unknow';
		$systems[2]['status'] = @ini_get('file_uploads') ? 1 : 0;
		$rs['status'] = $systems[2]['status'];

		$tmp = function_exists('gd_info') ? gd_info() : array();

		$systems[3]['name'] = 'GD 库';
		$systems[3]['ask'] = '需开启';
		$systems[3]['msg'] = empty($tmp['GD Version']) ? 'noext' : $tmp['GD Version'];
		$systems[3]['status'] = empty($tmp['GD Version']) ? 0 : 1;
		$rs['status'] = $systems[3]['status'];

		$rs['systems'] = $systems;

    	$dirs = C("DIRS_CHECK");
    	foreach($dirs as $item)
    	{
			$item_path = $item['path'];
			$file['name'] = $item_path;
			$file['ask'] = '可读写';
			
			if($item['type'] == 'dir')
			{
				if(file_exists(FANWE_ROOT.$item_path))
				{
					if(!dirWriteable(FANWE_ROOT.$item_path))
					{
						$file['status'] = 0;
						$file['msg'] = '只读';
						$rs['status'] = 0;
					}
					else
					{
						$file['status'] = 1;
						$file['msg'] = '可读写';
					}
				}
				else
				{
					$file['status'] = 0;
					$file['msg'] = '没有目录';
					$rs['status'] = 0;
				}
			}
			else
			{
				if(file_exists(FANWE_ROOT.$item_path))
				{
					if(is_writable(FANWE_ROOT.$item_path))
					{
						$file['status'] = 1;
						$file['msg'] = '可读写';
					}
					else
					{
						$file['status'] = 0;
						$file['msg'] = '只读';
						$rs['status'] = 0;
					}
				}
				else
				{
					$file['status'] = 0;
					$file['msg'] = '没有文件';
					$rs['status'] = 0;
				}
			}
			$rs['files'][] = $file;
    	}

		$funs = C("FUNCTiON_CHECK");
    	foreach($funs as $fun)
    	{
			$item['name'] = $fun;
			$item['ask'] = '支持';

    		if(function_exists($fun))
    		{
    			$item['status'] = 1;
    			$item['msg'] = '支持';
    		}
    		else
    		{
				$item['status'] = 0;
    			$item['msg'] = "不支持";
				$rs['status'] = 0;
    		}
			$rs['funs'][] = $item;
    	}

    	return $rs;
    }

   /**
     * 执行SQL脚本文件
     *
     * @param array $filelist
     * @return string
     */
    private function restore($file,$db_config)
    {
		@set_time_limit(0);
		@ini_set('memory_limit', '128M');

		$host = $db_config['DB_HOST'];
        if(!empty($db_config['DB_PORT']))
            $host = $db_config['DB_HOST'].':'.$db_config['DB_PORT'];

		Vendor("mysql");
		$db = new mysqldb(array('dbhost'=>$host,'dbuser'=>$db_config['DB_USER'],'dbpwd'=>$db_config['DB_PWD'],'dbname'=>$db_config['DB_NAME'],'dbcharset'=>'utf8','pconnect'=>0));
		$sql = file_get_contents($file);
		$sql = $this->remove_comment($sql);
		$sql = trim($sql);

		$bln = true;

		$tables = array();

		$sql = str_replace("\r", '', $sql);
		$segmentSql = explode(";\n", $sql);
		$table = "";

		foreach($segmentSql as $k=>$itemSql)
		{
			$itemSql = trim(str_replace("%DB_PREFIX%",$db_config['DB_PREFIX'],$itemSql));

			if(strtoupper(substr($itemSql, 0, 12)) == 'CREATE TABLE')
			{
				$table = preg_replace("/CREATE TABLE (?:IF NOT EXISTS |)(?:`|)([a-z0-9_]+)(?:`|).*/is", "\\1", $itemSql);

				if(!in_array($table,$tables))
					$tables[] = $table;

				if($db->query($itemSql) === false)
				{
					$bln = false;
					showjsmessage("建立数据表 ".$table." ... 失败",1);
					break;
				}
				else
				{
					showjsmessage("建立数据表 ".$table." ... 成功");
				}
			}
			else
			{
				if($db->query($itemSql) === false)
				{
					$bln = false;
					showjsmessage("添加数据表 ".$table." ... 数据失败",1);
					break;
				}
			}
		}

		return $bln;
    }



    /**
     * 过滤SQL查询串中的注释。该方法只过滤SQL文件中独占一行或一块的那些注释。
     *
     * @access  public
     * @param   string      $sql        SQL查询串
     * @return  string      返回已过滤掉注释的SQL查询串。
     */
    private function remove_comment($sql)
    {
        /* 删除SQL行注释，行注释不匹配换行符 */
        $sql = preg_replace('/^\s*(?:--|#).*/m', '', $sql);

        /* 删除SQL块注释，匹配换行符，且为非贪婪匹配 */
        //$sql = preg_replace('/^\s*\/\*(?:.|\n)*\*\//m', '', $sql);
        $sql = preg_replace('/^\s*\/\*.*?\*\//ms', '', $sql);

        return $sql;
    }
}
?>