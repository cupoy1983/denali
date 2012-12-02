<?php
class FanLiModule{
	
	function index(){
		global $_FANWE;
		$cache_file = null;
		//FIXME $cache_file = getTplCache('page/fanli/fanli_index');
		if(!@include($cache_file))
		{
			include template('page/fanli/fanli_index');
		}
		display($cache_file);
	}
}

?>