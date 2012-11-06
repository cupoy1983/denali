<?php
FDB::query('TRUNCATE TABLE '.FDB::table('shop_share'));
FDB::query('INSERT INTO '.FDB::table('shop_share').'(shop_id,share_id,uid) 
	SELECT shop_id,share_id,uid FROM '.FDB::table('share_goods').' WHERE shop_id > 0 GROUP BY share_id,shop_id');
showjsmessage(U('Index/updatetable',array('table'=>$tableIndex + 1)),5);
?>