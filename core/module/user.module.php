<?php
class UserModule
{
	public function login()
	{
		global $_FANWE;
                if($_FANWE['uid'] > 0)
			fHeader("location: ".FU('u/index'));

		$cache_file = getTplCache('page/user/user_login');
		if(!@include($cache_file))
		{
			$login_modules = getLoginModuleList();
			include template('page/user/user_login');
		}

		display($cache_file);
	}


	public function ajaxLogin()
	{
		global $_FANWE;
		$user_name_or_email = addslashes($_FANWE['request']['email_name']);
		$password = md5(trim($_FANWE['request']['pass']));
		$life = isset($_FANWE['request']['remember']) ? intval($_FANWE['request']['remember']) : 0;
		$rhash = $_FANWE['request']['rhash'];

		if(empty($rhash) || $rhash != FORM_HASH)
			exit('Access Denied');

		$return = array();
		
		$user_field = $_FANWE['setting']['integrate_field_id'];
		
		$sql = "SELECT uid,status,{$user_field} FROM ".FDB::table('user')." WHERE (email = '$user_name_or_email' OR user_name = '$user_name_or_email') AND password = '$password'";		
		$user_info = FDB::fetchFirst($sql);		
		$uid = intval($user_info['uid']);
		$integrate_id = intval($user_info[$user_field]);
		
		//===========add by chenfq 2011-10-14==========================
		if ($uid <= 0){
			$uid = FS("Integrate")->addUserToLoacl($user_name_or_email,$password, 1);
			
			//重新取一下当前数据库的用户数据
			$sql = "SELECT uid,{$user_field},status FROM ".FDB::table('user')." WHERE uid = '$uid'";
			$user_info = FDB::fetchFirst($sql);
			$uid = intval($user_info['uid']);
			$integrate_id = intval($user_info[$user_field]);
		}
		//===========add by chenfq 2011-10-14==========================
		
		if ($uid > 0)
		{
			if($user_info['status']==0){
				$return['status'] = 2;
				outputJson($return);
				exit();
			}
			$user = array(
				'uid'=>$uid,
				'password'=>$password,
			);
		
                        fSetCookie('last_request', authcode(TIME_UTC - 10, 'ENCODE'), TIME_UTC + 816400, 1, true);
                        FS('User')->setSession($user,$life);
                        
			
			$syslogin_js = FS("Integrate")->synLogin($integrate_id);//js 需要在前台执行 add by chenfq 2011-10-15
			
			//$return['syslogin_js'] = $syslogin_js;
			if (!empty($syslogin_js))
				fSetCookie("dynamic_script",$syslogin_js);	
			$return['status'] = 1;
			$return['uid'] = $uid;
		}
		else
		{
			$return['status'] = 0;
		}

		outputJson($return);
	}

	public function register()
	{
		global $_FANWE;
		if($_FANWE['uid'] > 0){
			fHeader("location: ".FU('u/index'));
		}
		//获取推荐人用户名
		$name = "";
		if($_FANWE['cookie']['referrals_uid']){
			$uid = (int)authcode($_FANWE['cookie']['referrals_uid'], 'DECODE');
			
			if ($uid > 0){
				$name = FDB::resultFirst('SELECT user_name FROM '.FDB::table('user').' WHERE uid = '.$uid);
				if (empty($name)){
					fSetCookie('referrals_uid',0,-1);
				}
			}
		}
        $tpl_path = $_FANWE['setting']['is_open_register']==1? 'page/user/user_register':'page/user/user_not_register';

		$cache_file = getTplCache($tpl_path, array($name));
		if(!@include($cache_file))
		{
			$login_modules = getLoginModuleList();
			include template($tpl_path);
		}

		display($cache_file);
	}

