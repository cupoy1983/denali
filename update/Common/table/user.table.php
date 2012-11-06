<?php
$count = 0;
$res = $oldDB->query('SELECT * FROM '.$oldDB->tableName($tableTaget).' ORDER BY uid ASC LIMIT '.$begin.','.$limit);
while($user = $oldDB->fetchArray($res))
{
	$count++;
	$uid = $user['uid'];
	$user['user_name'] = addslashes($user['user_name']);
	$user_new = FDB::fetchFirst('SELECT * FROM '.FDB::table('user').' WHERE uid = '.$uid);
	if(!$user_new)
	{
		if($user['avatar_status'] == 1)
		{
			$src = getUpdateUserImg($uid,$user['server_code']);
			if(!empty($src))
			{
				$img_id = addUpdateImage($src,'avatar',$user['server_code']);
				if($img_id > 0)
					$user['avatar'] = $img_id;
			}
		}

		unset($user['avatar_status'],$user['server_code'],$user['user_name_match'],$user['sina_id'],$user['sina_app_key'],$user['sina_app_secret'],$user['sina_syn_weibo'],$user['sina_syn_topic'],$user['tqq_id'],$user['tqq_app_key'],$user['tqq_app_secret'],$user['tqq_syn_weibo'],$user['tqq_syn_topic'],$user['qq_id'],$user['taobao_id'],$user['is_business']);
		FDB::insert('user',$user,false,true);
	}

	$user_match = array(
		'uid' => $uid,
		'user_name' => FS("Words")->segmentToUnicode($user['user_name']),
	);
	FDB::insert('user_match',$user_match,false,true);
	
	$looks = $oldDB->resultFirst('SELECT COUNT(DISTINCT share_id) FROM '.$oldDB->tableName('share_photo').' WHERE uid = '.$uid.' AND type= \'look\'');
	$dapeis = $oldDB->resultFirst('SELECT COUNT(DISTINCT share_id) FROM '.$oldDB->tableName('share_photo').' WHERE uid = '.$uid.' AND type= \'dapei\'');
	$user_count = $oldDB->fetchFirst('SELECT * FROM '.$oldDB->tableName('user_count').' WHERE uid = '.$uid);
	
	foreach($user_count as $key => $val)
	{
		if($val < 0)
			$user_count[$key] = 0;
	}
	$user_count['looks'] = $looks;
	$user_count['dapei'] = $dapeis;
	$user_count['forums'] = $user_count['forums'] + $user_count['ask'];
	$user_count['forum_posts'] = $user_count['forum_posts'] + $user_count['ask_posts'];

	unset($user_count['ask'],$user_count['ask_posts'],$user_count['ask_best_posts'],$user_count['seconds']);
	FDB::insert('user_count',$user_count,false,true);

	$last_share = (int)$oldDB->resultFirst('SELECT share_id FROM '.$oldDB->tableName('share').' WHERE uid = '.$uid.' ORDER BY share_id DESC LIMIT 0,1');
	$user_status = array(
		'last_share' => $last_share,
	);
	FDB::update('user_status',$user_status,'uid = '.$uid);
	showjsmessage("转换会员 ".$uid." 成功",2);
}

if($count == 0 || $count < $limit)
	$args = array('table'=>$tableIndex + 1);
else
	$args = array('table'=>$tableIndex,'begin'=>$begin + $limit);
	
$total = $oldDB->resultFirst('SELECT COUNT(uid) FROM '.$oldDB->tableName($tableTaget));
$count = $total - $begin - $limit;
if($count < 0)
	$count = 0;

showjsmessage("还有 <b style='color:#f00;'>".$count."</b> 个会员待转换",2);

showjsmessage(U('Index/updatetable',$args),5);

function getUpdateUserImg($uid,$code)
{
	$uid = sprintf("%09d", $uid);
	$dir1 = substr($uid, 0, 3);
	$dir2 = substr($uid, 3, 2);
	$dir3 = substr($uid, 5, 2);
	$size = 'big';
	if(empty($code))
	{
		$file_path = OLD_ROOT_PATH.'public/upload/avatar/'.$dir1.'/'.$dir2.'/'.$dir3.'/'.substr($uid, -2).'_'.$size.'.jpg';
		$file = './public/upload/avatar/'.$dir1.'/'.$dir2.'/'.$dir3.'/'.substr($uid, -2).'_'.$size.'.jpg';
		if(!file_exists($file_path))
			$file = '';
	}
	else
	{
		$file = './'.$code.'/public/upload/avatar/'.$dir1.'/'.$dir2.'/'.$dir3.'/'.substr($uid, -2).'_'.$size.'.jpg';
	}
	return $file;
}
?>