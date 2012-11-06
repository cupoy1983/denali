<?php
FDB::query('TRUNCATE TABLE '.FDB::table('forum_post'));
$sql = 'INSERT INTO '.FDB::table('forum_post').'(`pid`, `tid`, `share_id`, `uid`, `content`, `create_time`) SELECT `pid`, `tid`, `share_id`, `uid`, `content`, `create_time` FROM '.$oldDB->tableName('forum_post');
FDB::query($sql,'SILENT');

FDB::query('TRUNCATE TABLE '.FDB::table('forum_thread'));
$sql = 'INSERT INTO '.FDB::table('forum_thread').'(`tid`, `fid`, `share_id`, `uid`, `title`, `content`, `is_top`, `is_best`, `is_event`, `sort`, `post_count`, `create_time`, `best_count`, `lastpost`, `lastposter`) SELECT `tid`,0, `share_id`, `uid`, `title`, `content`, `is_top`, `is_best`, `is_event`, `sort`, `post_count`, `create_time`,0, `lastpost`, `lastposter` FROM '.$oldDB->tableName('forum_thread');
FDB::query($sql,'SILENT');

FDB::query('ALTER TABLE '.FDB::table('forum_post').' ADD COLUMN `type` tinyint(1) NULL DEFAULT 0','SILENT');
FDB::query('CREATE INDEX `type` ON '.FDB::table('forum_post').'(`type`)','SILENT');
FDB::query('ALTER TABLE '.FDB::table('forum_thread').' ADD COLUMN `old_tid` int(11) NULL DEFAULT 0','SILENT');
FDB::query('CREATE INDEX `old_tid` ON '.FDB::table('forum_post').'(`old_tid`)','SILENT');

$sql = 'INSERT INTO '.FDB::table('forum_post').'(`tid`, `share_id`, `uid`, `content`, `create_time`,`type`) SELECT `tid`, `share_id`, `uid`, `content`, `create_time`,1 FROM '.$oldDB->tableName('ask_post');
FDB::query($sql,'SILENT');

$sql = 'INSERT INTO '.FDB::table('forum_thread').'(`fid`, `share_id`, `uid`, `title`, `content`, `is_top`, `is_best`, `is_event`, `sort`, `post_count`, `create_time`, `best_count`, `lastpost`, `lastposter`,`old_tid`) SELECT 0, `share_id`, `uid`, `title`, `content`, `is_top`, `is_best`,0, `sort`, `post_count`, `create_time`,0, `lastpost`, `lastposter`,`tid` FROM '.$oldDB->tableName('ask_thread');
FDB::query($sql,'SILENT');

FDB::query('UPDATE '.FDB::table('forum_post').' SET tid = (SELECT tid FROM '.FDB::table('forum_thread').' WHERE old_tid = '.FDB::table('forum_post').'.tid) WHERE type = 1','SILENT');

FDB::query('ALTER TABLE '.FDB::table('forum_post').' DROP COLUMN `type`','SILENT');
FDB::query('ALTER TABLE '.FDB::table('forum_thread').' DROP COLUMN `old_tid`','SILENT');
showjsmessage(U('Index/updatetable',array('table'=>$tableIndex + 1)),5);
?>