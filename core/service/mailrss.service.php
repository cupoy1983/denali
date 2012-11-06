<?php
class MailRssService{
    
    /**
     *
     * @param array $limit
     * @param array $where
     * @return array 
     */
    function getRssCate($limit,$where = null){
        global $_FANWE;

        if($where)
            $where_str = ' where status = 1 and '.implode (' and ', $where);

        $count_sql = 'SELECT count(*) FROM '.FDB::table('mail_rss_category').$where_str;
        $data['count']  = FDB::resultFirst($count_sql);
        if($_FANWE['uid'])
            $sql = 'SELECT rc.*,(SELECT COUNT(ru.id) FROM '.FDB::table('mail_rss_user').' as ru WHERE ru.uid ='.$_FANWE['uid'].' and ru.cate_id = rc.cate_id ) as is_rss FROM '.FDB::table('mail_rss_category').' rc '.$where_str.' ORDER BY sort ASC,rc.cate_id DESC LIMIT '.implode(',', $limit);
        else
            $sql = 'SELECT *  FROM '.FDB::table('mail_rss_category').$where_str.' ORDER BY sort ASC,cate_id DESC LIMIT '.implode(',', $limit);
        $data['list'] = FDB::fetchAll($sql);

        return $data;
    }
    
    function getRssUser($limit,$where = null){
        global $_FANWE;
        $key = 'mailrss/cate/rssuser_'.  implode('-', $limit).  md5(implode('-', $where));
        $data = getCache($key);
        if($data === null){
             if($where)
                $where_str = ' where ru.status = 1 and '.implode (' and ', $where);
             $count_sql = 'SELECT COUNT(*) FROM '.FDB::table('mail_rss_user').$where_str;
             
             $sql = 'SELECT ru.*,u.user_name,rc.short_name FROM '.FDB::table('mail_rss_user').' ru 
                 LEFT JOIN '.FDB::table('user').' u ON u.uid = ru.uid  
                 LEFT JOIN '.FDB::table('mail_rss_category').' rc on rc.cate_id = ru.cate_id'.$where_str;
             
             $data['count']  = FDB::resultFirst($count_sql);
             $data['list'] = FDB::fetchAll($sql);
             setCache($key);
        }
        return $data;
        
    }
    
    function saveRss($data){
        if(FDB::resultFirst('SELECT COUNT(*) from '.FDB::table('mail_rss_user').' WHERE uid='.$data['uid'].' and cate_id = '.$data['cate_id']))
                return false;
        
        if($id = FDB::insert('mail_rss_user',$data,true)){
            //更新订阅数量
            FDB::query('update '.FDB::table('mail_rss_category').' set rss_count = rss_count+1 where cate_id = '.$data['cate_id']);
            return true;
        }else{
            return false;
        }
    }
    
    function removeRss($cate_id,$uid){
        if($uid>0 && $cate_id>0){
            FDB::delete('mail_rss_user',array('uid'=>$uid,'cate_id'=>$cate_id));
            FDB::query('update '.FDB::table('mail_rss_category').' set rss_count = rss_count-1 where cate_id= '.$cate_id);
            return true;
        }else{
            return false;
        }
         
    }
    function checkRssSn($sn){
        return FDB::fetchFirst('SELECT * FROM '.FDB::table('mail_rss_user').' WHERE rss_sn=\''.$sn.'\'');
    }
}
?>
