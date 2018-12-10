<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/common/common.jsp"%> 
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>我想出去走一走   看看这个大世界</title>
	<link rel="stylesheet" type="text/css" href="${path}/static/login/style/register-login.css">
	<style type="text/css">  
		  
    </style>
</head>
<body>
<div id="box"></div>
<div class="cent-box register-box">
	<div class="cent-box-header">
		<h1 class="main-title hide">抖音</h1>
		<h2 class="sub-title" >倚南窗以寄傲        审容膝之易安</h2>
	</div>

	<div class="cont-main clearfix">
		<div class="index-tab">
			<div class="index-slide-nav">
				<a href="${path}/login/index">登录</a>
				<a href="${path}/login/register" class="active">注册</a>
				<div class="slide-bar slide-bar1"></div>				
			</div>
		</div>

		<div class="login form">
			<div class="group">
				<div class="group-ipt email">
					<input type="email" name="email" id="email" maxlength="50" style="width:270px;" class="ipt" placeholder="邮箱地址" required>
					<i class="" title=""></i>
				</div>
				<div class="group-ipt user">
					<input type="text" name="ncName" id="ncName" class="ipt" maxlength="50" style="width:270px;" placeholder="请填写一个昵称" required>
					<i class=""></i>
				</div>
				<div class="group-ipt password">
					<input type="password" name="password" id="password" class="ipt"  maxlength="20" placeholder="设置登录密码" required>
				</div>
				<div class="group-ipt password1">
					<input type="password" name="password1" id="password1" class="ipt"  maxlength="20" placeholder="重复密码" required>
				</div>
				<div class="group-ipt verify">
					<input type="text" name="verify" id="verify" class="ipt"  maxlength="4"  placeholder="输入邮箱验证码" required>
					<span class="fasong" id="sendYzm" >获取验证码</span> 
					<!-- <input class="fasong" id="sendYzm" type="button" style="width:90px;"  value="获取验证码"/>  -->
				</div>
			</div>
		</div>
		<div class="button">
			<button type="submit" class="login-btn register-btn" id="button" onclick="register()">注册</button>
		</div>
	</div>
</div>

<div class="footer">
	<p>诗和远方</p>
	<p>Life is a poetry-Made in Zxf <a href="https://user.qzone.qq.com/1193453159/infocenter?_t_=0.23706762214874422">@qq.com</a> 2018</p>
</div>

