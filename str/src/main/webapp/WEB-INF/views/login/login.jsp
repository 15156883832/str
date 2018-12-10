<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/common/commonindex.jsp"%> 
<html lang="en">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>我想出去走一走   看看这个大世界</title>
	<link rel="stylesheet" type="text/css" href="${path}/static/login/style/register-login.css">
	<style type="text/css">      
    </style>
</head>
<body>
<div id="box"></div>
<div class="cent-box">
	<div class="cent-box-header">
		<h1 class="main-title hide">抖音</h1>
		<h2 class="sub-title" >疏影横斜水清浅        暗香浮动月黄昏</h2>
	</div>

	<div class="cont-main clearfix">
		<div class="index-tab">
			<div class="index-slide-nav">
				<a href="${path}/user/login" class="active">登录</a>
				<a href="${path}/user/registerPage">注册</a>
				<div class="slide-bar"></div>				
			</div>
		</div>

		<div class="login form">
			<div class="group">
				<div class="group-ipt email">
					<input type="text" name="email" id="email" class="ipt" onkeydown="enterEvent(event)" placeholder="邮箱地址" required>
				</div>
				<div class="group-ipt password">
					<input type="password" name="password" id="password" class="ipt" placeholder="输入您的登录密码" onkeydown="enterEvent(event)" required>
				</div>
				<!-- <div class="group-ipt verify">
					<input type="text" name="verify" id="verify" class="ipt" placeholder="输入验证码" required>
					<img src="" class="imgcode">
				</div> -->
			</div>
		</div>

		<div class="button">
			<button type="submit" class="login-btn register-btn" onclick="login()" id="button">登录</button>
		</div>

		<div class="remember clearfix">
			<label class="remember-me"><span class="icon"><span class="zt"></span></span><input type="checkbox" name="remember-me" id="remember-me" class="remember-mecheck markRadio" checked="checked">记住我</label>
			<label class="forgot-password">
				<a href="${path}/user/toResertPasswordPage">忘记密码？</a>
			</label>
		</div>
	</div>
</div>

<div class="footer">
	<p>诗和远方</p>
	<p>Life is a poetry-Made in Zxf <a href="https://user.qzone.qq.com/1193453159/infocenter?_t_=0.23706762214874422">qq.com</a> 2018</p>
</div>

<script src='${path}/static/login/js/particles.js' type="text/javascript"></script>
<script src='${path}/static/login/js/background.js' type="text/javascript"></script>
<script src='${path}/static/login/js/jquery.min.js' type="text/javascript"></script>
<script src='${path}/static/login/js/layer/layer.js' type="text/javascript"></script>
<script src='${path}/static/login/js/index.js' type="text/javascript"></script>
<script>
$(function(){
	var strLoginName = getCookie("strLoginName");//获取记住密码的登录账号
	var strLoginPassword = getCookie("strLoginPassword");//获取记住密码的登录密码
	if(checkExistCookie(strLoginName)){
		$("#email").val(strLoginName);
	}
	if(checkExistCookie(strLoginName)){
			$("#password").val(strLoginPassword);
		}
})
	/* $('.imgcode').hover(function(){
		layer.tips("看不清？点击更换", '.verify', {
        		time: 6000,
        		tips: [2, "#3c3c3c"]
    		})
	},function(){
		layer.closeAll('tips');
	}).click(function(){
		$(this).attr('src','http://zrong.me/home/index/imgcode?id=' + Math.random());
	}); */
	$("#remember-me").click(function(){
		var n = document.getElementById("remember-me").checked;
		if(n){
			$(".zt").show();
		}else{
			$(".zt").hide();
		}
	});
	
	function  checkExistCookie(val){
		if( (val != "undefined") && (val != 'undefined') && (typeof(val) != "undefined") && val!=null && $.trim(val) != ""){
			return true;
		}
		return false;
	}
	
	
	
	
	function login() {
		var loginName = $("#email").val();
		var loginPassword = $("#password").val();
		if (isBlank(loginName)) {
			layer.msg("请填写登陆账号");
			$("#email").focus();
			return;
		}
		if (isBlank(loginPassword)) {
			layer.msg("请填写登陆密码");
			$("#password").focus();
			return;
		}
		$.ajax({
			type : "post",
			url : "${path}/user/loginCheck",
			data : {
				loginName : loginName,
				loginPassword : loginPassword
			},
			success : function(data) {
				if (data.code == "200") {
					layer.msg("登陆成功！");
					if ($("#remember-me").hasClass("markRadio")) {//勾选了记住密码
						addCookie("strLoginName", "strLoginPassword",loginName, loginPassword, 365);
					} else {//否则清除cookie
						delCookie("strLoginName", "strLoginPassword");
					}
					window.location.href = "${path}/user/toMainPage?id=" + data.id;
				} else if (data.code == "421") {
					layer.msg("用户信息错误，登陆账号重复！");
					return;
				} else if (data.code == "422") {
					layer.msg("登陆失败，登陆账号或者密码错误！");
					return;
				} else {
					layer.msg("登陆失败，出现未知错误！");
					return;
				}
			}
		})
	}
	
	$("#remember-me").bind("click",function(){
		if(!$(this).hasClass("markRadio")){//没有这个属性
			$(this).addClass("markRadio");
			$(this).attr("checked","checked");
		}else{
			$(this).removeClass("markRadio");
			$(this).removeAttr("checked");
		}
	})
	
	/*记住密码*/
	function addCookie(strLoginName,strLoginPassword,strLoginNameValue,strLoginPasswordValue,expiredays){
	    var strLoginNameVal = getCookie(strLoginName);
	    var strLoginPasswordVal = getCookie(strLoginPassword);
	    //需要设置过期时长，否则关闭浏览器就会清除cookie
	    var exp = new Date();
	    exp.setTime(exp.getTime() + expiredays*24*60*60*1000);
	    var expires = "expires="+exp.toUTCString();
	    document.cookie = strLoginName+"="+strLoginNameValue +";"+ expires;
	    document.cookie = strLoginPassword+"="+strLoginPasswordValue +";"+ expires;
	    //alert(expires);
	   /*  if( (oldCookie == "undefined")||(oldCookie == 'undefined')|| (typeof(oldCookie) == "undefined"))
	    {
	        document.cookie = strLoginName+"="+objValue +";"+ expires;
	    }
	    else
	    {
	        document.cookie = strLoginName+"="+oldCookie+","+objValue +";"+ expires;
	    } */
	}
	
	function delCookie(strLoginName,strLoginPassword){//删除cookie
	    document.cookie = strLoginName+"=;";
	    document.cookie = strLoginPassword+"=;";
	}

	function getCookie(NameOfCookie){
	    var arrStr = document.cookie.split("; ");
	    for(var i = 0;i < arrStr.length;i ++){
	        var temp = arrStr[i].split("=");
	        if(temp[0] == NameOfCookie)
	            return unescape(temp[1]);
	    }
	    return "";
	}
	
	function isBlank(str){
		if($.trim(str)=='' || str==null || str==undefined){
			return true;
		}
		return false;
	}
	
	/*enter查询*/
	function enterEvent(event){
		var keyCode = event.keyCode?event.keyCode:event.which?event.which:event.charCode;
		if (keyCode ==13){
			login();	
		}
	}
</script>
</body>
</html>