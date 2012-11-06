<?php

/*
 * 邮件订阅系统
 * jobin.lin
 */
class MailRssModule
{
    function index(){
        global $_FANWE;

        //订阅列表
        $rss_cates = FS('MailRss')->getRssCate(array(0,10),array('parent_id <> 0'));
        //订阅用户列表
        $rss_user_list = FS('MailRss')->getRssUser(array(0,10));

        include template('page/mailrss/mailrss_index');
        display();
        
    }
        
    function show(){
        global $_FANWE;
        $id = $_FANWE['request']['id'];
        if(empty ($id))
            return false;

        $cache_file = getTplCache('page/mailrss/mailrss_show',array(),1);
        if(getCacheIsUpdate($cache_file,SHARE_CACHE_TIME,1)){
            $rss_cate = FS('MailRss')->getRssCate(array(0,1),array('cate_id='.$id,'parent_id <> 0'));
            $rss_cate_item = $rss_cate['list'][0];
            //订阅用户列表
            $rss_user_list = FS('MailRss')->getRssUser(array(0,10));
            include template('page/mailrss/mailrss_show');
            display($cache_file);
        }else{
            include $cache_file;
            display();
        }
    }
    
    function ajax_rss(){
        global $_FANWE;
        if(empty($_FANWE['uid']))
            return FALSE;
        
        $data['uid'] = $_FANWE['uid'];
        $data['cate_id'] = $_FANWE['request']['cate_id'];
        $data['create_time'] = TIME_UTC;
        $data['status'] = 1;
        $data['rss_sn'] = md5('mail_rss_'.$data['uid'].'_'.$data['cate_id'].'_'.TIME_UTC);
        
        if(FS('MailRss')->saveRss($data))
                $result['status'] = 1;
            outputJson($result);
        
    }

    
    function ajax_remove_rss(){
        global $_FANWE;
        if(empty($_FANWE['uid']))
            return FALSE;
        if(FS('MailRss')->removeRss($_FANWE['request']['cate_id'],$_FANWE['uid']))
                 $result['status'] = 1;
             outputJson($result);
    }
}
?>
