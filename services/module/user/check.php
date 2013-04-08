<?php
$field = trim($_FANWE['request']['field']);
$fields = array('email','user_name','referee');
if(!in_array($field,$fields)){
	exit;
}

$result = array();
$result['status'] = 0;
if($field == 'email'){
	$email = $_FANWE['request']['email'];
	if(empty($email)){
		exit;
	}
	if(!FS('User')->getEmailExists($email)){
		$result['status'] = 1;
	}
}elseif($field == 'user_name'){
	$user_name = $_FANWE['request']['user_name'];
	if(empty($user_name)){
		exit;
	}
	if(!FS('User')->getUserNameExists($user_name)){
		$result['status'] = 1;
	}
}elseif($field == 'referee'){
	$referee = $_FANWE['request']['referee'];
	if(empty($referee)){
		exit;
	}
	if(FS('User')->getUserNameExists($referee)){
		$result['status'] = 1;
	}
}

outputJson($result);
?>