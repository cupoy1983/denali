<?php
function xCopy($source,$destination,$child)
{
	//用法：
	//   xCopy("feiy","feiy2",1):拷贝feiy下的文件到   feiy2,包括子目录
	//   xCopy("feiy","feiy2",0):拷贝feiy下的文件到   feiy2,不包括子目录
	//参数说明：
	//   $source:源目录名
	//   $destination:目的目录名
	//   $child:复制时，是不是包含的子目录
	if(!is_dir($source))
	{
	  echo("Error:the   $source   is   not   a   direction!");
	  return   0;
	}
	if(!is_dir($destination))
		mkdir($destination,0777);


	$handle=dir($source);
	while($entry=$handle->read())
	{
		if(($entry!=".")&&($entry!=".."))
		{
			if(is_dir($source."/".$entry))
			{
				if($child)
					xCopy($source."/".$entry,$destination."/".$entry,$child);
			}
			else
			{
				copy($source."/".$entry,$destination."/".$entry);
			}
		}
	}

	return   1;
}

function showjsmessage($message,$isBack = 0){
	echo str_repeat(' ',4096)."<script type=\"text/javascript\">showmessage(\"".$message."\",".$isBack.");</script>"."\r\n";
	flush();
	ob_flush();
}

//全站通用的清除所有缓存的方法
function clear_cache()
{
	uclearDir(FANWE_ROOT."update/runtime/");
}

function uclearDir($dir)
{
	if(!file_exists($dir))
		return;

	$directory = dir($dir);

	while($entry = $directory->read())
	{
		if($entry != '.' && $entry != '..')
		{
			$filename = $dir.'/'.$entry;
			if(is_dir($filename))
				uclearDir($filename);

			if(is_file($filename))
				@unlink($filename);
		}
	}

	$directory->close();
}

//由数据库取出系统的配置
function fanweC($name)
{
	return C($name);
}

function dirWriteable($dir)
{
	$writeable = 0;
	if(!is_dir($dir))
	{
		@mkdir($dir, 0777);
	}
	
	if(is_dir($dir))
	{
		if($fp = @fopen($dir."test.txt", 'w'))
		{
			@fclose($fp);
			@unlink($dir."test.txt");
			$writeable = 1;
		}
		else
		{
			$writeable = 0;
		}
	}
	return $writeable;
}

/**
 * 递归方式的对变量中的特殊字符去除转义
 *
 * @access  public
 * @param   mix     $value
 *
 * @return  mix
 */
function stripslashesDeep($value)
{
    if (empty($value))
    {
        return $value;
    }
    else
    {
        return is_array($value) ? array_map('stripslashesDeep', $value) : stripslashes($value);
    }
}

function getUpdateImgServerUrl($server_code)
{
	global $oldDB;
	$url = $oldDB->resultFirst('SELECT url FROM '.$oldDB->tableName('image_servers').' WHERE code = \''.$server_code.'\'','SILENT');
	if(empty($url))
		return false;
	
	if(substr($url,-1,1) != '/')
		$url .= '/';

	return $url;
}

function addUpdateImage($src,$type,$server_code = '',$width = 0,$height = 0)
{
	$width = (int)$width;
	$height = (int)$height;
	if($width == 0 || $height == 0)
	{
		//图片服务器图片需要先获取图片信息
		if(empty($server_code))
			$image_info = @getimagesize(OLD_ROOT_PATH.$src);
		//elseif($server_code == 'upyun'){upyun图片信息获取}
		else
		{
			$url = getUpdateImgServerUrl($server_code);
			if($url)
			{
				$url .= 'getinfo.php?src='.$src;
				$ch = curl_init();
				curl_setopt($ch, CURLOPT_URL,$url);
				curl_setopt($ch, CURLOPT_TIMEOUT,5);
				curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
				$image_info = curl_exec($ch);
				curl_close($ch);
				
				if(empty($image_info))
				{
					showjsmessage($server_code.'图片服务器无响应，请检查图片服务器',1);
					exit;	
				}
					
				if($image_info == 'no')
					return 0;
				
				$image_info = @unserialize($image_info);
			}
			else
				return 0;
		}
		
		if(!$image_info)
			return 0;

		$width = (int)$image_info[0];
		$height = (int)$image_info[1];
	}

	if($width == 0 || $height == 0)
		return 0;
	
	FDB::query('INSERT INTO '.FDB::table('images_index').'(id) VALUES(NULL)');
	$id = FDB::insertId();
	$table = FS('Image')->getTablaName($id,false);
	
	$image = array();
	$image['src'] = $src;
	$image['id'] = $id;
	$image['type'] = $type;
	$image['width'] = $width;
	$image['height'] = $height;
	$image['server_code'] = $server_code;
	if(FDB::insert($table,$image,false,false,true))
		return $id;
	
	FDB::query('DELETE FROM '.FDB::table('images_index').' WHERE id = '.$id);
	return 0;
}
?>