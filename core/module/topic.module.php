<?php
class TopicModule
{
	public function detail()
	{
		global $_FANWE;
		$tid = (int)$_FANWE['request']['tid'];
		$topic = FS('Topic')->getTopicById($tid);
		if(empty($topic))
			fHeader('location: '.FU('group/index'));

		$topic['time'] = getBeforeTimelag($topic['create_time']);
		$topic['share'] = FS('Share')->getShareDetail($topic['share_id']);
		$topic['share_content'] = str_replace(array("\r","\n"),' ',$topic['content']);
		$user_share_collect = FS('Share')->getShareCollectUser($topic['share_id']);
		$topic_user = FS('User')->getUserShowName($topic['uid']);
		$forum_id = $topic['fid'];
		$group_detail = FS('Group')->getGroupById($forum_id);
		
		$_FANWE['PAGE_SEO_SELF'] = $topic;
		$_FANWE['PAGE_SEO_SELF']['content'] = cutStr(strip_tags($topic['content']),80,'');
		$_FANWE['PAGE_SEO_SELF']['user_name'] = $topic_user['name'];
		$_FANWE['PAGE_SEO_SELF']['group_name'] = $group_detail['name'];
		$_FANWE['PAGE_SEO_SELF']['group_tags'] = $group_detail['tags'];
		$seo_user = FS('User')->getUserById($group_detail['uid']);
		$_FANWE['PAGE_SEO_SELF']['group_user_name'] = $seo_user['user_name'];
		Cache::getInstance()->loadCache('forum_category');
		if(isset($_FANWE['cache']['forum_category'][$group_detail['cid']]))
		{
			$_FANWE['PAGE_SEO_SELF']['group_cate_name'] = $_FANWE['cache']['forum_category'][$group_detail['cid']]['cate_name'];
		}
		unset($_FANWE['PAGE_SEO_SELF']['share']);
		
		FS('Topic')->updateTopicLooksCache($id);
		$topic_looks = FS('Topic')->getTopicLooks($id,33);
		
		$user_new_topics = FS('Topic')->getUserNewTopicList($tid,$topic['uid'],6);
		$user_groups = FS('Group')->getGroupsByUid($topic['uid'],9);

		if($forum_id > 0)
			$topic_bests = FS('Topic')->getImgTopic('best',5,1,$topic['fid'],0,array($tid));
		
		$is_best = FS('Topic')->getIsBestTid($tid);
		$best_count = $topic['best_count'];
		$best_users =  FS("Topic")->getBestUsers($tid,9);
		$is_group_admin = 0;
		if($forum_id > 0)
		{
			$is_group_admin = FS('Group')->isAdminFromGroup($forum_id,$_FANWE['uid']);
			$is_join_group = FS('Group')->isUserFromGroup($forum_id,$_FANWE['uid']);
		}
		else
			$is_join_group = 1;
		
		$page_args = array(
			'tid'=>$tid
		);

		$count = $topic['post_count'];
		$pager = buildPage('topic/detail',$page_args,$count,$_FANWE['page'],10);
		$post_list = FS('Topic')->getTopicPostList($tid,$pager['limit']);

		$args = array(
			'share_list'=>&$post_list,
			'pager'=>&$pager,
			'current_share_id'=>$topic['share_id']
		);
		$post_html = tplFetch("inc/share/post_share_list",$args);

		include template('page/topic/topic_detail');
		display();
	}

	public function create()
	{
		global $_FANWE;
		if($_FANWE['uid'] == 0)
			fHeader('location: '.FU('user/login'));
		
		$forum_id = (int)$_FANWE['request']['fid'];
		$group_detail = FS('Group')->getGroupById($forum_id);
		if(empty($group_detail))
			fHeader('location: '.FU('group/index'));
		
		$bln = FS('Group')->isUserFromGroup($forum_id,$_FANWE['uid']);
		if($bln < 1)
			fHeader('location: '.FU('group/detail',array('fid'=>$forum_id)));
		
		$_FANWE['nav_title'] = lang('common','club_newtopic');
		include template('page/topic/topic_create');
		display();
	}

