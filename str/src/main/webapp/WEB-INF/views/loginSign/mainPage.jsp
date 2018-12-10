<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/common/common.jsp"%>  
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>首页</title>
<style type="text/css">
	div .box{
		display: inline-block;
	}
	.num{
		width: 50px;
		/* height: 10px; */
		/* border: 2px solid #ccc; */
		margin: 0px;
		float: right;
		position: relative;
		line-height: 25px;
		text-align: center;
	}
	.boilder{
		/* border: 2px solid #ccc;  */
		/* width: 50px; */
	}
	ul.list-01:hover ul.list-02{
		display:block;
	}
	.tuichu{
		margin-right:10px;
		margin-top:5px;
		cursor: hand;
		width:50px;
	}
</style>
</head>
<body class="easyui-layout">
    <div data-options="region:'north',title:'天真岁月不忍欺，青春荒唐我不负你',split:true"  style="height:100px ;background:url(${path}/static/img/page.jpg) no-repeat;background-size: cover; ">
    	<div>
	    	<%-- <div align="center">
	    		<font align="center" size="3" >Hello,<span style="color:blue;font-weight:bold;font-style:italic;">${ZxfUserMessage.name}</span><c:if test="${ZxfUserMessage=='0' }">先生</c:if><c:if test="${ZxfUserMessage=='1' }">女士</c:if>，下午好!</font>
	    		<input id="userId" value="${userId }" hidden="hidden" />
	    	</div> --%>
	    	<!-- <div align="right">
	    		<div style="margin-right:50px;margin-top:0px;width:80px;height:30px;"   >
	    			<input type="button" value="退出" onclick="toRegister()"   />
	    		</div>
    		</div> -->
    		<div align="right" >
    			
		    	<div class="boilder" title="Hello,${ZxfUserMessage.name}！" style="margin-right:10px;margin-top:13px;cursor: default;">
		    		<span class="myicon-user" style="margin-right:2px;"></span>${ZxfUserMessage.name}
	    		</div>
	    		<div class="tuichu" onmouseover="mouseOver(this)" onmouseout="mouseOut(this)" onclick="toRegister()" >
	    			<span class="myicon-undo" style="margin-right:2px;"></span>退出
    			</div>
    		</div>
    	</div>
    </div>
    <div data-options="region:'south',title:'bottom',split:true" style="height:0px;">
    </div>
    <div data-options="region:'east',title:''" style="width:0px;">
    </div> 
    
    <!-- 菜单栏menu -->
    <div data-options="region:'west',title:'菜单',split:true" style="width:200px;">
    	<!-- <div style="margin:20px 0 10px 0;"></div> -->
		<div class="easyui-accordion" style="width:auto;height:auto;">
			<div title="信息管理" style="overflow:auto;padding:3px;">
				<ul class="easyui-tree oneTree">
					<li>个人信息</li>
					<li>动态</li>
					<li>通讯录</li>
				</ul>
			</div>
			<div title="系统设置" data-options="iconCls:'icon-help'" style="padding:3px;">
				<ul class="easyui-tree oneTree">
					<li>
						test3
					</li>
				</ul>	
			</div>
			<div title="其他" data-options="iconCls:'icon-search'" style="padding:3px;">
				<ul class="easyui-tree oneTree">
					<li>
						test3
					</li>
				</ul>
			</div>
		</div>
    </div>
    <div data-options="region:'center',title:'',iconCls:'icon-ok'" style="padding:0px;background:#eee;">
    	 <div class="easyui-tabs" id="tt" style="width:auto;height:812px" id="tabDetail">
			<div title="首页" data-options="closable:true" style="padding:10px">
				<p style="font-size:14px">welcome to come !</p>
			</div>
		</div>
    </div>
