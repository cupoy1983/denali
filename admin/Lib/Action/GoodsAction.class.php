<?php
// +----------------------------------------------------------------------
// | 方维购物分享网站系统 (Build on ThinkPHP)
// +----------------------------------------------------------------------
// | Copyright (c) 2011 http://fanwe.com All rights reserved.
// +----------------------------------------------------------------------
// | Licensed ( http://www.apache.org/licenses/LICENSE-2.0 )
// +----------------------------------------------------------------------
// | Author: awfigq <awfigq@qq.com>
// +----------------------------------------------------------------------
/**
 +------------------------------------------------------------------------------
 商品管理
 +------------------------------------------------------------------------------
 */
class GoodsAction extends CommonAction
{
	public function index()
	{
		vendor("common");
		$where = '';
		$parameter = array();
		$keyword = trim($_REQUEST['keyword']);
		$cate_id = intval($_REQUEST['cate_id']);
		$color = intval($_REQUEST['color']);
		$keyid = trim($_REQUEST['keyid']);
		
		if(!empty($keyid))
		{
			$this->assign("keyid",$keyid);
			$parameter['keyid'] = $keyid;
			$where = " AND g.keyid = '".$keyid."' ";
		}
		
		$is_match = false;
		if(!empty($keyword))
		{
			$this->assign("keyword",$keyword);
			$parameter['keyword'] = $keyword;
			$match_key = FS('Words')->segmentToUnicode($keyword,'+');
			$is_match = true;
		}
		
		if($color > 0)
		{
			$this->assign("color",$color);
			$parameter['color'] = $color;

			$where .= " AND g.color = $color ";
		}
		
		$is_cate = false;
		if($cate_id != 0)
		{
			$is_cate = true;
			$this->assign("cate_id",$cate_id);
			$parameter['cate_id'] = $cate_id;

			if($cate_id > 0)
			{
				$child_ids = D('GoodsCategory')->getChildIds($cate_id,'cate_id');
				$child_ids[] = $cate_id;
				$where .= " AND g.cid IN (".implode(',',$child_ids).") ";
			}
			else
				$where .= " AND g.cid = 0 ";
		}
		
		$model = M();
		
		$append_sql = '';
		$sql_count = 'SELECT COUNT(g.id) AS gcount FROM '.C("DB_PREFIX").'goods AS g ';
		$sql = 'SELECT g.*,gc.cate_name,gco.name AS color_name FROM '.C("DB_PREFIX").'goods AS g ';
		if($is_match)
		{
			$sql_count = 'SELECT COUNT(gm.id) AS gcount FROM '.C("DB_PREFIX").'goods_match AS gm ';
			$sql = 'SELECT g.*,gc.cate_name,gco.name AS color_name FROM '.C("DB_PREFIX").'goods_match AS gm ';
			$append_sql = 'INNER JOIN '.C("DB_PREFIX").'goods AS g ON g.id = gm.id ';
			$sql .= $append_sql;
			if($is_cate)
			{
				$sql_count .= $append_sql.$where;
				$sql .= $where;
			}
			$where = " AND match(gm.goods_name) against('".$match_key."' IN BOOLEAN MODE) ";
		}
		
		$sql .= ' LEFT JOIN '.C("DB_PREFIX").'goods_category AS gc ON gc.cate_id = g.cid 
			LEFT JOIN '.C("DB_PREFIX").'goods_color AS gco ON gco.id = g.color ';
		
		if(!empty($where))
			$where = str_replace('WHERE AND','WHERE','WHERE'.$where);
		
		$sql_count .= $where;
		$sql .= $where;
		
		$count = $model->query($sql_count);
		$count = $count[0]['gcount'];

		$this->_sqlList($model,$sql,$count,$parameter,'g.id');
		
		$root_id = D('GoodsCategory')->where('is_root = 1')->getField('cate_id');
		$root_id = intval($root_id);
		$root_ids = D('GoodsCategory')->getChildIds($root_id,'cate_id');
		$root_ids[] = $root_id;
		
		$cate_list = D('GoodsCategory')->where('cate_id not in ('.implode(',',$root_ids).')')->order('sort asc')->select();
		$cate_list = D('GoodsCategory')->toFormatTree($cate_list,'cate_name','cate_id','parent_id');
		$this->assign("cate_list",$cate_list);
		
		$color_list = D('GoodsColor')->order('sort asc')->select();
		$this->assign("color_list",$color_list);
		$this->display();
	}
	
