<?php
// +----------------------------------------------------------------------
// | 方维购物分享网站系统 (Build on ThinkPHP)
// +----------------------------------------------------------------------
// | Copyright (c) 2011 http://fanwe.com All rights reserved.
// +----------------------------------------------------------------------

/**  
 * cron.service.php
 *
 * 计划任务处理服务
 *
 * @package class
 * @author awfigq <awfigq@qq.com>
 */
class CronService
{
	public function run()
	{
		$crons = array();
		$res = FDB::query("SELECT * FROM ".FDB::table('cron')." WHERE run_time <= '".TIME_UTC."' ORDER BY run_time DESC");
		while($data = FDB::fetch($res))
		{
			$crons[$data['server']][] = $data;
		}
		
		if(count($crons) > 0)
		{
			$query = FDB::query("DELETE FROM ".FDB::table('cron')." WHERE run_time <= '".TIME_UTC."'");
			if($query !== FALSE && FDB::affectedRows() > 0)
			{
				foreach($crons as $cserver => $cron_list)
				{
					if($cserver == 'collect')
					{
						CronService::createRequest(array('m'=>'collect','a'=>'init'),true);
						FDB::insert('cron',array('server'=>'collect','run_time'=>TIME_UTC + 86400));
					}
					else
						FS($cserver)->runCron($cron_list);
				}
			}
		}
		
		$send_time = (int)@file_get_contents(FANWE_ROOT.'public/records/sync_send.time.php');
		if(TIMESTAMP - $send_time > 300)
			CronService::createRequest(array('m'=>'share','a'=>'sync_send'),true);
	}
	
	public function createRequest($args = array(),$is_script = false)
	{
		global $_FANWE;
		$args['request_time'] = TIMESTAMP;
		$args = serialize($args);
		$authkey = md5($_FANWE['config']['security']['authkey']);
		$args = rawurlencode(authcode($args,'ENCODE',$authkey));
		$args = 'args='.$args;
		
		if($is_script)
		{
			$url = SITE_URL.'services/cron.php?'.$args;
			$_FANWE['delay_scripts'][] = $url;
			return $url;
		}
		else
		{
			$ch = curl_init();
			curl_setopt($ch, CURLOPT_URL,$_FANWE['site_url']."services/cron.php");
			curl_setopt($ch, CURLOPT_TIMEOUT,5);
			curl_setopt($ch, CURLOPT_POST, 1 );     
    		curl_setopt($ch, CURLOPT_POSTFIELDS, $args); 
			curl_exec($ch);
			curl_close($ch);
		}
	}
}
?>