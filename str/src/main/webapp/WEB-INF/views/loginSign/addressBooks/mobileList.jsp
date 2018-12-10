<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/common/common.jsp"%>  
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- <script type="text/javascript" src="../static/css/zxf-style.css"></script>  -->
<link rel="stylesheet" type="text/css" href="../static/My97DatePicker2/4.8/skin/WdatePicker.css" />
<script type="text/javascript" src="../static/My97DatePicker2/4.8/WdatePicker.js"></script>

<title>首页</title>
<style type="text/css">
	div .box{
		display: inline-block;
	}
	.zxfDivBox1{
		height:40px;
		margin-left:10px;
		margin-right:10px;
		margin-top:20px;
	}
	.zxfDivBox3{
		height:70px;
		margin-left:10px;
		margin-right:10px;
		margin-top:5px;
	}
	.zxfDivBox2{
		height:70px;
		margin-left:10px;
		margin-right:10px;
		margin-top:5px;
	}
	.searchConditions{
		margin-top:0px;
		margin-left:20px;
		margin-bottom:0px;
	}
</style>
</head>
<body style="overflow:auto; ">
	 <div style="overflow:auto; ">
		<form action="" id="oneForm">
			<input name="pageSize" id="pageSize" hidden="hidden"/>
			<input name="pageNo" id="pageNo" hidden="hidden"/>
			<div class="box" style="margin-top:0px;margin-left:20px;margin-bottom:0px;">
				<label>姓名：</label>
				<input class="easyui-textbox" name="name" style="width:100px;" />
			</div>
			<div class="box searchConditions">
				<label>联系方式：</label>
				<input class="easyui-textbox" name="mobile" style="width:100px;"/>
			</div>
			<div class=" box searchConditions">
				<label>类型：</label>
				<select name="type" class="easyui-combobox" style="width:75px;">
					<option value="">请选择</option>
					<option value="0">公用</option>
					<option value="1">私用</option>
				</select>
			</div>
			<div class="box searchConditions">
				<label>创建人：</label>
				<input class="easyui-textbox" name="createBy" style="width:100px;"/>
			</div>
			<div class="box searchConditions">
				<label>创建时间：</label>
				<input type="text" onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'createTimeMax\')}'})"  id="createTimeMin" name="createTimeMin" value="" class="input-text Wdate w-120" style="width:120px">
				至
				<input type="text" onfocus="WdatePicker({minDate:'#F{$dp.$D(\'createTimeMin\')}'})" id="createTimeMax" name="createTimeMax"  value="" class="input-text Wdate w-120" style="width:120px">
			</div>
			<div class="box searchConditions">
				<label>备注：</label>
				<input class="easyui-textbox" name="descMark" style="width:150px;" />
			</div>
			<div class="box searchConditions">
				<input type="button"  style="background-color:#bbffff;" onclick="dataGridReload();" value="查询" />
				&nbsp;&nbsp;<input type="button" id="searchReset" value="重置" />
			</div>   
		</form>   
	</div>
	<div style="margin-left:-20px; margin-right:-20px;margin-bottom:10px;" id="">
		<div id="mobileList">
		</div>
	</div>
	<div style="color:red;">注释：仅供测试！！！</div>
	
		 
		
