<?php
$sql = "ALTER TABLE `".FDB::table('share')."` MODIFY COLUMN `type`  enum('default','fav','comments','bar','bar_post','bar_best','album','album_item','album_best','album_rec','event','event_post','group','group_join','group_best','activity','activity_post','vote','vote_post','trial','trial_apply','trial_post') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'default'";
FDB::query($sql);

$sql = "ALTER TABLE `".FDB::table('share')."` ADD `seo_title` VARCHAR( 255 ) NOT NULL DEFAULT '',ADD `seo_keywords` VARCHAR( 255 ) NOT NULL DEFAULT '',ADD `seo_description` VARCHAR( 255 ) NOT NULL DEFAULT  ''";
FDB::query($sql);

showjsmessage("升级分享数据表成功",2);
showjsmessage(U('Index/updatetable',array('table'=>$tableIndex + 1)),5);
?>