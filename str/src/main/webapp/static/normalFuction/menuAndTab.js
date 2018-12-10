function common_addTab(id,title, url){
	if ($(id).tabs('exists', title)){
		$(id).tabs('select', title);
		var tab = $(id).tabs('getSelected');
		$('#tt').tabs('update', {
			tab: tab,
			options: {
				href: url 
			}
		});
	} else {
		var content = '<iframe scrolling="auto" frameborder="0"  src="'+url+'" style="width:100%;height:100%;"></iframe>';
		$(id).tabs('add',{
			title:title,
			content:content,
			closable:true
		});
	}
}

function isBlank(num) {
	if (num == null || $.trim(num) == '' || num == undefined) {
		return true;
	}
	return false;
}

function YYmmddHHmmssFuc(nows) { 
	if(!isBlank(nows)){
		var now=new Date(nows); 
		var year=now.getFullYear(); 
		var month=now.getMonth()+1; 
		var date=now.getDate(); 
		var hour=now.getHours(); 
		var minute=now.getMinutes(); 
		var second=now.getSeconds(); 
		return year+"-"+month+"-"+date+" "+hour+":"+minute+":"+second; 
	}
	return "";
}
