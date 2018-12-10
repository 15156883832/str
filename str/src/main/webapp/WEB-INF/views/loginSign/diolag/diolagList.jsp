<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/common/common.jsp"%>  
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- <script type="text/javascript" src="../static/css/zxf-style.css"></script>  -->
<link rel="stylesheet" type="text/css" href="../static/My97DatePicker2/4.8/skin/WdatePicker.css" />
<script type="text/javascript" src="../static/My97DatePicker2/4.8/WdatePicker.js"></script>
<title>动态</title>
<style type="text/css">
	a{
		color:#9393FF
	}
	.secondDig{
		background-image:url(../static/img/bj-2.jpg);
	}
	.icon-hf{
		background:url('../static/img/hf-1.png') no-repeat 0 0;
		width:20px;
		height:16px;
		padding:0 10px;
		/* display:inline-block */
	}
</style>
</head>
<body>
<div>全部动态</div>
<div class="datagrid-toolbar"></div>
<div id="diolagData" style="margin-left:30px;margin-top:10px;width:500px;">
	<c:forEach items="${list }" var="lt1">
		<div style="margin-top:10px;">
			<div style="border:2px;background-image:url(../static/img/bj-1.jpg);" class="zjhfDig" >
				<div style="margin-top:3px;font-size:20px;font-family:'宋体';font-weight:600;margin-left:3px;">${lt1.columns.userName }<span style="margin-left:25px;font-size:11px;font-family:'宋体';font-weight:600;color:#9d9d9d;">发布于 ${lt1.columns.createTime }</span></div>
				<div style="margin-top:3px;font-size:15px;font-family:'Georgia';margin-left:20px;">${lt1.columns.diolag_content }<a onclick="zjhfDig('${lt1.columns.id }')" parm1="${lt1.columns.id}" style="margin-left:10px;font-size:4px;cursor: pointer;cursor: hand;text-decoration:underline;color:blue;">回复</a></div>
			</div>
			<div class="datagrid-toolbar"></div>
			<div class="secondDig" >
				<div style="margin-left:40px;margin-right:3px;">
					<c:forEach var="lt2" items="${fns:getDiolagChildList(lt1.columns.id)}">
						<div style="margin-top:8px;">
							<a parm1="${lt2.columns.id}">${lt2.columns.userName }</a> 回复 <a parm1="${lt2.columns.id}">${lt1.columns.userName }</a>：${lt2.columns.diolag_content }
							<div style="font-size:5px;font-weight:200;color:#9d9d9d;">${lt2.columns.createTime } 
								<span class="icon-hf" title="回复" style="cursor:hand;" onclick="zjhfDig('${lt2.columns.id }')"></span>
							</div>
							<c:forEach var="lt3" items="${fns:getDiolagChildChList(lt2.columns.id)}">
								<div style="margin-left:60px;margin-top:5px;">
									<div style=""><a pars="1212121">${lt3.columns.userName }</a> 回复 <a>${lt3.columns.replyName }</a>：${lt3.columns.diolag_content }</div>
									<div style="font-size:5px;font-weight:200;color:#9d9d9d;">${lt3.columns.createTime }
										<span class="icon-hf" title="回复" style="cursor:hand;" onclick="zjhfDig('${lt3.columns.id }')" ></span>
									</div>
								</div>
							</c:forEach>
						</div>
					</c:forEach>
				</div>
			</div>
			<div class="datagrid-toolbar"></div>
			</br>
		</div>
	</c:forEach>
</div>
<div id="dd"></div>

<script type="text/javascript">
	$(function(){
		loadDiolagList();
		styleChange();
		clickA();
	})
	
	function zjhfDig(id){
		alert(id);
		
		$('#dd').dialog({
				collapsible : true,
				minimizable : true,
				maximizable : true,
				width : 350,
				height : 200,
				href:"toAddDiolag",
				toolbar : [],
				buttons : [ {
					text : '提交',
					iconCls : 'icon-ok',
					handler : function() {
						alert('提交数据');
					}
				}, {
					text : '取消',
					handler : function() {
						$('#dd').dialog('取消');
					}
				} ]
		});
	}

	function clickA() {
		$(".secondDig").find("a").bind('click', function() {
			alert($(this).text())
		})
	}

	function styleChange() {
		$(".secondDig").find("a").css("cursor", "hand").on("mouseover",
				function(e) {
					$(this).attr("title", "查看");
					$(this).css("text-decoration", "underline");
				});
		$(".secondDig").find("a").on("mouseout", function(e) {
			$(this).css("text-decoration", "");
		});
	};

	function loadDiolagList() {
		$.ajax({
			type : "post",
			url : "loadDiolagList",
			data : {},
			success : function(data) {
			}
		})
	}
</script>

</body>
</html>