	public function save()
	{
		global $_FANWE;
		if($_FANWE['uid'] == 0)
			fHeader('location: '.FU('group/index'));

		$forum_id= (int)$_FANWE['request']['fid'];
		$group_detail = FS('Group')->getGroupById($forum_id);
		if(empty($group_detail))
			fHeader('location: '.FU('group/index'));
			
		$bln = FS('Group')->isUserFromGroup($forum_id,$_FANWE['uid']);
		if($bln < 1)
			fHeader('location: '.FU('group/detail',array('fid'=>$forum_id)));

		$_FANWE['request']['title'] = trim($_FANWE['request']['title']);
		$_FANWE['request']['content'] = trim($_FANWE['request']['content']);
		if($_FANWE['request']['title'] == '' || $_FANWE['request']['content'] == '')
			fHeader('location: '.FU('group/detail',array('fid'=>$forum_id)));

		$_FANWE['request']['uid'] = $_FANWE['uid'];
		$_FANWE['request']['type'] = 'bar';

		if(!checkIpOperation("add_share",SHARE_INTERVAL_TIME))
		{
			showError('提交失败',lang('share','interval_tips'),-1);
		}

		$check_result = FS('Share')->checkWord($_FANWE['request']['content'],'content');
		if($check_result['error_code'] == 1)
		{
			showError('提交失败',$check_result['error_msg'],-1);
		}

		$check_result = FS('Share')->checkWord($_FANWE['request']['title'],'title');
		if($check_result['error_code'] == 1)
		{
			showError('提交失败',$check_result['error_msg'],-1);
		}

		$check_result = FS('Share')->checkWord($_FANWE['request']['tags'],'tag');
		if($check_result['error_code'] == 1)
		{
			showError('提交失败',$check_result['error_msg'],-1);
		}

		$thread = array();
		$thread['fid'] = $forum_id;
		//FIXME frankie 已去除使用，删除数据库字段
		$thread['share_id'] = 0;
		$thread['uid'] = $_FANWE['uid'];
		$thread['title'] = htmlspecialchars($_FANWE['request']['title']);
		$thread['content'] = $_FANWE['request']['content'];
		$thread['create_time'] = TIME_UTC;
		$tid = FDB::insert('forum_thread',$thread,true);
			
		$content_match = FS('Words')->segmentToUnicode($thread['title']);
		FDB::insert("forum_thread_match",array('tid'=>$tid,'content'=>$content_match));

		FDB::query("update ".FDB::table("user_count")." set forums = forums + 1,threads = threads + 1 where uid = ".$_FANWE['uid']);
		FDB::query("update ".FDB::table("forum")." set thread_count = thread_count+1 where fid = ".$forum_id);

		FS('Medal')->runAuto($_FANWE['uid'],'forums');
		FS('User')->medalBehavior($_FANWE['uid'],'continue_forum');
		fHeader('location: '.FU('group/detail',array('fid'=>$forum_id)));
	}

	public function edit()
	{
		global $_FANWE;
		if($_FANWE['uid'] == 0)
			fHeader('location: '.FU('group/index'));
			
		$tid= (int)$_FANWE['request']['tid'];
		if($tid == 0)
			fHeader('location: '.FU('group/index'));
			
		$topic_detail = FS('Topic')->getTopicById($tid);
		if(empty($topic_detail))
			fHeader('location: '.FU('group/index'));

		$forum_id = $topic_detail['fid'];
		$is_group_admin = 0;
		if($forum_id > 0)
			$is_group_admin = FS('Group')->isAdminFromGroup($forum_id,$_FANWE['uid']);
		
		if($is_group_admin == 0 && $topic_detail['uid'] != $_FANWE['uid'])
			fHeader('location: '.FU('group/index'));

		$group_detail = FS('Group')->getGroupById($forum_id);
		include template('page/topic/topic_edit');
		display();
	}
	
	public function update()
	{
		global $_FANWE;
		if($_FANWE['uid'] == 0)
			fHeader('location: '.FU('group/index'));
			
		$tid= (int)$_FANWE['request']['tid'];
		if($tid == 0)
			fHeader('location: '.FU('group/index'));
		
		$title = trim($_FANWE['request']['title']);
		$content = trim($_FANWE['request']['content']);
		if($title == '' || $content == '')
			fHeader('location: '.FU('group/index'));
			
		$topic_detail = FS('Topic')->getTopicById($tid);
		if(empty($topic_detail))
			fHeader('location: '.FU('group/index'));

		$forum_id = $topic_detail['fid'];
		$is_group_admin = 0;
		if($forum_id > 0)
			$is_group_admin = FS('Group')->isAdminFromGroup($forum_id,$_FANWE['uid']);

		if($is_group_admin == 0 && $topic_detail['uid'] != $_FANWE['uid'])
			fHeader('location: '.FU('group/index'));
		
		$check_result = FS('Share')->checkWord($title,'title');
		if($check_result['error_code'] == 1)
		{
			showError('提交失败',$check_result['error_msg'],-1);
		}
		
		$check_result = FS('Share')->checkWord($content,'content');
		if($check_result['error_code'] == 1)
		{
			showError('提交失败',$check_result['error_msg'],-1);
		}

		if($topic_detail['title'] != $title || $topic_detail['content'] != $content)
		{
			FS("Share")->updateShare($topic_detail['share_id'],$title,$content);
		}

		FS("Topic")->updateTopic($tid,$title,$content);
		fHeader('Location: '.FU('topic/detail',array('tid'=>$tid)));
	}
}
?>