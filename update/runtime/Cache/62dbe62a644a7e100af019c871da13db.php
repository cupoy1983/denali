<?php if (!defined('THINK_PATH')) exit();?><!DOCTYPE html PUBLIC '-//W3C//DTD XHTML 1.0 Transitional//EN' 'http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd'><html><head><title>方维分享系统  -- 更新向导</title><meta http-equiv="Content-Type" content="text/html; charset=utf-8"><link rel="stylesheet" type="text/css" href="__TMPL__Public/css/style.css" /></head><body><div class="install block"><div class="header"><h1></h1></div><div class="main"><div class="center" style="padding:0 0 10px 0;">		提示：如果出现长时间停顿，可点击【<a href="javascript:;" onclick="location.reload(true)" style="color:#00f;">刷新</a>】
	</div><div class="btnbox"><div id="notice"><p style="text-align:center; padding:130px 0 0 0;"></p></div></div><div id="back" class="center" style="padding:20px 0; display:none;"><input type="button" value="刷新" class="formbutton" onclick="location.reload(true);" /></div><div class="center footer">		方维分享系统
	</div></div><script type="text/javascript">	function showmessage(message,isBack) {
		if(isBack == -1)
		{
			document.getElementById('notice').innerHTML = "";
		}
		if(isBack == 1)
		{
			document.getElementById('back').style.display = "block";
			message = "<span class='red'>"+ message +"</span>";
		}
		else if(isBack == 2)
		{
			message = "<span class='c00f'>"+ message +"</span>";
		}
		else if(isBack == 3)
		{
			message = "<span class='c00f'>"+ message +"</span>";
		}
		else if(isBack == 4)
		{
			message = "<span class='c00f'>"+ message +"</span>";
			setTimeout("goadmin()",500);
		}
		else if(isBack == 5)
		{
			var fun = function(){
				location.href = message;
			};
			
			setTimeout(fun,10);
			return false;
		}
		
		var html = document.getElementById('notice').innerHTML;
		if(html == "")
			document.getElementById('notice').innerHTML = message;
		else
			document.getElementById('notice').innerHTML = message + '<br />' + html;
	}
	
	function goadmin()
	{
		location.href = "../admin/index.php";
	}
</script></div></body></html>