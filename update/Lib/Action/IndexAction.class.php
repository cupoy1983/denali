<?php
//系统转换
class IndexAction extends Action
{
	private $install_lock;
	private function getRealPath()
	{
		return FANWE_ROOT;
	}

	public function __construct()
	{
		import("ORG.Io.Dir");
		parent::__construct();
		$this->install_lock = FANWE_ROOT."public/install.lock";
	}

    public function index()
	{
		clear_cache();
		$note = file_get_contents(FANWE_ROOT.'update/update.txt');
		$this->assign("note",nl2br($note));
		$this->display();
    }

	public function msg($msg)
    {
		$this->assign("msg",$msg);
		$this->display('msg');
		exit;
    }
	
	public function check()
	{
		$status = 1;
		$check_dirs = array();
		
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
						$status = 0;
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
					$status = 0;
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
						$status = 0;
					}
				}
				else
				{
					$file['status'] = 0;
					$file['msg'] = '没有文件';
					$status = 0;
				}
			}
			$check_dirs[] = $file;
    	}
		
		$this->assign("status",$status);
		$this->assign("check_dirs",$check_dirs);
		$this->display();
	}

    public function update()
    {
		$sqls = file_get_contents(FANWE_ROOT.'update/update.sql');
		$sqls = str_replace("\r", '', $sqls);
		$version = explode(";\n", $sqls);
		if(empty($version[0]))
		{
			$this->msg("脚本没有版本号，无法更新");
		}
		else
		{
			$version = $version[0];
			$db = $this->getDB();
			$db_version = $db->resultFirst("select val from ".C('DB_PREFIX')."sys_conf where name='SYS_VERSION'");
			
			if(floatval($db_version) == floatval($version))
			{
				$this->msg("已经是最新版本");
			}

			if(floatval($db_version) > floatval($version))
			{
				$this->msg("不能更新旧版本");
			}
		}
		$this->doupdate();
    }

	public function doupdate()
	{
		@set_time_limit(0);
        if(function_exists('ini_set'))
            ini_set('max_execution_time',3600);

		$this->display("doupdate");
		flush();
		ob_flush();

		showjsmessage('',-1);
		showjsmessage("开始更新分享程序",2);

        usleep(100);
        if($this->restore(FANWE_ROOT."update/update.sql"))
			showjsmessage("更新 数据库 成功");
		else
		{
			showjsmessage("更新 数据库 失败");
			exit;
		}

        $this->redirect('Index/updatetable');
		exit;
	}
	
	public function updatetable()
	{
		@set_time_limit(0);
        if(function_exists('ini_set'))
            ini_set('max_execution_time',0);
			
		define('SYS_DEBUG',true);

		$tables = @include FANWE_ROOT."update/Common/tables.php";
		
		if(!$tables)
			$this->msg('获取配置文件发生错误');

		$tableIndex = isset($_REQUEST['table']) ? (int)$_REQUEST['table'] : 0;
		$tableIndex = max($tableIndex,0);
		$begin = isset($_REQUEST['begin']) ? (int)$_REQUEST['begin'] : 0;
		$begin = max($begin,0);
		$this->display();

		ob_start();
		ob_end_flush(); 
		ob_implicit_flush(1);
		
		if($tableIndex < count($tables))
		{
			$tableTaget = $tables[$tableIndex]['name'];
			showjsmessage("正在初始化".$tableTaget."转换表数据，请稍候...",2);
			vendor('common');
			@file_put_contents(FANWE_ROOT.'public/update_log.txt',$tableTaget."\n".$tableIndex."\n".$begin);
			$limit = 100;
			@include FANWE_ROOT.'update/Common/table/'.$tableTaget.'.table.php';
		}
		else
		{
			$this->redirect('Index/updateok');
			exit;
		}
	}
	
	public function updateok()
	{
		$this->display();
	}

	private function getDB()
	{
		static $db = NULL;
		if($db == NULL)
		{
			$host = C('DB_HOST');
			$port = C('DB_PORT');
			if(!empty($port))
				$host = $host.':'.$port;

			Vendor("mysql");
			$db = new mysqldb(array('dbhost'=>$host,'dbuser'=>C('DB_USER'),'dbpwd'=>C('DB_PWD'),'dbname'=>C('DB_NAME'),'dbcharset'=>'utf8','pconnect'=>0));
		}

		return $db;
	}
	
   /**
     * 执行SQL脚本文件
     *
     * @param array $filelist
     * @return string
     */
    private function restore($file)
    {
		@set_time_limit(0);
		@ini_set('memory_limit', '128M');

		$db = $this->getDB();
		$sql = file_get_contents($file);
		$sql = $this->remove_comment($sql);
		$sql = trim($sql);

		$bln = true;

		$tables = array();

		$sql = str_replace("\r", '', $sql);
		$segmentSql = explode(";\n", $sql);
		unset($segmentSql[0]);
		$table = "";

		foreach($segmentSql as $k=>$itemSql)
		{
			$itemSql = trim(str_replace("%DB_PREFIX%",C('DB_PREFIX'),$itemSql));

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