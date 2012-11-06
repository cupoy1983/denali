<?php
$count = 0;
$res = $oldDB->query('SELECT * FROM '.$oldDB->tableName('share_goods').' ORDER BY goods_id ASC LIMIT '.$begin.','.$limit);
while($data = $oldDB->fetchArray($res))
{
	$count++;
	if($data['share_id'] == 0)
		continue;
	
	if(empty($data['goods_key']))
	{
		$data['goods_key'] = getGoodsKeyByUrl($data['url']);
		$oldDB->query("UPDATE ".$oldDB->tableName('share_goods')." SET goods_key = '".$data['goods_key']."' 
			WHERE goods_id = ".$data['goods_id']);
	}
	
	$goods_id = (int)FDB::resultFirst('SELECT id FROM '.FDB::table('goods').' WHERE keyid = \''.$data['goods_key'].'\'');
	if($goods_id == 0)
	{
		$goods = array();
		$goods['keyid'] = $data['goods_key'];
		if(!empty($data['img']))
		{
			$img_id = addUpdateImage($data['img'],'share',$data['server_code'],(int)$data['img_width'],(int)$data['img_height']);
			if($img_id > 0)
				$goods['img_id'] = $img_id;
			else
				continue;
		}
		else
			continue;

		$types = explode('_',$data['goods_key']);
		$goods['type'] = $types[0];
		$goods['shop_id'] = $data['shop_id'];
		$goods['cid'] = getCidByShareId($data['share_id']);
		$goods['name'] = addslashes($data['name']);
		$goods['url'] = addslashes($data['url']);
		$goods['taoke_url'] = addslashes($data['taoke_url']);
		$goods['price'] = $data['price'];
		$goods['delist_time'] = 0;
		$create_time = (int)$oldDB->resultFirst('SELECT create_time FROM '.$oldDB->tableName('share').' WHERE share_id = '.$data['share_id']);
		if($create_time == 0)
			$create_time = TIME_UTC;
		$goods['create_time'] = $create_time;

		$create_day = fToDate($goods['create_time'],'Y-m-d 00:00:00');
		$goods['create_day'] = str2Time($create_day);
		$goods_id = FDB::insert('goods',$goods,true);
		
		if($goods['cid'] == 0)
		{
			FDB::insert('goods_check',array('id'=>$goods_id));
		}

		$goods_match = array(
			'id' => $goods_id,
			'goods_name' => FS("Words")->segmentToUnicode($data['name']),
		);
		FDB::insert('goods_match',$goods_match,false,true);
	}
	showjsmessage("转换商品 ".$data['goods_key']." 成功",2);
	usleep(10);
}

if($count == 0 || $count < $limit)
	$args = array('table'=>$tableIndex + 1);
else
	$args = array('table'=>$tableIndex,'begin'=>$begin + $limit);

$total = $oldDB->resultFirst('SELECT COUNT(goods_id) FROM '.$oldDB->tableName('share_goods'));
$count = $total - $begin - $limit;
if($count < 0)
	$count = 0;
	
showjsmessage("还有 <b style='color:#f00;'>".$count."</b> 个商品待转换",2);
showjsmessage(U('Index/updatetable',$args),5);

function getGoodsKeyByUrl($url)
{
	if(strpos($url,'taobao') !== FALSE || strpos($url,'tmall') !== FALSE)
	{
		$id = 0;
		$parse = parse_url($url);
		if(isset($parse['query']))
		{
			parse_str($parse['query'],$params);
			if(isset($params['id']))
				$id = (float)$params['id'];
			elseif(isset($params['item_id']))
				$id = (float)$params['item_id'];
			elseif(isset($params['default_item_id']))
				$id = (float)$params['default_item_id'];
			elseif(isset($params['item_num_id']))
				$id = (float)$params['item_num_id'];
		}

		if($id > 0)
			return 'taobao_'.$id;
	}
	elseif(strpos($url,'paipai') !== FALSE)
	{
		$id = '';
		$parse = parse_url($url);
		if(isset($parse['path']))
		{
			$parse = explode('/',$parse['path']);
			$parse = end($parse);
			$parse = explode('-',$parse);
			$id = current($parse);
        }

		if(!empty($id))
			return 'paipai_'.$id;
	}
	elseif(strpos($url,'360buy') !== FALSE)
	{
		$id = '';
		$parse = parse_url($url);
		if(isset($parse['path']))
		{
			$parse = explode('/',$parse['path']);
			$parse = end($parse);
			$parse = explode('.',$parse);
			$id = current($parse);
        }

		if(!empty($id))
			return '360buy_'.$id;
	}
	elseif(strpos($url,'dangdang') !== FALSE)
	{
		$id = 0;
		$parse = parse_url($url);
		if(isset($parse['query']))
		{
            parse_str($parse['query'],$params);
			if(isset($params['product_id']))
				$id = (float)$params['product_id'];
            elseif(isset($params['id']))
                $id = (float)$params['id'];
        }

		if($id > 0)
			return 'dangdang_'.$id;
	}
	elseif(strpos($url,'vancl') !== FALSE)
	{
		$id = '';
		$parse = parse_url($url);
		if(isset($parse['path']))
		{

			$parse = explode('/',$parse['path']);
			$parse = end($parse);
			$parse = explode('.',$parse);
			$id = current($parse);
        }

		if(!empty($id))
			return 'vancl_'.$id;
	}
	elseif(strpos($url,'vjia') !== FALSE)
	{
		$id = '';
		$parse = parse_url($url);
		if(isset($parse['path']))

		{
			$url = $parse['scheme'].'://'.$parse['host'].$parse['path'];
			$parse = explode('/',$parse['path']);
			$parse = end($parse);
			$parse = explode('.',$parse);
			$id = current($parse);
			
        }
		if(!empty($id))
			return 'vjia_'.$id;
	}

	return 'default_'.md5($url);
}

function getCidByShareId($share_id)
{
	$list = array();
	global $oldDB;
	$res = $oldDB->query('SELECT cate_id FROM '.$oldDB->tableName('share_category').' WHERE share_id = '.$share_id);
	while($data = $oldDB->fetchArray($res))
	{
		if(isset($list[$data['cate_id']]))
			$list[$data['cate_id']]++;
		else
			$list[$data['cate_id']] = 1;
	}

	if(count($list) == 0)
		return 0;

	arsort($list);
	return key($list);
}
?>