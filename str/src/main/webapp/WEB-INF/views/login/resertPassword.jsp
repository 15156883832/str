<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/common/common.jsp"%>  
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="${path}/static/normalFuction/functions.js"></script> 
<title>登陆页面</title>

 <style type="text/css">      
     body{      
        background-image: url(${path}/static/img/p1.jpg);      
        background-size:cover;    
     }  
     .divPst{
     	width:800px;
     	text-align:left;
     	margin-top:250px;
     	margin-left:889px;
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
     .fasong1{
		width: 98px;
		position: absolute; 
		cursor: pointer;
		height: 25px;
		background:#66B3FF;
		padding-top:4px;
		text-align:center;
	}  
     .fasong2{
		width: 98px;
		position: absolute; 
		cursor: pointer;
		height: 25px;
		background:#BBFFBB;
		padding-top:4px;
		text-align:center;
	}  
 </style> 
 </head>
<body >
<!-- 登陆 -->
<div class="waicengdiv">
	<div  class="divPst">
		<h5 style="padding-left:60px;color:#9F4D95;">用一支灰色的<font color="#ADADAD"  style="font-family:SimSun;" size="4"> 铅笔</font>        画一出沉默的<font style="font-family:SimSun;" color="black" size="4"> 舞台剧</font></h5>
		<form action="" id="testForm">
			<div class="resert_check">
				<em>*</em>邮箱地址：<input id="email" placeholder="请输入登陆账号" onkeydown="enterEvent1(event)" />&nbsp;&nbsp;&nbsp;
				<span class="fasong1" id="sendYzm" ><span style="font-size:15px;">获取验证码</span></span>
				</br></br>
				<label style="padding-left:12px;"><em>*</em>验证码：</label><input id="verify" placeholder="请输入验证码" onkeydown="enterEvent1(event)" />&nbsp;&nbsp;&nbsp;
				<span class="fasong2" id="sendYzmConfirm" ><span style="font-size:15px;">提交验证</span></span>
				</br></br>
			</div>
			<!-- <div class="group-ipt verify">
				<input type="text" name="verify" id="verify" class="ipt"  maxlength="4"  placeholder="输入邮箱验证码" required>
				<span class="fasong" id="sendYzm" >获取验证码</span> 
			</div> -->
			<div class="resert_password" hidden="hidden">
				<em>*</em>重置密码：<input id="loginPasswordNew" type="password" class="" placeholder="请输入登陆密码" onkeydown="enterEvent2(event)" /><span title="点我！点我！点我能透视！" style="margin-left:15px;cursor:hand;" onclick="seePassword();"><i class="myicon-eye-open"></i></span></br></br>
				<em>*</em>确认密码：<input id="loginPasswordAgain" type="password" placeholder="请输入登陆密码" onkeydown="enterEvent2(event)" />&nbsp;&nbsp;<span class="fontSize" ><font size="2" face=Georgia color="gray">还没账号？</font></span>&nbsp;&nbsp;<a onclick="toSign()" style=" CURSOR: hand;font-color:blue;text-decoration:underline"><font size="2" color="blue">去注册</font></a></br></br>
			
				<div style="margin-left:77px;">
					<input onclick="confirmResert()" onmouseover="mouseOver(this)" onmouseout="mouseOut(this)" class="btnstyle" value="保  存" type="button"  />&nbsp;&nbsp;&nbsp;&nbsp; 
					<input class="btnstyle" type="button" onmouseover="mouseOver(this)" onmouseout="mouseOut(this)" value="重  置" id="reset" />&nbsp;&nbsp;&nbsp;&nbsp;
				</div>
			</div>
			
			
		</form>
	</div>
	 
</div>

<div class="tips" align="right">
	<span>温馨提示：仅供测试</span>
</div>
<script type="text/javascript">
var oldEmail = "";
$(function(){
	var strLoginName = getCookie("strLoginName");//获取记住密码的登录账号
	var strLoginPassword = getCookie("strLoginPassword");//获取记住密码的登录密码
	if(checkExistCookie(strLoginName)){
		$("#loginName").val(strLoginName);
	}
	if(checkExistCookie(strLoginName)){
		$("#loginPassword").val(strLoginPassword);
	}
	$("#reset").bind("click",function(){
		$("#loginPasswordNew").val("");
		$("#loginPasswordAgain").val("");
	})
	$("#sendYzmConfirm").bind("click",function(){
		var code = $("#verify").val();
		var email = $("#email").val();
		if(isBlank(code)){
			layer.msg("请填写验证码！");
			$("#verify").focus();
			return;
		}
		if(isBlank(oldEmail)){
			layer.msg("请先点击发送验证码！");
			return ;
		}
		if(oldEmail!=email){
			layer.msg("请重新获取验证码！");
			return ;
		}
		$.ajax({
			type:"post",
			url:"${path}/user/confirmCode",
			data:{code:code},
			success:function(data){
				if(data=="200"){
					layer.msg("验证成功！"); 
					$(".resert_check").attr("hidden","hidden");
					$(".resert_password").removeAttr("hidden");
				 }else if(data=="420"){
					layer.msg("验证错误！");
				}else{
					layer.msg("验证失败，请检查！");
				}
				return;
			},
			complete:function(){
				
			},
			error:function(){
				
			}
		}) 
	})
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


function toSign(){
	window.location.href="${path}/user/registerPage";
}

function toRegister(){
	$(".signUp1").hide();
	$("#loginName1").val('');
	$("#loginPassword1").val('');
	$("#loginPassword2").val('');
	$("#inputCode").val('');
	$(".waicengdiv").show();
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

$("#sendYzm").bind("click",function(){
	
	var textSend = $("#sendYzm").text();
	if('获取验证码'==textSend){
		var email = $("#email").val();
		var obj = $(this);
		if(checkEmail(email)){
			$.ajax({
				type:"post",
				url:"${path}/user/sendYzmConfirm",
				data:{email:email},
				success:function(data){
					if(data=='200'){
						sendMark = 1;
						time(obj);
						layer.msg("发送成功，请注意查收！");
						$(this).css("background","#E0E0E0");
						oldEmail = $("#email").val();
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

	var wait = 20;
	function time(o) {
		if (wait == 0) {
			//o.removeAttribute("disabled");
			o.css("background","#66B3FF");
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

	
	function checkEmail(str){
	    var re = /^[A-Za-z\d]+([-_.][A-Za-z\d]+)*@([A-Za-z\d]+[-.])+[A-Za-z\d]{2,4}$/; 
	    if(re.test(str)){
	    	return true;
	    }else{
	    	return false;
	    }
	}
 
	
	var rMark = false;
	function confirmResert(){
		if(rMark){
			return;
		}
		var news = $("#loginPasswordNew").val();
		var agains = $("#loginPasswordAgain").val();
		if(isBlank(news)){
			layer.msg("请输入新的密码");
			$("#loginPasswordNew").focus();
			return;
		}
		if(news!=agains){
			layer.msg("前后密码输入不一致！");
			return;
		}
		rMark = true;
		$.ajax({
			type:"post",
			data:{email:oldEmail,password:news},
			url:"${path}/user/confirmResertPassword",
			success:function(data){
				if(data=="420"){
					layer.msg("信息有误，请检查！");
				}else if(data=="200"){
					layer.msg("重置密码成功！");
					window.location.href="${path}";
				}else{
					layer.msg("重置失败，请检查！");
				}
				return;
			},
			complete:function(){
				rMark = false;
			},
			error:function(){
				rMark = false;
			}
		});
	}
	
	/*enter查询*/
	function enterEvent1(event){
		var keyCode = event.keyCode?event.keyCode:event.which?event.which:event.charCode;
		if (keyCode ==13){
			$("#sendYzmConfirm").trigger("click");	
		}
	}
	function enterEvent2(event){
		var keyCode = event.keyCode?event.keyCode:event.which?event.which:event.charCode;
		if (keyCode ==13){
			confirmResert();
		}
	}
	
	function seePassword(){
		var obj1 = $("#loginPasswordNew");
		var obj2 = $("#loginPasswordAgain");
		looklook(obj1);
		looklook(obj2);
	}
	
	function looklook(obj){
		if("password"==obj.attr("type")){
			obj.removeAttr("type");
			obj.attr("type","text");
		}else{
			obj.removeAttr("type");
			obj.attr("type","password");
		}
	}
	
	function mouseOver(obj){
	    $(obj).css("background-color",'#46A3FF');
	};
	
	function mouseOut(obj){
	    $(obj).css("background-color",'#F0F0F0');
	};

</script>
</body> 
</html>