	public function ajaxRegister()
	{
		global $_FANWE;

		$rhash = $_FANWE['request']['rhash'];
		$agreement = isset($_FANWE['request']['agreement']) ? intval($_FANWE['request']['agreement']) : 0;

		if($agreement == 0)
			exit('Access Denied');

		$verify = fAddslashes(explode("\t", authcode($_FANWE['cookie']['verify'.$rhash], 'DECODE',$_FANWE['config']['security']['authkey'])));
		if(empty($rhash) || $rhash != FORM_HASH || empty($verify) || $verify[2] != $rhash || $verify[3] != FORM_HASH)
			exit('Access Denied');

		$result = array();

		$data = array(
			'checkcode'        => strtoupper($_FANWE['request']['checkcode']),
			'email'            => $_FANWE['request']['email'],
			'user_name'        => $_FANWE['request']['user_name'],
			'password'         => $_FANWE['request']['password'],
			'confirm_password' => $_FANWE['request']['confirm_password'],
			'gender'           => intval($_FANWE['request']['gender']),
			'type'           => intval($_FANWE['request']['type']),
		);

		$vservice = FS('Validate');
		$validate = array(
			array('checkcode','equal',lang('user','register_checkcode_error'),$verify[0]),
			array('email','required',lang('user','register_email_require')),
			array('email','email',lang('user','register_email_error')),
			array('user_name','required',lang('user','register_user_name_require')),
			array('user_name','range_length',lang('user','register_user_name_len'),2,20),
			array('user_name','/^[\x{4e00}-\x{9fa5}a-zA-Z][\x{4e00}-\x{9fa5}a-zA-Z0-9]+$/u',lang('user','register_user_name_error')),
			array('password','range_length',lang('user','register_password_range'),6,20),
			array('confirm_password','equal',lang('user','confirm_password_error'),$data['password']),
		);

		if(!$vservice->validation($validate,$data))
		{
			$result['status'] = 0;
			$result['msg'] = $vservice->getError();
			outputJson($result);
		}

		$uservice = FS('User');
		if($uservice->getEmailExists($data['email']))
		{
			$result['status'] = 0;
			$result['msg']	= lang('user','register_email_exist');
			outputJson($result);
		}

		if($uservice->getUserNameExists($data['user_name']))
		{
			$result['status'] = 0;
			$result['msg']	= lang('user','register_user_name_exist');
			outputJson($result);
		}
		
		$referee = $_FANWE['request']['referee'];
		if(!$uservice->getUserNameExists($referee))
		{
			$result['status'] = 0;
			$result['msg']	= lang('user','no_such_referee');
			outputJson($result);
		}

		//================add by chenfq 2011-10-14 =======================
		$user_field = $_FANWE['setting']['integrate_field_id'];
		$integrate_id = FS("Integrate")->addUser($data['user_name'],$data['password'],$data['email']);
		if ($integrate_id < 0){
			$info = FS("Integrate")->getInfo();
			$result['status'] = 0;
			$result['msg']	= $info;
			outputJson($result);
		};
		//================add by chenfq 2011-10-14=======================		
		
		
		$inviteId = null;
		if(!empty($referee)){
			$user = FS("User")->getUsersByName($referee);
			$inviteId = $user['uid'];
		}else{
			$inviteId = FS('User')->getReferrals();
		}
		
		//默认邀请人为uid为系统管理员用户
		if(empty($inviteId)){
			$inviteId = 1;
		}
		
		$user = array(
			'email' => $data['email'],
			'user_name' => $data['user_name'],
			'password'  => $data['password'],
			'type' => $data['type'],
			'invite_id' => $inviteId,
			$user_field => $integrate_id,
		);
		
		$uid = FS('User')->createUser($user);
		if($uid > 0){
			
			//邀请人及注册人给予现金奖励
			$users = array(
						"from"=>array(
							"uid" => $inviteId,
							"nick" => $referee
						),
						"me"=>array(
							"uid" => $uid,
							"nick" => $user['user_name']
						),
					);
			FS("Commission")->reward($users);
			
			$_FANWE['uid'] = $uid;
			$user = array(
				'uid'=>$uid,
				'password'=>md5($data['password']),
			);
                        //判断是否开启邮件激活 ------3.0升级内容
			if($_FANWE['setting']['is_mail_activate']){
                            FS('User')->sendUserActiveMail($uid);
                            fSetCookie('uid',$uid);
                        }else{
                            fSetCookie('last_request', authcode(TIME_UTC - 10, 'ENCODE'), TIME_UTC + 816400, 1, true);
                            FS('User')->setSession($user);
                        }
			
			$syslogin_js = FS("Integrate")->synLogin($integrate_id);//js 需要在前台执行 add by chenfq 2011-10-15
			//$result['syslogin_js'] = $integrate_id.';'.$syslogin_js;
			if (!empty($syslogin_js))
				fSetCookie("dynamic_script",$syslogin_js);		
				
			if($_FANWE['setting']['is_show_follow'] > 0 && $_FANWE['setting']['is_mail_activate']!=1)
				fSetCookie("show_zone_follow",1);	
				
			$result['status'] = 1;
			outputJson($result);
		}
		else
		{
			$result['status'] = 0;
			$result['msg']	= lang('user','register_error');
			outputJson($result);
		}
	}
	