<script src='${path}/static/login/js/particles.js' type="text/javascript"></script>
<script src='${path}/static/login/js/background.js' type="text/javascript"></script>
<!-- <script src='../static/login/js/jquery.min.js' type="text/javascript"></script> -->
<script type="text/javascript" src="${path}/static/jquery.easyui.1.5.4/jquery.min.js"></script> 
<script src='${path}/static/login/js/layer/layer.js' type="text/javascript"></script>
<script src='${path}/static/login/js/index.js' type="text/javascript"></script>
<script>
	var sendMark = 0;
	
	$(function(){
	})
	$('.imgcode').hover(function(){
		layer.tips("看不清？点击更换", '.verify', {
        		time: 6000,
        		tips: [2, "#3c3c3c"]
    		})
	},function(){
		layer.closeAll('tips');
	}).click(function(){
		$(this).attr('src','http://zrong.me/home/index/imgcode?id=' + Math.random());
	})

	/* $(".login-register-btn").bind("click",function(){
		

	})
	 */
	 $("#password1").bind("blur",function(){
		 var password = $("#password").val();
		 var password1 = $("#password1").val();
		 if(!isBlank(password)){
			 if(password!=password1){
				 layer.msg("密码前后输入不一致！");
			 }
		 }
	 })
	 
	var marks = false;
	function register(){
		if(marks){
			return ;
		}
		var email = $("#email").val();
		var password = $("#password").val();
		var password1 = $("#password1").val();
		var ncName = $("#ncName").val();
		var verify = $("#verify").val();
		if(!checkEmail(email)){
			layer.msg("邮箱格式不正确，请重新输入！");
			$("#email").focus();
			return;
		}
		if(isBlank(ncName)){
			layer.msg("请填写昵称！");
			$("#ncName").focus();
			return;
		}
		if(isBlank(password)){
			layer.msg("请填写密码！");
			$("#password").focus();
			return;
		}
		if(isBlank(verify)){
			layer.msg("请填写验证码！");
			$("#verify").focus();
			return;
		}
		if(password!=password1){
			layer.msg("密码前后输入不一致！");
			return ;
		}
		if(sendMark==0){
			layer.msg("请先点击发送获取验证码！");
			return;
		}
		var postData = {
				email:email,
				password:password,
				ncName:ncName,
				verify:verify
		};
		marks = true;
		$.ajax({
			type:"post",
			url:"${path}/user/register",
			data:postData,
			dataType:'json',
			success:function(data){
				if(data=="200"){
					layer.msg("注册成功！");
					setTimeout(function(){
						marks = false;
						window.location.href="${path}/login/index";
					},500);
					return;
				}else if(data=="420"){
					layer.msg("该邮箱已注册！");
					marks = false;
					return ;
				}else if(data=="421"){
					layer.msg("该昵称已被占用！");
					marks = false;
					return ;
				}else{
					layer.msg("注册失败，请检查！");
					marks = false;
					return;
				}
			},
			error:function(){
				//alert("error");
				layer.msg("error！");
				marks = false;
				return;
			}
		}); 
	}
	
	$("#remember-me").click(function(){
		var n = document.getElementById("remember-me").checked;
		if(n){
			$(".zt").show();
		}else{
			$(".zt").hide();
		}
	})
	
	function checkEmail(str){
	    var re = /^[A-Za-z\d]+([-_.][A-Za-z\d]+)*@([A-Za-z\d]+[-.])+[A-Za-z\d]{2,4}$/; 
	    if(re.test(str)){
	    	return true;
	    }else{
	    	return false;
	    }
	}
	
	function isBlank(str){
		if($.trim(str)=='' || str==null || str==undefined){
			return true;
		}
		return false;
	}
	
	
	var wait = 20;
	function time(o) {
		if (wait == 0) {
			//o.removeAttribute("disabled");
			o.css("background","#CEFFCE");
			o.text("获取验证码");
			wait = 20;
		} else {
			//o.setAttribute("disabled", true);
			o.text("重新获取(" + wait + ")");
			o.css("background","#E0E0E0");
			wait--;
			setTimeout(function() {
				time(o)
			}, 1000)
		}
	}
	
	$("#sendYzm").bind("click",function(){
		$(this).css("background","#E0E0E0");
		var textSend = $("#sendYzm").text();
		if('获取验证码'==textSend){
			var email = $("#email").val();
			var obj = $(this);
			if(checkEmail(email)){
				$.ajax({
					type:"post",
					url:"${path}/user/sendYzm",
					data:{email:email},
					success:function(data){
						if(data=='200'){
							sendMark = 1;
							time(obj);
							layer.msg("发送成功，请注意查收！");
							return;
						}else{
							layer.msg("发送失败，请检查！");
							return;
						}
					}
				})
			}else{
				$("#email").focus();
				layer.msg("邮箱格式不正确！");
			} 
		} 
	})
	
	$("#email").bind("blur",function(){
		var thn = $(".email").find('i');
		var email = $.trim($("#email").val());
		if(isBlank(email)){
			chnangeStyleOk(thn,"0","");
			return ;
		}
		if(!checkEmail(email)){
			chnangeStyleOk(thn,"2","邮箱格式不正确！");
			return ;
		};
		$.ajax({
			type:"post",
			url:"${path}/user/checkEmailIfExist",
			data:{email:email},
			success:function(data){
				if(data=="200"){
					chnangeStyleOk(thn,"1","可注册邮箱");
				}else if(data=='420'){
					chnangeStyleOk(thn,"2","该邮箱已注册！");
				}
			}
		})
	})
	
	function chnangeStyleOk(obj,type,content){
		if(type=="1"){
			obj.removeClass("myicon-cancel");
			obj.addClass("myicon-ok");
			obj.attr("title",content);
		}
		if(type=="2"){
			obj.removeClass("myicon-ok");
			obj.addClass("myicon-cancel");
			obj.attr("title",content);
		}
		if(type=="0"){
			obj.removeClass("myicon-ok");
			obj.removeClass("myicon-cancel");
			obj.removeAttr("title");
		}
	}
	
	$("#ncName").bind("blur",function(){
		var thn = $(".user").find('i');
		var ncName = $.trim($("#ncName").val());
		if(isBlank(ncName)){
			chnangeStyleOk(thn,"0","");
			return ;
		}
		$.ajax({
			type:"post",
			url:"${path}/user/checkEmailIfExist",
			data:{ncName:ncName},
			success:function(data){
				if(data=="200"){
					chnangeStyleOk(thn,"1","可用昵称");
				}else if(data=='420'){
					chnangeStyleOk(thn,"2","该昵称已被占用！");
				}
			}
		})
	})
</script>
</body>
</html>