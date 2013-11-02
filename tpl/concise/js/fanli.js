function abc($t){
	u =$t.attr('href').replace(/&rf=[\w-%\.]+&/,'&rf='+encodeURIComponent("http://www.changxingba.com")+'&');
	 var url = $t.attr('togo')+'&url='+encodeURIComponent(u);
	 $t.attr('href',url);
	 return true; 
}

function getCommission() {
	var url = $("#J_Search").val();
	//在JavaScript中，正则表达式只能使用"/"开头和结束，不能使用双引号
    var Expression=/([\w-]+\.)+[\w-]+(\/[\w- .\/?%&=]*)?/;
    var exp=new RegExp(Expression);
	var id = getUrlParam(url, 'id');
	
	if (/\d+/gi.test(id) && exp.test(url)) {
		ItemsConvert(id);
	} else {
		alert('Sorry，链接错误，请输入正确的宝贝地址！');
		window.location.reload();
	}
}
function getUrlParam(url, paramName) {
	var oRegex = new RegExp('[?&]' + paramName + '=([^&]+)', 'i');
	var oMatch = oRegex.exec(url);
	if (oMatch && oMatch.length > 1)
		return decodeURIComponent(oMatch[1]);
	else
		return '';
}
function ItemsConvert(iid) {
	
	TOP.api({
		method : 'taobao.item.get',
		fields : 'iid,detail_url,num_iid,title,nick,type,cid,pic_url,seller_cids,num,list_time,delist_time,stuff_status,location,price,post_fee,express_fee,ems_fee,has_discount,freight_payer,item_img',
		num_iid : iid
	}, function(resp) {
		if (resp.item) {
			$("#resultContainer .result").css("display", "block");
			var result = resp.item;
			var title = result.title;
			var price = result.price;
			var picUrl = result.pic_url;
			var nick = result.nick;
			var location = result.location.city + " " + result.location.state;
			var rate = Math.ceil(Math.random()*20);
			var num = result.num;
			var item = $("#J_Search").val();
			var go = "/tgo.php?title=" + encodeURIComponent(title) + "&item=" + encodeURIComponent(item) + "&from=fanli";
			
			$("#J_Commission_Rate").attr('v',rate);
			$("#J_Rate").text(rate);
			$("#J_Shopname").text(nick);
			$("#J_Location").text(location);
			$("#J_Volume").text(num);
			$("#J_Price").text(price);
			$("#J_Commission").text(Math.round(rate * price)/100);
			
			$("#J_Title").html('<a style="cursor:pointer;" data-type="0" biz-itemid="'+ iid +'" data-tmpl="350x100" data-tmplid="6" data-rd="1" data-style="1" target="_blank">'+title+'</a>');
			$("#main-pic").html('<a style="cursor:pointer;" data-type="0" biz-itemid="'+ iid +'" data-tmpl="350x100" data-tmplid="6" data-rd="1" data-style="1" target="_blank"><img src="'+picUrl+'"></a>');
			$("#J_GoUrl").html('<a class="btn-simple" href="#" title="实际佣金以淘宝成交价格乘以返利比率为准" style="cursor:pointer;" data-type="0" biz-itemid="'+ iid +'" data-tmpl="350x100" data-tmplid="6" data-rd="1" data-style="1" target="_blank" onclick="return abc($(this));" togo="'+go+'">折扣模式购买</a>');
		} else if(resp.total_results == 0) {
			alert('Sorry，该宝贝无佣金返利!');
			return false;
		}else{
			alert('Sorry，淘宝返利系统维护中，请稍后按F5刷新重试吧!');
			return false;
		}
	});
	
	TOP.api({
		method : 'taobao.ump.promotion.get',
		item_id : iids
	}, function(resp) {
		if(resp.promotions.promotion_in_item){
			var result = resp.promotions.promotion_in_item.promotion_in_item[0];
			
			var price = result['item_promo_price'];
			var rate = $("#J_Commission_Rate").attr('v');
			if(price <= parseFloat($("#J_Price").text())){
				$("#J_Ture_Price").text('￥'+price);
				$("#J_Commission").text(Math.round(rate * price)/100);
				$("#J_Price").css("text-decoration","line-through");
			}
		}
	});
}