<?php if (!defined('THINK_PATH')) exit();?><!DOCTYPE html PUBLIC '-//W3C//DTD XHTML 1.0 Transitional//EN' 'http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd'><html><head><title>方维分享系统  -- 更新向导</title><meta http-equiv="Content-Type" content="text/html; charset=utf-8"><link rel="stylesheet" type="text/css" href="__TMPL__Public/css/style.css" /><script type="text/javascript" src="__TMPL__Public/js/jquery.js"></script><script type="text/javascript" src="__TMPL__Public/js/jquery.json.js"></script><script type="text/javascript" src="__TMPL__Public/js/script.js"></script></head><body><div class="install"><div class="header"><h1></h1></div><div class="main"><h2 class="title" style="margin-left:30px;">目录、文件权限检查</h2><table class="tb" style="margin:20px 0 20px 30px; width:600px;" cellspacing="1"><tr><th class="center">目录文件</th><th class="center">所需状态</th><th class="center">检查结果</th></tr><?php if(is_array($check_dirs)): foreach($check_dirs as $key=>$file): ?><tr><td><?php echo ($file["name"]); ?></td><td class="center"><?php echo ($file["ask"]); ?></td><td class="center"><span class="<?php if($file["status"] == 1): ?>w<?php else: ?>nw<?php endif; ?>"><?php echo ($file["msg"]); ?></span></td></tr><?php endforeach; endif; ?></table><div class="center" style="padding:0 0 20px 0;"><?php if($status == 1): ?><input type="button" value="下一步" class="formbutton" onclick="location.href='<?php echo u('Index/update');?>'" /><?php endif; ?></div><div class="center footer">		方维分享系统
	</div></div></div></body></html>