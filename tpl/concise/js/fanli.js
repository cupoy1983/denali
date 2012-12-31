function getCommission() {
	var url = $("#J_Search").val();
	var id = getUrlParam(url, 'id');
	if (/\d+/gi.test(id)) {
		ItemsConvert(id);
	} else {
		alert('Sorry，链接错误，请输入正确的宝贝地址！');
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
function ItemsConvert(iids) {
	TOP.api({
		method : 'taobao.taobaoke.widget.items.convert',
		fields : 'num_iid,title,nick,item_location,pic_url,price,click_url,shop_click_url,commission_rate,volume',
		num_iids : iids
	}, function(resp) {
		if (resp.taobaoke_items) {
			$("#resultContainer .result").css("display", "block");
			var result = resp.taobaoke_items.taobaoke_item[0];
			
			var title = result.title;
			var price = result.price;
			var clickUrl = result.click_url;
			var shopUrl = result.shop_click_url;
			var picUrl = result.pic_url;
			var nick = result.nick;
			var location = result.item_location;
			var rate = (result.commission_rate * 0.45) / 100 ;
			var volume = result.volume;
			var item = $("#J_Search").val();
			var go = "/tgo.php?title=" + encodeURIComponent(title) + "&url=" + encodeURIComponent(clickUrl) + "&item=" + encodeURIComponent(item) + "&from=fanli";
			$("#J_Title").text(title);
			$("#J_Title").attr("href", clickUrl);
			$("#J_Shopname").text(nick);
			$("#J_Shopname").attr("href", shopUrl);
			$("#J_Location").text(location);
			$("#J_Volume").text(volume);
			$("#J_Price").text(price);
			$("#J_Commission_Rate").text(rate);
			$("#J_Commission").text(Math.round(rate * price)/100);
			$("#main-pic img").attr("src", picUrl);
			$("#J_GoUrl").attr("href", go);
			
		} else if(resp.total_results == 0) {
			alert('Sorry，该宝贝无佣金返利!');
		}else{
			alert('Sorry，淘宝返利系统维护中，请稍后再试吧!');
		}
	});
}