<?php
class UtilModule{
	
	/**
	 * 通过$key 在url中搜索参数key-value对的value值
	 * @param $url 传入的url字符串
	 * @param $key 传入的key值
	 * @return Ambigous <>
	 */
	public function URL_getQuery($url, $key){
		$arr = parse_url($url);
		$query = $arr['query'];
		
	    $queryParts = explode('&', $query);
	    $params = array();
	    foreach ($queryParts as $param){
	        $item = explode('=', $param);
	        if($item[0] == $key){
	        	return $item[1];
	        }
	    }
	}
	
	
}
?>