	public function check()
	{
		$model = M();
		$sql_count = 'SELECT COUNT(id) AS gcount FROM '.C("DB_PREFIX").'goods_check ';
		$sql = 'SELECT g.*,gc.cate_name,gco.name AS color_name FROM '.C("DB_PREFIX").'goods_check AS gk 
			INNER JOIN '.C("DB_PREFIX").'goods AS g ON g.id = gk.id 
			LEFT JOIN '.C("DB_PREFIX").'goods_category AS gc ON gc.cate_id = g.cid 
			LEFT JOIN '.C("DB_PREFIX").'goods_color AS gco ON gco.id = g.color ';
		
		$count = $model->query($sql_count);
		$count = $count[0]['gcount'];

		$this->_sqlList($model,$sql,$count,$parameter,'g.id',true);
		$this->display();
	}
	
	public function checkOk()
	{
		$result = array('isErr'=>0,'content'=>'');
		$id = $_REQUEST['id'];
		if(!empty($id))
		{
			$model = D('GoodsCheck');
			$condition = array ('id' => array ('in', explode ( ',', $id ) ) );
			if(false !== $model->where ( $condition )->delete ())
			{
				$this->saveLog(1,$id);
			}
			else
			{
				$this->saveLog(0,$id);
				$result['isErr'] = 1;
				$result['content'] = L('REMOVE_ERROR');
			}
		}
		else
		{
			$result['isErr'] = 1;
			$result['content'] = L('ACCESS_DENIED');
		}
		die(json_encode($result));
	}
	
	public function disables()
	{
		$where = '';
		$parameter = array();
		$keyid = trim($_REQUEST['keyid']);
		
		if(!empty($keyid))
		{
			$this->assign("keyid",$keyid);
			$parameter['keyid'] = $keyid;
			$where = " WHERE keyid = '".$keyid."' ";
		}
		
		$model = M();
		$sql_count = 'SELECT COUNT(id) AS gcount FROM '.C("DB_PREFIX").'goods_disable '.$where;
		$sql = 'SELECT * FROM '.C("DB_PREFIX").'goods_disable'.$where;
		
		$count = $model->query($sql_count);
		$count = $count[0]['gcount'];

		$this->_sqlList($model,$sql,$count,$parameter,'id');
		$this->display();
	}
	
	public function removeDisables()
	{
		$result = array('isErr'=>0,'content'=>'');
		$id = $_REQUEST['id'];
		if(!empty($id))
		{
			$model = D('GoodsDisable');
			$condition = array ('id' => array ('in', explode ( ',', $id ) ) );
			if(false !== $model->where ( $condition )->delete ())
			{
				$this->saveLog(1,$id);
			}
			else
			{
				$this->saveLog(0,$id);
				$result['isErr'] = 1;
				$result['content'] = L('REMOVE_ERROR');
			}
		}
		else
		{
			$result['isErr'] = 1;
			$result['content'] = L('ACCESS_DENIED');
		}
		die(json_encode($result));
	}
	
	public function edit()
	{
		$id = (int)$_REQUEST['id'];
		$vo = D("Goods")->getById($id);
		$this->assign('vo',$vo);
		
		if($vo['shop_id'] > 0)
		{
			$shop = D("Shop")->getById($vo['shop_id']);
			$this->assign('shop',$shop);
		}
		
		$root_id = D('GoodsCategory')->where('is_root = 1')->getField('cate_id');
		$root_id = intval($root_id);
		$root_ids = D('GoodsCategory')->getChildIds($root_id,'cate_id');
		$root_ids[] = $root_id;
		
		$cate_list = D('GoodsCategory')->where('status = 1 AND cate_id not in ('.implode(',',$root_ids).')')->order('sort asc')->select();
		$cate_list = D('GoodsCategory')->toFormatTree($cate_list,'cate_name','cate_id','parent_id');
		$this->assign('cate_list',$cate_list);
		
		$color_list = D('GoodsColor')->order('sort asc')->select();
		$this->assign("color_list",$color_list);
		
		$this->display();
	}
	