<script type="text/javascript">
var userId = '${userId}';
$(function(){
	loadingAddBkList(userId);
	$(".num1").num1();

	})

	function loadingAddBkList(userId) {
		$.ajax({
			type : "post",
			url : "loadingAddBkList",
			data : {
				userId : userId
			},
			success : function(data) {
				if (data != null) {
					$("#txList").empty();
					var html = "";
					for (var i = 0; i < data.length; i++) {
						html += '<td>'
								+ data[i].columns.name
								+ '</td>'
								+ '<td>'
								+ sexFc(data[i].columns.sex)
								+ '</td>'
								+ '<td title="'
								+ mobilesFc(data[i].columns.mobile,
										data[i].columns.mobile1,
										data[i].columns.mobile2)
								+ '">'
								+ mobilesFc(data[i].columns.mobile,
										data[i].columns.mobile1,
										data[i].columns.mobile2) + '</td>'
								+ '<td>' + typeFc(data[i].columns.type)
								+ '</td>' + '<td>' + data[i].columns.address
								+ '</td>' + '<td>' + data[i].columns.desc_mark
								+ '</td>' + '<td>'
								+ data[i].columns.update_time + '</td>'
								+ '<td>' + data[i].columns.userName + '</td>'
								+ '<td>' + data[i].columns.create_time
								+ '</td>';
					}
					$("#txList").append(html);
				}
			}
		})
	}

	function sexFc(num) {
		if (num == "1") {
			return "男";
		}
		return "女";
	}

	function mobilesFc(num1, num2, num3) {
		var mobiles = "";
		if (!isBlank(num1)) {
			mobiles += num1;
		}
		if (!isBlank(num2)) {
			mobiles += num2;
		}
		if (!isBlank(num3)) {
			mobiles += num3;
		}
		return mobiles;
	}

	function typeFc(num) {
		if (num == "0") {
			return "公用";
		}
		return "私用";
	}

	function toRegister() {
		window.location.href = "${path}";
	}

	function whichDiv1() {
		$(".gerenxinxi").hide();
		$(".chengyuanliebiao").hide();
		$(".tongxunlu").show();
	}
	function whichDiv3() {
		$(".tongxunlu").hide();
		$(".gerenxinxi").hide();
		$(".chengyuanliebiao").show();
	}
	function whichDiv2() {
		$(".chengyuanliebiao").hide();
		$(".tongxunlu").hide();
		$(".gerenxinxi").show();
	}
	function addMobiles() {
		if (!$(".moreMobiles").hasClass("changeMobiles")) {
			$(".moreMobiles").addClass("changeMobiles");
			$(".moreMobiles").show();
		} else {
			$(".moreMobiles").removeClass("changeMobiles");
			$(".moreMobiles").hide();
		}
	}

	function showGrxx() {

	}

	$('.oneTree').tree({
		onClick : function(node) {
			if ($('.oneTree').tree('isLeaf', node.target)) {//判断是否是叶子节点
				if(node.domId=='_easyui_tree_1'){
					common_addTab('#tt', node.text, "toPersonMsg");//个人信息
				}
				if(node.domId=='_easyui_tree_2'){
					common_addTab('#tt', node.text, "toDiolagList");//动态
				}
				if(node.domId=='_easyui_tree_3'){
					common_addTab('#tt', node.text, "toMobileList");//通讯录
				} 
			}
		}
	});

	$("#siyong").bind('click', function() {
		checkMobileType('1');
	})

	$("#gongyong").bind('click', function() {
		checkMobileType('0');
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

	$("#addBkReset").bind(
			'click',
			function() {
				$(".tongxunlu input[name='addBkName']").val('');
				$(".tongxunlu input[name='addBkDesc']").val('');
				$(".tongxunlu input[name='addBkAddress']").val('');
				$(".tongxunlu input[name='addBkMobile']").val('');
				$(".tongxunlu input[name='addBkMobile1']").val('');
				$(".tongxunlu input[name='addBkMobile2']").val('');
				$("#gongyong").removeAttr("checked");
				$("#gongyong").removeClass("mbMark");
				$("#siyong").attr("checked", "checked");
				$("#siyong").addClass("mbMark");
				$("#addBkType").val('1');
				$(".addBkSelect").find("option[value='1']").attr("selected",
						"selected");
				$('#addBkSelect').combobox('setValue', '1');
			})

	$("input[name='jiecheng']").blur(function() {
		var num = $("input[name='jiecheng']").val();
		var i = 1, j = 1;
		while (i < num) {
			i++;
			j *= i;
		}
		$("input[name='result']").val(j);
	});

	;
	
	
	function mouseOver(obj){
	    $(obj).css("background-color",'#46A3FF');
	};
	
	function mouseOut(obj){
	    $(obj).css("background-color",'');
	};
</script>
</body>
</html>
