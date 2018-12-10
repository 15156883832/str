<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"  %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"  %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"  %> 
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="../static/javascript/javascript.js"></script>
<script type="text/javascript" src="../static/jQuery/1.9.1/jquery.js"></script>
<script type="text/javascript" src="../static/jQuery/1.9.1/jquery.min.js"></script>
<script type="text/javascript" src="../static/jQuery/1.9.1/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="../static/normalFuction/functions.js"></script> 
<script type="text/javascript" src="../static/layer/2.1/layer.js"></script> 
<link rel="stylesheet" type="text/css" href="../static/layer/2.1/skin/layer.css">
<link rel="stylesheet" type="text/css" href="..//static/css/style.css">
<link rel="stylesheet" type="text/css" href="../static/css/H-ui.admin.css">
<title>登陆页面</title>

 <style type="text/css">      
     body{      
        background-image: url(../static/img/p1.jpg);      
        background-size:cover;    
     }  
     .divPst{
     	width:800px;
     	text-align:left;
     	margin-top:200px;
     	margin-left:1200px;
     	padding-bottom:20px;
     	padding-top:20px;
     }  
     .signUp{
     	width:800px;
     	text-align:left;
     	margin-top:200px;
     	margin-left:1200px;
     	padding-bottom:20px;
     	padding-top:20px;
     }
     .waicengdiv{
     	
     }  
     .btnstyle{
	    width:80px;
	    height:30px;
     	padding-left:5px;
     	padding-right:5px;
     }
     em{
     	color:red;
     }
     input{
     	width:200px;
     	height:30px;
     }
     
     .fontSize{
     	size:2
     }
     .tips{
     	margin-top:470px;
     	margin-right:0px;
     	margin-bottom:0px;
     	color:red;
     }
 </style> 
 </head>
<body >
<!-- 登陆 -->
<div class="waicengdiv">
	<div  class="divPst">
		<h5 style="padding-left:60px;color:#9F4D95;">友谊的港湾 →_→ 需要去<font face="Georgia" color="#00DD00" size="4"> <i>登陆</i></font></h5>
		<form action="" id="testForm">
			<em>*</em>登陆账号：<input id="loginName" placeholder="请输入登陆账号" onkeydown="enterEvent(event)" /></br></br>
			<em>*</em>登陆密码：<input id="loginPassword" type="password" placeholder="请输入登陆密码" onkeydown="enterEvent(event)" />&nbsp;&nbsp;<span class="fontSize" ><font size="2" face=Georgia color="gray">还没账号？</font></span>&nbsp;&nbsp;<a onclick="toSign()" style=" CURSOR: hand;font-color:blue;text-decoration:underline"><font size="2" color="blue">去注册</font></a></br></br>
			<div>
				<input onclick="login()" class="btnstyle" value="登  陆" type="button"  />&nbsp;&nbsp;&nbsp;&nbsp; 
				<input class="btnstyle" type="button" value="重  置" id="reset" />&nbsp;&nbsp;&nbsp;&nbsp;
				<font size="3">记住密码</font>&nbsp;<input checked="checked" type="radio" class="markRadio" id="jimm" style="width:15px;height:15px;"/>
				
			</div>
		</form>
	</div>
	 
</div>

<!-- 注册 -->
<div  class="signUp1"  style="display:none;">
	<div  class="signUp" >
		<h5 style="padding-left:60px;color:#9F4D95;">友谊的小船 →_→ 需要先<font face="Georgia" color="#0066CC" size="4"> <i>注册</i></font></h5>
		<form action="" id="signForm" align="left">
			<em>*</em>登陆账号：<input type="text" id="loginName1" name="loginName1" placeholder="请输入登陆账号" onkeydown="enterEventZc(event)" value="" /></br></br>
			<em>*</em>登陆密码：<input type="password" id="loginPassword1" name="loginPassword1" placeholder="请输入登陆密码" onkeydown="enterEventZc(event)" value="" /></br></br>
			<em>*</em>确认密码：<input type="password" id="loginPassword2" placeholder="请确认登陆密码" onkeydown="enterEventZc(event)" value="" />&nbsp;&nbsp;<span class="fontSize" ><font size="2" face=Georgia color="gray">已有账号？</font></span>&nbsp;&nbsp;<a onclick="toRegister()" style=" CURSOR: hand;font-color:blue;text-decoration:underline"><font size="2" color="blue">去登陆</font></a></br>
		</form>
		<div>
			&nbsp;&nbsp;<a href="#" id="checkCode" style="width:98px;height:30px;background-image:url(../static/img/p2.jpg);font-style:italic;" align="center" onclick="createCode()"></a>
	    	<input style="float:left;width:180px;" type="text" onkeydown="enterEventZc(event)"  id="inputCode"/></br></br>
		</div>
		<div style="padding-left:0px;">
			<input style="width:290px;background-color:#80FFFF" onclick="sign()" value="注  册" type="button"/>
		</div>
	</div>
