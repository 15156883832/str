<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
	<%--<meta name="decorator" content="base"/>--%>
	<meta name="renderer" content="webkit|ie-comp|ie-stand">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
	<meta http-equiv="Cache-Control" content="no-siteapp" />

	<title>工单录入</title>

	<link rel="stylesheet" type="text/css" href="../css/print_sf.css"/>
	<script src="../static/js/jquery-1.8.3.js" type="text/javascript" charset="utf-8"></script>
	<script type="text/javascript" src="../static/js/jquery-migrate-1.4.1.js"></script>
	<script type="text/javascript" src="../static/js/jquery.jqprint-0.3.js"></script>
	<style>
	</style>
	<script type="text/javascript">
		$(function(){
			/* $('#btn').goHelp('${ctx}/helpindex/indexHelp?a=gddy'); */

		});

		function printOrder() {
//			document.getElementById("btn").style.display="none";
            $("#btn-wrapper-print").hide();
			$(".btnHelplink").hide();
			$(".printpage").jqprint({
				debug: false, //如果是true则可以显示iframe查看效果（iframe默认高和宽都很小，可以再源码中调大），默认是false
				importCSS: true, //true表示引进原来的页面的css，默认是true。（如果是true，先会找$("link[media=print]")，若没有会去找$("link")中的css文件）
				printContainer: true, //表示如果原来选择的对象必须被纳入打印（注意：设置为false可能会打破你的CSS规则）。
				operaSupport: true//表示如果插件也必须支持歌opera浏览器，在这种情况下，它提供了建立一个临时的打印选项卡。默认是true
			});
		}


	</script>
</head>
<body>

<div class="printpage wrap" style="position:relative;">
	<div class="cl" style="font-size: 20px;overflow: hidden">
		<div class="f-r" style="float: right">打印人：<span style="  display: inline-block;width: 180px;">${printName}</span></div>
	</div>
	<table class="printTable" style="margin-top:8px">
		<caption style="text-align:left;">联系人信息</caption>
		<tr>
			<%-- <td style="width: 33%;">用户姓名：${order.customerName }</td> --%>
			<td style="width: 33%;"  colspan="2">
			</td>
		</tr>
	</table>
	<div style="padding-top:50px; text-align:center;" id="btn-wrapper-print">
		<input type="button" value="打印" id="btn" onclick="printOrder();" class="btn-print" style="width:100px;height:30px; line-height:30px;" data-type="print" />
	</div>

</div>


</body>

</html>