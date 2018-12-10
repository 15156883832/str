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
	.zxfDivBox2{
		height:40px;
		margin-left:10px;
		margin-right:10px;
		margin-top:15px;
	}
</style>
</head>
<body>
	<div >
	 	<form action="" id="editBk">
	 		<div class="zxfDivBox1" style="">
	 			<label><em style="color:#fe0101;">*</em>联系人姓名：</label>
		 		<input name="addBkName" id="editName" class="text" value="${book.columns.name }" style="background-color:#ABFFFF;width:130px;" placeholder="请输入联系人姓名"/>
		 		<input name="editId" hidden="hidden" id="editId" value="${book.columns.id }" />
		 		<div style="margin-left:10px;display: inline-block;">
		 			<label>性别：</label>
		 			<select name="addBkSex" id="editSex" >
		 				<option value="1" <c:if test="${book.columns.sex=='1' }">selected="selected"</c:if>>男</option>
		 				<option value="2" <c:if test="${book.columns.sex=='2' }">selected="selected"</c:if>>女</option>
		 			 </select>
	 			 </div>
	 			 <div class="box" style="border:1px;border-color:green;width:200px;margin-left:10px;">
	 			 	<label>电话类型：</label>
		 			<span style="border:1px;border-color:green;">私用<input class="mbMark" type="radio" <c:if test="${book.columns.type=='1' }">checked="checked"</c:if> id="siyong" value="1" />&nbsp;&nbsp;公用<input id="gongyong" type="radio" <c:if test="${book.columns.type=='0' }">checked="checked"</c:if>  value="0" /></span>
		 			<input hidden="hidden" <c:if test="${book.columns.type=='1' }">value="1"</c:if> <c:if test="${book.columns.type=='0' }">value="0"</c:if> name="addBkType" id="addBkType" />
		 			<input hidden="hidden" value="${userId }" name="addBkCreateBy" />
		 		</div>
	 		</div>
 			<div class="datagrid-toolbar "></div>
 			<div class="zxfDivBox3">
 				<div style="display: inline-block;">
	 				<label>联系方式：</label>
			 		<input  name="addBkMobile" value="${book.columns.mobile }" id="editMobile" class="easyui-textbox" style="width:100px;"  />
		 		</div>
		 		<div class="box" style="margin-left:5px;margin-top:6px;display: inline-block;">
		 			<label>联系方式1：</label>
	 				<input style="width:100px;" class="easyui-textbox" value="${book.columns.mobile1 }" name="addBkMobile1" id="editMobile1"/>
	 			</div>
	 			<div class="box" style="margin-left:5px;display: inline-block;">
	 				<label>联系方式2：</label>
	 				<input style="width:100px;" class="easyui-textbox" value="${book.columns.mobile2 }" name="addBkMobile2" id="editMobile2"/>
	 			</div>
	 			<div style="margin-top:8px;margin-left:24px;">
			 		<label>地址：</label>
			 		<input class="easyui-textbox" style="width:460px" value="${book.columns.address }" name="addBkAddress" id="editAddress" />
		 		</div>
 			</div>
 			<div class="datagrid-toolbar"></div>
 			<div class="zxfDivBox2">
 				<div  style="display: inline-block;margin-top:6px;">
	 				<label>&nbsp;&nbsp;qq：</label>
	 				<input style="width:190px;" class="easyui-textbox" value="${book.columns.qq }" name="qq" id="qq"/>
	 				<label style="margin-left:60px;">邮箱：</label>
	 				<input style="width:190px;" class="easyui-textbox" value="${book.columns.e_mail }" name="eMail" id="eMail"/>
	 			</div>
	 			<div  style="margin-top:8px;">
	 				<label>微信：</label>
	 				<input style="width:190px;" class="easyui-textbox" value="${book.columns.wx }" name="wx" id="wx"/>
	 				<label  style="margin-left:48px;">支付宝：</label>
	 				<input style="width:190px;" class="easyui-textbox" value="${book.columns.zfb }" name="zfb" id="zfb"/>
	 			</div>
 			</div>
		 	<div class="datagrid-toolbar"></div>
	 		<div style="margin-top:10px;margin-left:10px;">
		 		<label>备注：</label>
	 			<input class="easyui-textbox" data-options="multiline:true" placeholder="一千字以内" value="${book.columns.desc_mark }" style="width:485px;height:50px;" name="addBkDesc" id="editDesc" />
 			</div>
	 	</form>
	 	<div style="text-align: center;">
	 		<input type="button" id="addBkSave" hidden="hidden" style="background-color:#00FFFF;" value="保存" />&nbsp;&nbsp;
	 	</div>
 	</div>
 	
 	<script type="text/javascript">
 	$(function(){
 		 
 	})
 	
 		var editMark = false;
	$("#addBkSave").bind('click',function(){
		if(editMark){
			return;
		}
		if(isBlank($('#editName').val())){
			layer.msg("请填写联系人姓名！");
			$("#editName").focus();
			return;
		}
		editMark=true;
		$.ajax({
			type:"post",
			data:$("#editBk").serialize(),
			url:"saveEdit",
			success:function(data){
				if(data=='200'){
					layer.msg("修改成功！");
					$(".panel-tool-close").trigger('click');
					loadData('1');
				}else if(data=='420'){
					layer.msg("信息有误，请刷新列表后重新选择！");
				}else{
					layer.msg("修改失败，出现未知错误，请稍后重试！");
				}
				editMark=false;
				return;
			}
		})
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
	
	$("#siyong").bind('click', function() {
		checkMobileType('1');
	})

	$("#gongyong").bind('click', function() {
		checkMobileType('0');
	})
 	</script>

</body>
</html>