	public function update()
	{
		$id = intval($_REQUEST['id']);
		$model = D("Goods");
		if (false === $data = $model->create ()) {
			$this->error ($model->getError());
		}
		
		$goods_img= '';
		if($upload_list = $this->uploadImages())
			$goods_img = $upload_list[0]['recpath'].$upload_list[0]['savename'];
		
		// 更新数据
		$list=$model->save($data);
		if (false !== $list)
		{
			if(!empty($goods_img))
			{
				vendor("common");
				$old_goods = D("Goods")->where('id = '.$id)->find();
				$img = array();
				$img['id'] = $old_goods['img_id'];
				$img['type'] = 'share';
				$img['src'] = FANWE_ROOT.$goods_img;
				FS('Image')->updateImage($img,true);
			}
			
			$this->saveLog(1,$id);
			$this->assign('jumpUrl', Cookie::get ( '_currentUrl_' ) );
			$this->success (L('EDIT_SUCCESS'));
		}
		else
		{
			//错误提示
			$this->saveLog(0,$id);
			$this->error (L('EDIT_ERROR'));
		}
	}
	
	public function disable()
	{
		$_SESSION['goods_remove_ids'] = '';
		$id = $_REQUEST['id'];
		if(!empty($id))
		{
			$model = D("Goods");
			$condition = array('id' => array('in',explode(',',$id)));
			$list = $model->where ($condition)->select();
			$time = gmtTime();
			$goods_ids = array();
			$img_ids = array();
			foreach($list as $item)
			{
				$goods_ids[] = $item['id'];
				if($item['img_id'] > 0)
					$img_ids[] = $item['img_id'];
			}
			$goods_ids = implode(',',$goods_ids);
			$sql = 'REPLACE INTO '.C("DB_PREFIX")."goods_disable(type,keyid,name,url,create_time) 
				SELECT type,keyid,name,url,'".$time."' AS create_time FROM ".C("DB_PREFIX")."goods 
				WHERE id IN (".$goods_ids.")";
			M()->query($sql);
			
			if(false !== $model->where ( $condition )->delete())
			{
				$sql = 'DELETE FROM '.C("DB_PREFIX")."goods_order WHERE goods_id IN (".$goods_ids.")";
				M()->query($sql);
				
				$sql = 'DELETE FROM '.C("DB_PREFIX")."goods_comment WHERE goods_id IN (".$goods_ids.")";
				M()->query($sql);
				
				D('GoodsMatch')->where($condition)->delete();
				D('GoodsCheck')->where($condition)->delete();
				vendor("common");
				FS('Image')->deleteImages($img_ids);
				$_SESSION['goods_remove_ids'] = $goods_ids;
				$this->saveLog(1,$id);
				$this->redirect('Goods/removeShare');
			}
			else
			{
				$this->error(L('REMOVE_ERROR'));
			}
		}
		else
		{
			$this->error(L('ACCESS_DENIED'));
		}
	}
	
	public function remove()
	{
		$_SESSION['goods_remove_ids'] = '';
		$id = $_REQUEST['id'];
		if(!empty($id))
		{
			$model = D("Goods");
			$condition = array('id' => array('in',explode(',',$id)));
			$list = $model->where ($condition)->select();
			if(false !== $model->where ($condition)->delete())
			{
				D('GoodsMatch')->where($condition)->delete();
				D('GoodsCheck')->where($condition)->delete();
				$time = gmtTime();
				$goods_ids = array();
				$img_ids = array();
				foreach($list as $item)
				{
					$goods_ids[] = $item['id'];
					if($item['img_id'] > 0)
						$img_ids[] = $item['img_id'];
				}
				$sql = 'DELETE FROM '.C("DB_PREFIX")."goods_order WHERE goods_id IN (".implode(',',$goods_ids).")";
				M()->query($sql);
				
				$sql = 'DELETE FROM '.C("DB_PREFIX")."goods_comment WHERE goods_id IN (".$goods_ids.")";
				M()->query($sql);
				
				vendor("common");
				FS('Image')->deleteImages($img_ids);
				
				$_SESSION['goods_remove_ids'] = $goods_ids;
				$this->saveLog(1,$id);
				$this->redirect('Goods/removeShare');
			}
			else
			{
				$this->error(L('REMOVE_ERROR'));
			}
		}
		else
		{
			$this->error(L('ACCESS_DENIED'));
		}
	}
	
