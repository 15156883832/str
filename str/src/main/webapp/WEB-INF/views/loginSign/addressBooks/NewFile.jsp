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
		margin-top:15px;
	}
	.searchConditions{
		margin-top:20px;
		margin-left:20px;
		margin-bottom:20px;
	}
</style>
</head>
<body>
	 <div >
		<form action="" id="searchForm">
			<input name="pageSize" id="pageSize" hidden="hidden"/>
			<input name="pageNo" id="pageNo" hidden="hidden"/>
			<!-- <div class="box" style="margin-top:20px;margin-left:20px;margin-bottom:20px;">
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
				<input class="easyui-textbox" name="descMark" style="width:150px;"/>
			</div>
			<div class="box searchConditions">
				<input type="button" onclick="dataGridReload();" value="查询" />
				<input type="button" id="searchReset" value="重置" />
			</div>  -->
		</form>
	</div> 
		<div id="mobileList">
 			<table id="dataGrid" class="easyui-datagrid" title="文件基本信息"  data-options="rownumbers:true,  
				singleSelect:false,  
				autoRowHeight:true,  
				pagination:true,  
				pageSize:10,fit:false">  
				<thead>  
		            <tr>  
		                <th field="filename" width="200" align="center">文件名</th>  
		                <th field="filesize" width="200" align="center">大小</th>  
		                <th field="filetype" width="200" align="center">类型</th>  
		                <th field="fileperson" width="200" align="center">创建人</th>  
		                <th field="filedate" width="200" align="center">创建时间</th>  
		                <th field="filedown" width="200" align="center">下载次数</th>  
		                <th field="filelabel" width="200" align="center">文件标签</th>  
		                <th field="filepath" width="200" align="center">文件路径</th>  
		            </tr>  
		        </thead>  
			</table>  
		</div>
	<!-- <div>212121</div> -->
	<%-- <div class="cl pr-10">
		<div class="pagination">${page}</div>
	</div> --%>
 	
<script type="text/javascript">
	$(function(){
		//common_dialog_hide('1');//1:隐藏对话框,2:显示对话框
		loadList();
		paginationSet();
	})
	
	function paginationSet(){
		var p = $('#mobileList').datagrid().datagrid('getPager');   
        p.pagination({
            pageSize: 10,
            pageList:[10,20,30,40,50],
            beforePageText: '第',
            afterPageText:'共{pages}页',
            displayMsg: '当前显示 {from} 到 {to} ,共{total}记录',
            onBeforeRefresh: function () {
                alert('before refresh');
            },
            onRefresh: function (pageNumber, pageSize) {
            	pageSizeNoInit(pageNumber,pageSize);
            	loadData(); 
            },
            onChangePageSize: function () {
                alert('pagesize changed');
            },
            onSelectPage: function (pageNumber, pageSize) {
            	pageSizeNoInit(pageNumber,pageSize);
            	loadData(); 
            }
        });
	}
	
	function pageSizeNoInit(num,size){
		$("#pageSize").val(size);
		$("#pageNo").val(num);
	}
	
	$("#searchReset").bind('click',function(){
		//$("#searchForm").get(0).reset();
		$('#searchForm').form('clear');  
	})
	

	
	function dataGridReload(){
		loadData();
	}
	
	function loadData(){
		$.ajax({
			type:"post",
			url:"loadingAddBkList",
			data:$("#searchForm").serialize(),
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
					$('#mobileList').datagrid('loadData', b);
				}
			}
		})
	}
	
	function loadList(){
		// 构建设备总览列表
	    $('#mobileList').datagrid({
	        title : '设备列表模式',
	        iconCls : 'icon-a_detail',
	        fit : true,
	        fitColumns : true,
	        rownumbers : true,
	        pagination : true,
	        singleSelect : false,
	        border : false,
	        striped : true,
	        toolbar : [ {
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
	        }/* , '-',{
	        	text : '导出',
	            iconCls : 'icon-redo',
	            handler : function() {
	            	exportsMobiles();
	            }
	        } */, '-', {
	        	text : '刷新列表',
	            iconCls : 'icon-mini-refresh',
	            align:'right',
	            handler : function() {
	                dataGridReload();
	            }
	        } ],
	        columns : [ [ {
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
	        }, {
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
		$(".datagrid-header-rownumber").text("序号");
		loadData();
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
			height : 320,
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
			height : 320,
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
					$("#addBk").get(0).reset();
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
							loadList();
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

	function isBlank(num) {
		if (num == null || $.trim(num) == '' || num == undefined) {
			return true;
		}
		return false;
	}
	
</script>

</body>
</html>