</div>
<div class="tips" align="right">
	<span>温馨提示：仅供测试</span>
</div>
<script type="text/javascript">
$(function(){
	var strLoginName = getCookie("strLoginName");//获取记住密码的登录账号
	var strLoginPassword = getCookie("strLoginPassword");//获取记住密码的登录密码
	if(checkExistCookie(strLoginName)){
		$("#loginName").val(strLoginName);
	}
	if(checkExistCookie(strLoginName)){
		$("#loginPassword").val(strLoginPassword);
	}
})

$("#reset").bind("click",function(){
		$("#loginName").val('');
		$("#loginPassword").val('');
	})
/* 
 $("#loginName").focus(function(){
	$("#loginName").css("border-color","blue");
})
 $("#loginName").blur(function(){
	$("#loginName").css("border-color","");
}) */

function  checkExistCookie(val){
	if( (val != "undefined") && (val != 'undefined') && (typeof(val) != "undefined") && val!=null && $.trim(val) != ""){
		return true;
	}
	return false;
}

function login(){
	var loginName= $("#loginName").val();
	var loginPassword= $("#loginPassword").val();
	if(isBlank(loginName)){
		layer.msg("请填写登陆账号");
		$("#loginName").focus();
		return;
	}
	if(isBlank(loginPassword)){
		layer.msg("请填写登陆密码");
		$("#loginPassword").focus();
		return;
	}
	$.ajax({
		type:"post",
		url:"/str/user/loginCheck",
		data:{loginName:loginName,
			loginPassword:loginPassword},
		success:function(data){
			if(data.code=="200"){
				layer.msg("登陆成功！");
				if($("#jimm").hasClass("markRadio")){//勾选了记住密码
					addCookie("strLoginName","strLoginPassword",loginName,loginPassword,365);
				}else{//否则清除cookie
					delCookie("strLoginName","strLoginPassword");
				}
				window.location.href="/str/user/toMainPage?id="+data.id;
			}else if(data.code=="421"){
				layer.msg("用户信息错误，登陆账号重复！");
				return;
			}else if(data.code=="422"){
				layer.msg("登陆失败，登陆账号或者密码错误！");
				return;
			}else{
				layer.msg("登陆失败，出现未知错误！");
				return;
			}
		}
	})  
}  

function toSign(){
	$(".waicengdiv").hide();
	createCode();
	$(".signUp1").show();
}

function toRegister(){
	$(".signUp1").hide();
	$("#loginName1").val('');
	$("#loginPassword1").val('');
	$("#loginPassword2").val('');
	$("#inputCode").val('');
	$(".waicengdiv").show();
}

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
	if(validateCode() == "1" || validateCode() == "0" ){
		return;
	}
	$.ajax({
		type:"post",
		url:"/str/user/confirmSign",
		data:$("#signForm").serialize(),
		success:function(data){
			if(data.code=="200"){
				layer.msg("注册成功！");
				toRegister();
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


var code;
function createCode() 
{
 code = "";
 var codeLength = 4; //验证码的长度
 var checkCode = document.getElementById("checkCode");
 var codeChars = new Array(0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 
      'a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z',
      'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'); //所有候选组成验证码的字符，当然也可以用中文的
 for(var i = 0; i < codeLength; i++) 
 {
  var charNum = Math.floor(Math.random() * 52);
  code +="  "+ codeChars[charNum];
 }
 if(checkCode) 
 {
  checkCode.className = "code";
  checkCode.innerHTML = code;
 }
}
function validateCode(){
	 var inputCode=document.getElementById("inputCode").value;
	 if(inputCode.length <= 0){
		 layer.msg("请输入验证码！");
	  	 return "0";
	 }else if(inputCode.toUpperCase() != code.toUpperCase()) {
		 var codeParam = code.toUpperCase().split(' ');
		 var killBlank = "";
		 for(var i=0;i<codeParam.length;i++){
			 killBlank=killBlank+codeParam[i];
		 }
		 if(inputCode.toUpperCase() == killBlank){
			 return "2";
		 }
	     layer.msg("验证码输入有误！");
	     createCode();
	     return "1";
	 }else{
	     return "2";
	 }    
}  

$("#jimm").bind("click",function(){
	if(!$("#jimm").hasClass("markRadio")){//没有这个属性
		$("#jimm").addClass("markRadio");
	}else{
		$("#jimm").removeClass("markRadio");
		$("#jimm").removeAttr("checked");
	}
})

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

function delCookie(strLoginName,strLoginPassword)//删除cookie
{
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

/*enter查询*/
function enterEvent(event){
	var keyCode = event.keyCode?event.keyCode:event.which?event.which:event.charCode;
	if (keyCode ==13){
		login();	
	}
}
/*enter查询*/
function enterEventZc(event){
	var keyCode = event.keyCode?event.keyCode:event.which?event.which:event.charCode;
	if (keyCode ==13){
		sign();	
	}
}

 

</script>
</body> 
</html>