<script type="text/javascript">
	$(function(){
		//common_dialog_hide('1');//1:隐藏对话框,2:显示对话框
		loadList();
		paginationSet();
		var set = document.getElementById('datagrid-view');
		set.style.height=550+'px';
		//$(".datagrid-view").css("height","20px"); 
	})
	
	function paginationSet(){
		var p = $('#mobileList').datagrid().datagrid('getPager');   
        p.pagination({
            pageSize: 20,
            pageList:[10,20,30,40,50,100,500,1000],
            beforePageText: '第',
            afterPageText:'共{pages}页',
            displayMsg: '当前显示 {from} 到 {to} ,共{total}记录',
            onBeforeRefresh: function () {
            	loadData('1');
            },
            onRefresh: function (pageNumber, pageSize) {
            	pageSizeNoInit(pageNumber,pageSize);
            	loadData('1'); 
            },
            onChangePageSize: function () {
            	pageSizeNoInit(pageNumber,pageSize);
            	loadData('1');
            },
            onSelectPage: function (pageNumber, pageSize) {
            	pageSizeNoInit(pageNumber,pageSize);
            	loadData('1'); 
            }
        });
	}
	
	function pageSizeNoInit(num,size){
		$("#pageSize").val(size);
		$("#pageNo").val(num);
	}
	
	$("#searchReset").bind('click',function(){
		$('#oneForm').form('clear');  
	})
	

	
	function dataGridReload(){
		loadData('1');
	}
	
	function loadData(types){
		if(types=='2'){//新增之后重新加载列表，并且跳转到第一页
			$("#pageNo").val('1');
		}
		$.ajax({
			type:"post",
			url:"loadingAddBkList",
			data:$("#oneForm").serialize(),
			success:function(data){
				//$('#mobileList').datagrid('loadData',"");
				var lgn = data.list.length;
				if(lgn>0){
					var b = [];
					for(var i=0;i<lgn;i++){
						var rt = data.list[i].columns;
						 var a = {
				                    'selectId' : rt.id,
				                    'id' : rt.id,
				                    'name' : rt.name,
				                    'sex' : rt.sex,
				                    'mobile' : rt.mobile+(isBlank(rt.mobile1) ? "" : ","+rt.mobile1)+(isBlank(rt.mobile2) ? "" : ","+rt.mobile2),
				                    'qq' : rt.qq,
				                    'e_mail' : rt.e_mail,
				                    'wx' : rt.wx,
				                    'zfb' : rt.zfb,
				                    'type' : rt.type,
				                    'address' : rt.address,
				                    'desc_mark' : rt.desc_mark,
				                    'update_time' : rt.update_time,
				                    'userName' : rt.userName,
				                    'create_time' : rt.create_time,
				                    'mobile1':rt.mobile1,
				                    'mobile2':rt.mobile2
				                } ;
						 b.push(a);
					}
					var c = {total:data.count,rows:b};
					$('#mobileList').datagrid('loadData', c);
				}
			}
		})
	}
	
	function loadList(){
		// 构建设备总览列表
	    $('#mobileList').datagrid({
	        title : '列表信息',
	        iconCls : 'icon-a_detail',
	        fit : true,
	        fitColumns : true,
	        rownumbers : true,
	        pagination : true,
	        singleSelect : false,
	        border : false,
	        striped : true,
	        toolbar : [{
	            text : '新增',
	            iconCls : 'icon-add',
	            handler : function() {
	            	addMobile();
	            }
	        }, '-', {
	        	text : '编辑',
	            iconCls : 'icon-edit',
	            handler : function() {
	            	editMobileBox();
	            }
	        }, '-',{
	        	text : '批量删除',
	            iconCls : 'icon-remove',
	            handler : function() {
	            	delMobileNums();
	            }
	        } , '-',{
	        	text : '导出',
	            iconCls : 'icon-redo',
	            handler : function() {
	            	exportsMobiles();
	            }
	        } , '-',{
	        	text : '打印',
	            iconCls : 'icon-print',
	            handler : function() {
	            	print();
	            }
	        } , '-', {
	        	text : '刷新列表',
	            iconCls : 'icon-mini-refresh',
	            align:'right',
	            handler : function() {
	                loadData();
	            }
	        }/* ,{ 
	            text: '<form id="oneForm">'+searchs()+'</form>' ,
				align:'right'
	        } */],
	    	frozenColumns:[[
	    		{
	                field : 'selectId',
	                title : 'select',
	               checkbox : true
	            }, {
		            field : 'id',
		            title : '性别',
		            width : 100,
		            align : 'center',
		            hidden : true
		        }, {
		            field : 'name',
		            title : '姓名',
		            width : 100,
		            align : 'center',
		        }
	    	]],
	        columns : [ [ {
	            field : 'sex',
	            title : '性别',
	            width : 100,
	            align : 'center',
	            formatter:function(dt){
	            	if(dt=='1'){
	            		return "男";
	            	}else{
	            		return "女";
	            	}
	            }
	        }, {
	            field : 'mobile',
	            title : '联系方式',
	            width : 100,
	            align : 'center',
	            formatter:function(row){
	            	return "<span title='" + row + "'>" + row + "</span>";
	            }
	        },  {
	            field : 'qq',
	            title : 'QQ',
	            width : 100,
	            align : 'center',
	            formatter:function(row){
	            	return "<span title='" + row + "'>" + row + "</span>";
	            }
	        },{
	            field : 'e_mail',
	            title : '邮箱',
	            width : 100,
	            align : 'center',
	            formatter:function(row){
	            	return "<span title='" + row + "'>" + row + "</span>";
	            }
	        }, {
	            field : 'wx',
	            title : '微信',
	            width : 100,
	            align : 'center',
	            formatter:function(row){
	            	return "<span title='" + row + "'>" + row + "</span>";
	            }
	        }, {
	            field : 'zfb',
	            title : '支付宝',
	            width : 100,
	            align : 'center',
	            formatter:function(row){
	            	return "<span title='" + row + "'>" + row + "</span>";
	            }
	        }, {
	            field : 'type',
	            title : '类型',
	            width : 100,
	            align : 'center',
	            formatter:function(dt){
	            	if(dt=='0'){
	            		return "公用";
	            	}else{
	            		return "私用";
	            	}
	            }
	        }, {
	            field : 'address',
	            title : '地址',
	            width : 100,
	            align : 'center',
	            formatter:function(row){
	            	return "<span title='" + row + "'>" + row + "</span>";
	            }
	        }, {
	            field : 'desc_mark',
	            title : '备注',
	            width : 100,
	            align : 'center',
	            formatter:function(row){
	            	return "<span title='" + row + "'>" + row + "</span>";
	            }
	        }, {
	            field : 'update_time',
	            title : '最近更新时间',
	            width : 100,
	            align : 'center',
	            formatter:function(time){
	            	return YYmmddHHmmssFuc(time);
	            }
	        }, {
	            field : 'userName',
	            title : '创建人',
	            width : 70,
	            align : 'center'
	        }, {
	            field : 'create_time',
	            title : '创建时间',
	            width : 100,
	            align : 'center',
	            formatter:function(time){
	            	return YYmmddHHmmssFuc(time);
	            }
	        }, {
	            field : 'mobile1',
	            title : '联系方式1',
	            width : 100,
	            align : 'center',
	            hidden : true
	        }, {
	            field : 'mobile2',
	            title : '联系方式2',
	            width : 100,
	            align : 'center',
	            hidden : true
	        }] ]
	    });
		loadData('1');
		$(".datagrid-header-rownumber").text("序号");
		
	}
	
	function editMobileBox(){
		var row = $('#mobileList').datagrid('getSelections');
		if(row.length < 1){
			layer.msg("请先选择数据！");
			return;
		}
		
		if (row.length > 1) {
			layer.msg("编辑时只支持单个修改，请不要选多个！");
			return;
		}
		var dt = row[0];
		$('<div></div>').dialog({
			id : 'editDialog',
			title : '编辑',
			iconCls : 'icon-edit',
			width : 600,
			height : 374,
			closed : false,
			cache : false,
			href : 'toEditMobile?id='+row[0].id,
			modal : true,
			onLoad : function(a) {
				//初始化表单数据
			},
			onClose : function() {
				$(this).dialog('destroy');
			},
			buttons : [ {
				text : '保存',
				iconCls : 'icon-save',
				handler : function() {
					//提交表单
					$("#addBkSave").trigger('click');
				}
			}, {
				text : '取消',
				iconCls : 'icon-cancel',
				handler : function() {
					$("#editDialog").dialog('destroy');
				}
			} ],

		});
	}
	
	function addMobile(){
		$('<div></div>').dialog({
			id : 'addDialog',
			title : '新增',
			iconCls : 'icon-add',
			width : 600,
			height : 374,
			closed : false,
			cache : false,
			href : 'toAddMobile',
			modal : true,
			onLoad : function(a) {
				//初始化表单数据
			},
			onClose : function() {
				$(this).dialog('destroy');
			},
			buttons : [ {
				text : '保存',
				iconCls : 'icon-save',
				handler : function() {
					$("#addBkSave").trigger('click');
				}
			},{
				text : '重置',
				iconCls : 'icon-undo',
				handler : function() {
					$("#addBk").form('clear');
				}
			}, {
				text : '取消',
				iconCls : 'icon-cancel',
				handler : function() {
					$("#addDialog").dialog('destroy');
				}
			} ],

		});
	}
	
	function delMobileNums(){
		var row = $('#mobileList').datagrid('getSelections');
		if(row.length < 1){
			layer.msg("请先选择您要删除的数据！");
			return;
		}
		var idsArr=[];
		for( var i=0;i<row.length;i++){
			idsArr.push(row[i].id);
		}
		var ids = idsArr.join(',');
		$.messager.confirm('删除确认', '您确定要删除这'+idsArr.length+'条数据吗?', function(r){
			if (r){
				$.ajax({
					type:"post",
					data:{ids:ids},
					url:"deleteMobiles",
					success:function(result){
						if(result=='200'){
							layer.msg("删除成功！");
							loadData('2');
						}else if(result=='420'){
							layer.msg("信息有误！");
						}
						return;
					}
				})
			}
		});
		return;
	}
	
	function exportsMobiles(){
		window.location.href="export?map="+$("#oneForm").serialize();
	}
	
	function print(){
		var row = $('#mobileList').datagrid('getSelections');
		if(row.length < 1){
			layer.msg("请先选择您想法打印的数据！");
			return;
		}
		var arr = [];
		for(var i=0;i<row.length;i++){
			arr.push(row[i].id);
		}
		window.open("printMobiles?ids="+arr.join(','));
	} 
	
</script>

</body>
</html>