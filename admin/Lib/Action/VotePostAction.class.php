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

 +------------------------------------------------------------------------------
 */
class VotePostAction extends CommonAction
{
	public function index()
	{
		if(isset($_REQUEST['vid']))
			$vid = intval($_REQUEST['vid']);
		else
			$vid = intval($_SESSION['vote_post_tid']);
		
		$_SESSION['vote_post_tid'] = $vid;
		
		$where = 'WHERE vp.vid = ' . $vid;
		$parameter = array();
		$uname = trim($_REQUEST['uname']);
		
		$is_empty = false;
		if(!empty($uname))
		{
			$this->assign("uname",$uname);
			$parameter['uname'] = $uname;
			$uid = (int)D('User')->where("user_name = '".$uname."'")->getField('uid');
			if($uid == 0)
				$is_empty = true;
			else
				$where.=" AND vp.uid = ".$uid;
		}
		
		if(!$is_empty)
		{
			$model = M();
			
			$sql = 'SELECT COUNT(DISTINCT vp.id) AS pcount 
				FROM '.C("DB_PREFIX").'vote_post AS vp '.$where;
			
			$count = $model->query($sql);
			$count = $count[0]['pcount'];
	
			$sql = 'SELECT vp.id,LEFT(vp.content,80) AS content,u.user_name,vp.create_time,vp.share_id  
				FROM '.C("DB_PREFIX").'vote_post AS vp 
				LEFT JOIN '.C("DB_PREFIX").'user AS u ON u.uid = vp.uid 
				'.$where.' GROUP BY vp.id';
			$this->_sqlList($model,$sql,$count,$parameter,'vp.id',false,'returnUrl1');
		}
		$this->display ();
		return;
	}

    public function update()
    {
        Vendor("common");
        $id = intval($_REQUEST['id']);
        $share_id = D('VotePost')->where("id = '$id'")->getField('share_id');
        if($share_id > 0)
        {
            $content = trim($_REQUEST['content']);
            FS("Share")->updateShare($share_id,'',$content);
        }
        parent::update();
    }

	public function remove()
	{
		//删除指定记录
		Vendor("common");
		$result = array('isErr'=>0,'content'=>'');
		$id = $_REQUEST['id'];
		if(!empty($id))
		{
			$name=$this->getActionName();
			$model = D($name);
			$pk = $model->getPk ();
			$condition = array ($pk => array ('in', explode ( ',', $id ) ) );
			$count = $model->where ( $condition )->count();
			$res = $model->where ( $condition )->select();

			foreach($res as $item)
			{
				$share_id = intval($item['share_id']);
                FS("Vote")->deletePost($share_id);
			}

			$this->saveLog(1,$id);
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
		Cookie::set ( '_currentUrl_',NULL );
		parent::edit();
	}
}

?>