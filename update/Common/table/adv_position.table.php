<?php
FDB::query('TRUNCATE TABLE '.FDB::table($tableTaget));
$sql = 'INSERT INTO '.FDB::table($tableTaget).' SELECT `id`,`name`,`width`,`height`,`is_flash`,`flash_style`,`style`,`status`,0,\'\' FROM '.$oldDB->tableName($tableTaget);
FDB::query($sql,'SILENT');

$item = array();
$item['name'] = '逛街分类广告位';
$item['width'] = 319;
$item['height'] = 109;
$item['is_flash'] = 0;
$item['flash_style'] = '';
$item['style'] = '{loop $adv_list $adv}'."\r\n".'{$adv[html]}'."\r\n".'{/loop}';
$item['status'] = 1;
$item['is_fix'] = 1;
$item['code'] = 'book_cate';
$ap_id = FDB::insert($tableTaget,$item,true);

$item = array();
$item['position_id'] = $ap_id;
$item['name'] = '逛街分类广告-逛街啦-1';
$item['code'] = './public/upload/images/201206/05/4fce2753ac27d.jpg';
$item['type'] = 1;
$item['status'] = 1;
$item['url'] = 'http://www.fanwe.com';
$item['desc'] = '';
$item['target_key'] = 'cate1';
$item['sort'] = 100;
$item['small'] = '';
FDB::insert('adv',$item);

showjsmessage(U('Index/updatetable',array('table'=>$tableIndex + 1)),5);
?>