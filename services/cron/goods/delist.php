<?php
require ROOT_PATH.'core/fanwe.php';
$fanwe = &FanweService::instance();
$fanwe->is_session = false;
$fanwe->is_user = false;
$fanwe->is_cron = false;
$fanwe->is_misc = false;
$fanwe->cache_list = array();
$fanwe->initialize();

$_FANWE['request'] = unserialize(REQUEST_ARGS);
setTimeLimit(0);
$share_ids = array();
$res = FDB::query('SELECT * FROM '.FDB::table('delist_share').' ORDER BY share_id ASC LIMIT 0,10');
while($data = FDB::fetch($res))
{
	$share_ids[] = $data['share_id'];
}

if(count($share_ids) > 0)
{
	FDB::query('DELETE FROM '.FDB::table('delist_share').' WHERE share_id IN ('.implode(',',$share_ids).')');
	$list = FDB::fetchAll('SELECT share_id,rec_id,type FROM '.FDB::table('share').' WHERE share_id IN ('.implode(',',$share_ids).')');
	foreach($list as $item)
	{
		$share_id = (int)$item['share_id'];
		switch($item['type'])
		{
			case 'bar':
				FS("Topic")->deleteTopic($item['rec_id']);
			break;
			case 'bar_post':
				FS("Topic")->deletePost($share_id);
			break;
			case 'ershou':
				FS("Second")->deleteGoods($item['rec_id']);
			break;
			case 'album':
				FS('Album')->deleteAlbum($item['rec_id']);
			break;
			case 'album_item':
				FS('Album')->deleteAlbumItem($share_id);
			break;
			case 'activity':
				FS('Activity')->delete($item['rec_id']);
			break;	
			case 'activity_post':
				FS('Activity')->deletePost($share_id);
			break;
			case 'vote':
				FS('Vote')->delete($item['rec_id']);
			break;	
			case 'vote_post':
				FS('Vote')->deletePost($share_id);
			break;	
			default:
				FS("Share")->deleteShare($share_id);
			break;
		}
	}
	$args = array('m'=>'goods','a'=>'delist');
	FS("Cron")->createRequest($args);
}
else
{
	$goods_ids = array();
	$img_ids = array();
	
	$res = FDB::query('SELECT id,img_id FROM '.FDB::table('goods').' WHERE delist_time > 0 && delist_time < '.TIME_UTC.' ORDER BY id ASC LIMIT 0,10');
	while($data = FDB::fetch($res))
	{
		$goods_ids[] = $data['id'];
		if($data['img_id'] > 0)
			$img_ids[] = $data['img_id'];
	}
	
	if(count($goods_ids) > 0)
	{
		FDB::query('DELETE FROM '.FDB::table('goods').' WHERE id IN ('.implode(',',$goods_ids).')');
		FDB::query('DELETE FROM '.FDB::table('goods_comment').' WHERE goods_id IN ('.implode(',',$goods_ids).')');
		FDB::query('DELETE FROM '.FDB::table('goods_check').' WHERE id IN ('.implode(',',$goods_ids).')');
		FDB::query('DELETE FROM '.FDB::table('goods_match').' WHERE id IN ('.implode(',',$goods_ids).')');
		FDB::query('DELETE FROM '.FDB::table('goods_order').' WHERE goods_id IN ('.implode(',',$goods_ids).')');
		
		FDB::query('INSERT INTO '.FDB::table('delist_share').'(share_id) SELECT DISTINCT share_id FROM '.FDB::table('share_goods').' WHERE goods_id IN ('.implode(',',$goods_ids).')');
		
		FS('Image')->deleteImages($img_ids);
		
		$args = array('m'=>'goods','a'=>'delist');
		FS("Cron")->createRequest($args);
	}
}
?>