	public function removeShare()
	{
		$this->display('remove');
		$goods_ids = $_SESSION['goods_remove_ids'];
		$index = (int)$_REQUEST['index'];
		$count = 100;
		$min = $index * $count;
		$max = $min + $count;
		$sql = 'SELECT id,share_id FROM '.C("DB_PREFIX").'share_goods 
			WHERE goods_id IN ('.implode(',',$goods_ids).') GROUP BY share_id 
			ORDER BY share_id ASC LIMIT 0,'.$count;
		
		$list = M()->query($sql);
		if(count($list) > 0)
		{
			$ids = array();
			echoFlush('<script type="text/javascript">showmessage(\''.sprintf(L('DELETE_TIPS_1'),$min,$max).'\',1);</script>');
			vendor("common");
			@set_time_limit(0);
			if(function_exists('ini_set'))
				ini_set('max_execution_time',0);
			
			foreach($list as $item)
			{
				D("Share")->removeHandler($item['share_id']);
				$ids[] = $item['id'];
				usleep(10);
			}
			usleep(100);
			if(count($ids) > 0)
			{
				M()->query('DELETE FROM '.C("DB_PREFIX")."share_goods WHERE id IN (".implode(',',$ids).")");
			}
			$index++;
			echoFlush('<script type="text/javascript">showmessage(\''.U('Goods/removeShare',array('index'=>$index)).'\',2);</script>');
			exit;
		}
		usleep(500);

		$_SESSION['goods_remove_ids'] = '';
		echoFlush('<script type="text/javascript">showmessage(\''.L('DELETE_TIPS_2').'\',3);</script>');
	}
	
	function addLike(){
		vendor("common");
		$key = $_REQUEST['id'];
		$res = null;
		if(!empty($key)){
			$ids = explode(",", $key);
			$res = FDB::query("SELECT share_id, uid FROM ".FDB::table('share_goods')." WHERE goods_id IN (".implode(',',$ids).")");
		}else{
			$res = FDB::query("SELECT share_id, uid FROM ".FDB::table('share')." where share_data = 'goods' order by rand() limit 500 ");
		}
		
		while($share = FDB::fetch($res)){
			$shareId = $share['share_id'];
			//设定评论人uid
			$limit = rand(1, 10);
			$users = FDB::query("select uid from ".FDB::table("user")." where gid =8 ORDER BY rand() LIMIT ". $limit);
			while($u = FDB::fetch($users)){
				$uid= $u['uid'];
				if($share['uid'] == $uid){
					continue;
				}elseif(FS('Share')->getIsCollectByUid($shareId,$uid)){
					continue;
				}else{
					$data = array();
					$data['uid'] = $share['uid'];
					$data['c_uid'] = $uid;
					$data['share_id'] = $shareId;
					$data['create_time'] = TIME_UTC;
					FDB::insert('user_collect',$data);
					FDB::insert('share_collect1',array('share_id'=>$shareId),false,true);
					FDB::insert('share_collect7',array('share_id'=>$shareId),false,true);
			
					//分享被喜欢数加1
					FS('Share')->updateShareCollectTable($shareId);
					
					//分享会员被喜欢数加1
					FDB::query('UPDATE '.FDB::table('user_count').' SET collects = collects + 1 WHERE uid = '.$share['uid']);
					
				}
			}
			FS('Share')->updateShareCache($shareId,'collects');
		}
		
		return;
	}
}

function getGoodsNameLink($name,$link)
{
	return '<a href="'.$link.'" target="_blank">'.$name.'</a>';
}
?>