	public function bind()
	{
		global $_FANWE;
		if(empty($_FANWE['cookie']['bind_user_info']))
			fHeader("location: ".FU('user/register'));
		
		$bind_info = unserialize(authcode($_FANWE['cookie']['bind_user_info'], 'DECODE'));
		if(empty($bind_info))
			fHeader("location: ".FU('user/register'));
		
		if(FS('User')->getEmailExists($bind_info['user_email']))
		{
			$bind_info['user_email'] = '';
		}
		
		include template('page/user/user_bind');
		display();
	}
	
	public function saveBind()
	{
		global $_FANWE;
		if(empty($_FANWE['cookie']['bind_user_info']))
			fHeader("location: ".FU('user/register'));
		
		$bind_info = unserialize(authcode($_FANWE['cookie']['bind_user_info'], 'DECODE'));
		if(empty($bind_info))
			fHeader("location: ".FU('user/register'));
		
		$rhash = $_FANWE['request']['rhash'];
		$agreement = isset($_FANWE['request']['agreement']) ? intval($_FANWE['request']['agreement']) : 0;

		if($agreement == 0)
			exit('Access Denied');

		$result = array();
		$data = array(
			'email'            => $_FANWE['request']['email'],
			'user_name'        => $_FANWE['request']['user_name'],
			'password'         => $_FANWE['request']['password'],
			'confirm_password' => $_FANWE['request']['confirm_password'],
			'gender'           => intval($_FANWE['request']['gender']),
		);

		$vservice = FS('Validate');
		$validate = array(
			array('email','required',lang('user','register_email_require')),
			array('email','email',lang('user','register_email_error')),
			array('user_name','required',lang('user','register_user_name_require')),
			array('user_name','range_length',lang('user','register_user_name_len'),2,20),
			array('user_name','/^[\x{4e00}-\x{9fa5}a-zA-Z0-9_]+$/u',lang('user','register_user_name_error')),
			array('password','range_length',lang('user','register_password_range'),6,20),
			array('confirm_password','equal',lang('user','confirm_password_error'),$data['password']),
		);

		if(!$vservice->validation($validate,$data))
			showError('注册失败',$vservice->getError(),-1);

		$uservice = FS('User');
		if($uservice->getEmailExists($data['email']))
			showError('注册失败',lang('user','register_email_exist'),-1);

		if($uservice->getUserNameExists($data['user_name']))
			showError('注册失败',lang('user','register_user_name_exist'),-1);

		//================add by chenfq 2011-10-14 =======================
		$user_field = $_FANWE['setting']['integrate_field_id'];
		$integrate_id = FS("Integrate")->addUser($data['user_name'],$data['password'],$data['email']);
		if ($integrate_id < 0)
		{
			$info = FS("Integrate")->getInfo();
			showError('注册失败',$info,-1);
		};
		//================add by chenfq 2011-10-14=======================		
				
		$user = array(
			'email' => $data['email'],
			'user_name' => $data['user_name'],
			'password'  => md5($data['password']),
			'status'    => 1,
			'email_status' => 0,
			'avatar' => 0,
			'gid' => 7,
			'invite_id' => FS('User')->getReferrals(),
			'reg_time' => TIME_UTC,
			$user_field => $integrate_id,
		);
		//判断是否开启邮件激活 ------3.0升级内容
                if($_FANWE['setting']['bind_is_mail_activate']){
                    $user['status'] = 0;
                }
		$uid = FDB::insert('user',$user,true);
		if($uid > 0)
		{
			$_FANWE['uid'] = $uid;
			FDB::insert('user_count',array('uid' => $uid));
			
			if($user['invite_id'] > 0)
				FS('User')->insertReferral($uid,$user['invite_id'],$user['user_name']);
			
			FS("User")->updateUserScore($uid,'user','register');
			unset($user);
			
			$user_match = array(
				'uid' => $uid,
				'user_name' => FS("Words")->segmentToUnicode($user['user_name']),
			);
			FDB::insert('user_match',$user_match);
			unset($user_match);

			$user_profile = array(
				'uid' => $uid,
				'gender' => $data['gender'],
			);
			FDB::insert('user_profile',$user_profile);
			unset($user_profile);

			$user_status = array(
				'uid' => $uid,
				'reg_ip' => $_FANWE['client_ip'],
				'last_ip' => $_FANWE['client_ip'],
				'last_time' => TIME_UTC,
				'last_activity' => TIME_UTC,
			);
			FDB::insert('user_status',$user_status);

			$user = array(
				'uid'=>$uid,
				'password'=>md5($data['password']),
			);
                        
			//判断是否开启邮件激活 ------3.0升级内容
			if($_FANWE['setting']['bind_is_mail_activate']){
                            FS('User')->sendUserActiveMail($uid);
                            fSetCookie('uid',$uid);
                        }else{
                            fSetCookie('last_request', authcode(TIME_UTC - 10, 'ENCODE'), TIME_UTC + 816400, 1, true);
                            FS('User')->setSession($user);
                        }
			
			
			$syslogin_js = FS("Integrate")->synLogin($integrate_id);//js 需要在前台执行 add by chenfq 2011-10-15
			if (!empty($syslogin_js))
				fSetCookie("dynamic_script",$syslogin_js);	
					
			require_once FANWE_ROOT."core/class/user/".$bind_info['type'].".class.php";
			$class = ucfirst($bind_info['type']).'User';
			$class = new $class();
			$class->bindByData($bind_info);
			fHeader("location:".FU('u/index'));
		}
		else
		{
			showError('注册失败',lang('user','register_error'),-1);
		}
	}

