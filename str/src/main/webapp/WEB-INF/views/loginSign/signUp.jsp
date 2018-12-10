<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/common/common.jsp"%>  
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>注册页面</title>
</head>
<body>
<h2>测试注册页面</h2>
<form action="" id="signForm">
	<em>* </em><input type="text" id="loginName1" name="loginName1" placeholder="请输入登陆账号" value="" />
	<em>* </em><input type="password" id="loginPassword1" name="loginPassword1" placeholder="请输入登陆密码" value="" />
	<em>* </em><input type="password" id="loginPassword2" placeholder="请确认登陆密码" value="" />
	<a href="/str/user/resister" style="WIDTH: 99px; CURSOR: hand;font-color:blue;">去登陆？</a>
</form>
<a onclick="sign()" type="button">注  册</a>
<script type="text/javascript">
$(function(){
	
})
  
function sign(){
	var loginName = $("#loginName1").val();
	var loginPassword = $("#loginPassword1").val();
	var loginPassword1 = $("#loginPassword2").val();
	if(isBlank(loginName)){
		layer.msg("请输入登陆账号");
		$("#loginName1").focus();
		return;
	}
	if(isBlank(loginPassword)){
		layer.msg("请输入登陆密码");
		$("#loginPassword1").focus();
		return;
	}
	if(loginPassword!=loginPassword1){
		layer.msg("前后输入的密码不一致，请重新输入");
		return;
	}
	$.ajax({
		type:"post",
		url:"/str/user/confirmSign",
		data:$("#signForm").serialize(),
		success:function(data){
			if(data.code=="200"){
				layer.msg("注册成功！");
				window.location.href="/str/user/resister";
			}else if(data.code=="421"){
				layer.msg("注册失败，请检查！");
				return;
			}else if(data.code=="422"){
				layer.msg("登陆账号已存在，请直接登陆！");
				return;
			}
		} 
	})
	
}
</script>
</body>
</html>
