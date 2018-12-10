<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/common/common.jsp"%>  
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- <script type="text/javascript" src="../static/css/zxf-style.css"></script>  -->
<title>首页</title>
<style type="text/css">
	div .box{
		display: inline-block;
	}
	.zxfDivBox1{
		height:120px;
		margin-left:10px;
		margin-right:10px;
		margin-top:15px;
	}
</style>
</head>
<body >
		<div>
		 	<form action="" id="addBk">
		 		<div class="zxfDivBox1" style="">
		 			<label><em style="color:#fe0101;">*</em>联系人姓名：</label>
			 		<input name="addBkName" id="editName"   style="background-color:#D9FFFF;width:130px;" placeholder="请输入联系人姓名"/>
			 		<input name="editId" hidden="hidden" id="editId" />
			 		<div style="margin-left:10px;display: inline-block;">
			 			<label>性别：</label>
			 			<select name="addBkSex" id="editSex" >
			 				<option value="1" selected="selected">男</option>
			 				<option value="2">女</option>
			 			 </select>
		 			 </div>
		 			 <div class="box" style="border:1px;border-color:green;width:200px;margin-left:10px;">
		 			 	<label>电话类型：</label>
			 			<span style="border:1px;border-color:green;">私用<input class="mbMark" type="radio" checked="checked" id="siyong" value="1" />&nbsp;&nbsp;公用<input id="gongyong" type="radio"  value="0" /></span>
			 			<input hidden="hidden" value="${userId }" name="addBkCreateBy" />
			 			<input hidden="hidden" value="1" name="addBkType" />
			 		</div>
		 		</div>
	 			<div class="datagrid-toolbar "></div>
	 			<div class="zxfDivBox3">
	 				<div style="display: inline-block;">
		 				<label>联系方式：</label>
				 		<input  name="addBkMobile" class="easyui-textbox" style="width:100px;" id="editMobile"   placeholder="请输入联系方式"/>
			 		</div>
			 		<div class="box" style="margin-left:5px;margin-top:6px;display: inline-block;">
			 			<label>联系方式1：</label>
		 				<input style="width:100px;" class="easyui-textbox" name="addBkMobile1" id="editMobile1"/>
		 			</div>
		 			<div class="box" style="margin-left:5px;display: inline-block;">
		 				<label>联系方式2：</label>
		 				<input style="width:100px;" class="easyui-textbox" name="addBkMobile2" id="editMobile2"/>
		 			</div>
		 			<div style="margin-top:8px;margin-left:24px;">
				 		<label>地址：</label>
				 		<input class="easyui-textbox" style="width:460px"  name="addBkAddress" id="editAddress" />
			 		</div>
	 			</div>
	 			<div class="datagrid-toolbar "></div>
	 			<div class="zxfDivBox2">
	 				<div  style="display: inline-block;margin-top:6px;">
		 				<label>&nbsp;&nbsp;qq：</label>
		 				<input style="width:190px;" class="easyui-textbox" name="qq" id="qq"/>
		 				<label style="margin-left:60px;">邮箱：</label>
		 				<input style="width:190px;" class="easyui-textbox" name="eMail" id="eMail"/>
		 			</div>
		 			<div  style="margin-top:5px;">
		 				<label>微信：</label>
		 				<input style="width:190px;" class="easyui-textbox" name="wx" id="wx"/>
		 				<label  style="margin-left:48px;">支付宝：</label>
		 				<input style="width:190px;" class="easyui-textbox" name="zfb" id="zfb"/>
		 			</div>
	 			</div>
			 	<div class="datagrid-toolbar"></div>
			 	
		 		<div style="margin-top:10px;margin-left:10px;">
			 		<label>备注：</label>
		 			<input class="easyui-textbox" data-options="multiline:true" placeholder="一千字以内" style="width:485px;height:50px;" name="addBkDesc" id="editDesc" />
	 			</div>
		 	</form>
		 	<div style="text-align: center;">
		 		<input type="button" hidden="hidden" id="addBkSave" style="background-color:#00FFFF;" value="保存" />&nbsp;&nbsp;
	 		</div>
	 		<input hidden="hidden" value="1" name="addBkType" id="addBkType" />
		</div>
	<script type="text/javascript">
	$(function(){
		/* $('#editName').textbox('textbox').css('background','#D9FFFF');
		$('#editMobile').textbox('textbox').css('background','#D9FFFF'); */
		
	})
	
	function checkMobileType(type) {//点击的是1私用还是0公用
		if (type == "1") {//电话私用
			$("#gongyong").removeAttr("checked");
			$("#gongyong").removeClass("mbMark");
			$("#siyong").attr("checked", "checked");
			$("#siyong").css("background-color", "green");
			$("#siyong").addClass("mbMark");
			$("#addBkType").val('1');
		}
		if (type == "0") {//电话公用
			$("#siyong").removeAttr("checked");
			$("#siyong").removeClass("mbMark");
			$("#gongyong").attr("checked", "checked");
			$("#gongyong").addClass("mbMark");
			$("#addBkType").val('0');
		}
	}
	
	var addBkMark = false;//防重复提交
	$("#addBkSave").bind('click',function(){
		if(addBkMark){
			
		}
		if(isBlank($("#editName").val())){
			layer.msg("请填写联系人姓名!");
			$("#editName").focus();
			return;
		}
		addBkMark=true;
		$.ajax({
			type:"post",
			url:"/str/addBk/addBkSave",
			data:$("#addBk").serialize(),
			success:function(data){
				addBkMark=false;
				if(data.code=="200"){
					layer.msg("添加成功！");
					$("#addDialog").dialog('destroy');
					loadData('2');
					return;
				}else{
					layer.msg("添加失败，请检查！");
					return;
				}
			},
			error:function(){
				alert(error);
				addBkMark=false;
				return;
			}
		}) 
	})
	
	$("#siyong").bind('click', function() {
		checkMobileType('1');
	})

	$("#gongyong").bind('click', function() {
		checkMobileType('0');
	})
	
	
	
</script>

</body>
</html>