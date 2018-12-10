<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="static/javascript/javascript.js"></script>
<script type="text/javascript" src="static/jQuery/1.9.1/jquery.js"></script>
<script type="text/javascript" src="static/jQuery/1.9.1/jquery.min.js"></script>
<script type="text/javascript" src="static/jQuery/1.9.1/jquery-1.11.1.min.js"></script>

<title>test</title>
<body>
<h2>Hello World!yayaya</h2>
<a onclick="test()">test11</a>
<script type="text/javascript">
var gg;

$(function(){
	gg="ok";
})
function test(){//index.jsp
	alert("进入")
	$.ajax({
		type:"post",
		url:"/user/firstPage",
		data:{gg:gg},
		success:function(){
			
		}
	})  
}


</script>
</body>
</html>