	function forgetPassword()
	{
		global $_FANWE;
		$method = strtolower($_SERVER["REQUEST_METHOD"]);
		if($method == 'post')
		{
			$data = array(
				'email'            => $_FANWE['request']['email'],
				'user_name'        => $_FANWE['request']['user_name']
			);

			$data_error = false;
			$send_error = true;

			$vservice = FS('Validate');
			$validate = array(
				array('email','required',lang('user','register_email_require')),
				array('email','email',lang('user','register_email_error')),
				array('user_name','required',lang('user','register_user_name_require')),
				array('user_name','range_length',lang('user','register_user_name_len'),2,20),
				array('user_name','/^[\x{4e00}-\x{9fa5}a-zA-Z][\x{4e00}-\x{9fa5}a-zA-Z0-9_]+$/u',lang('user','register_user_name_error'))
			);

			if(!$vservice->validation($validate,$data))
				$data_error = true;
			else
			{
				$uid = FDB::resultFirst('SELECT uid
					FROM '.FDB::table('user').'
					WHERE user_name = \''.$data['user_name'].'\' AND email = \''.$data['email'].'\'');

				$uid = intval($uid);
				if($uid == 0)
					$data_error = true;
				else
				{
					$reset_hash = md5(microtime(true).random(8));
					FDB::query('UPDATE '.FDB::table('user_status').'
						SET reset_hash = \''.$reset_hash.'\'
						WHERE uid = '.$uid);

					$site_name = $_FANWE['setting']['site_name'];
					$reset_url = $_FANWE['site_url'].'user.php?action=resetpassword&resethash='.$reset_hash;
					$title = sprintf(lang('user','get_pwd_title'),$site_name);
					$content = sprintf(lang('user','get_pwd_html'),$site_name,$reset_url,$reset_url,$site_name,$_FANWE['site_url'],$site_name);
					include fimport("class/mail");
					$mail = new Mail();
					if($mail->send($data['user_name'],$data['email'],$title,$content,1))
						$send_error = false;
				}
			}
		}

		include template('page/user/user_getpwd');
		display();
	}

	public function resetPassword()
	{
		global $_FANWE;
		$hash = $_FANWE['request']['resethash'];
		if(empty($hash))
			fHeader("location: ".FU('user/login'));

		$uid = FDB::resultFirst('SELECT uid
			FROM '.FDB::table('user_status').'
			WHERE reset_hash = \''.$hash.'\'');
		$uid = intval($uid);
		
				
		if($uid == 0)
			fHeader("location: ".FU('user/login'));

		$method = strtolower($_SERVER["REQUEST_METHOD"]);
		if($method == 'post')
		{
			$data_error = false;

			$data = array(
				'password'         => $_FANWE['request']['password'],
				'confirm_password' => $_FANWE['request']['confirm_password']
			);

			$vservice = FS('Validate');
			$validate = array(
				array('password','range_length',lang('user','register_password_range'),6,20),
				array('confirm_password','equal',lang('user','confirm_password_error'),$data['password']),
			);

			if(!$vservice->validation($validate,$data))
				$data_error = true;
			else
			{
				//==================添加同步密码修改 chenfq 2011-10-15================
				$user_field = $_FANWE['setting']['integrate_field_id'];
				$sql = "SELECT {$user_field} FROM ".FDB::table('user')." WHERE uid = '$uid'";
				$integrate_id = intval(FDB::resultFirst($sql));
				if ($integrate_id > 0 ){
					FS("Integrate")->editUser($integrate_id, $_FANWE['request']['password'],'','');
				}
				//==================添加同步密码修改 chenfq 2011-10-15================
								
				FDB::query('UPDATE '.FDB::table('user').'
					SET password = \''.md5($data['password']).'\'
					WHERE uid = '.$uid);

				FDB::query('UPDATE '.FDB::table('user_status').'
					SET reset_hash = \'\'
					WHERE uid = '.$uid);
			}
		}
		include template('page/user/user_resetpwd');
		display();
	}

	public function logout()
	{
		global $_FANWE;
		$_FANWE['nav_title'] = lang('common','user_logout');
		FS('User')->clearSession();
		
		//====add by chenfq 2011-10-14=========
		$syslogout_js = FS("Integrate")->synLogout();//js 需要在前台执行
		//echo $syslogout_js; exit;
		if (!empty($syslogout_js))
			fSetCookie("dynamic_script",$syslogout_js);
		fHeader("location: ".FU('index/index'));
	}

	public function interest()
	{
		global $_FANWE;
		FanweService::instance()->cache->loadCache('usertagcate');
		include template('page/user/user_interest');
		display();
	}
	
	public function agreement()
	{
		global $_FANWE;
		$title = sprintf(lang('common','user_agreement'),$_FANWE['setting']['site_name']);
		$_FANWE['nav_title'] = $title;
		
		$cache_file = getTplCache('page/user/user_agreement');
		if(!@include($cache_file))
		{
			include template('page/user/user_agreement');
		}
		display($cache_file);
	}
	
	public function commission()
	{
		global $_FANWE;
		if($_FANWE['setting']['is_open_commission'] == 0)
			fHeader("location: ".FU('index/index'));
		
		$title = sprintf(lang('common','user_commission'),$_FANWE['setting']['site_name']);
		$_FANWE['nav_title'] = $title;
		
		$cache_file = getTplCache('page/user/user_commission');
		if(!@include($cache_file))
		{
			include template('page/user/user_commission');
		}
		display($cache_file);
	}
        public function sendActivateMail(){
                global $_FANWE;
                $title = lang('common','user_mail_activate');
		$_FANWE['nav_title'] = $title;
                $uid = $_FANWE['cookie']['uid'];
                if($uid>0){
                    $sql = "SELECT email FROM ".FDB::table('user')." WHERE uid = ".$uid;		
                    $user_info = FDB::fetchFirst($sql);
                    preg_match ('/\@([a-z]|[0-9])*/i',$user_info['email'],$str_arr);
                    $mail = substr($str_arr[0], 1);
                }else{
                    fHeader("location: ".FU('user/register'));
                }
                
                include template('page/user/send_activate_mail');
		display();
        }
        function verifyUserMail(){
                global $_FANWE;
                $sn = $_REQUEST['sn'];
                $sql_str = 'update ' . DB_PREFIX . 'user set last_ip = \'' . $_SESSION ["CLIENT_IP"] . '\',status = 1 where user_name = \'' . $userinfo ['user_name'] . '\' limit 1';
                $userinfo = FDB::fetchFirst('select * from '.FDB::table('user').' where active_sn =\''.$sn.'\'');
                $user = array(
                    'uid'=>$userinfo['uid'],
                    'password'=>$userinfo['password'],
                );
                fSetCookie('last_request', authcode(TIME_UTC - 10, 'ENCODE'), TIME_UTC + 816400, 1, true);
                FS('User')->setSession($user);
		
		if($_FANWE['setting']['is_show_follow'] > 0 )
				fSetCookie("show_zone_follow",1);
                fHeader("location: ".FU('index/index'));
        }
        
        function mailRssCancel(){
            global $_FANWE;
            $rss_sn = $_FANWE['request']['rss_sn'];
            $rss_info = FS('MailRss')->checkRssSn($rss_sn);
            $rss_cate = FS('MailRss')->getRssCate(array(0,1),array('cate_id='.$rss_info['cate_id']));
            FS('MailRss')->removeRss($rss_info['cate_id'],$rss_info['uid']);
            include template('page/user/mail_rss_cancel');
            display();
        }
}
?>