<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/include/preload.jsp"%>

<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <title>试卷新增</title>
    
    <link rel="stylesheet" type="text/css" href="${ctx}/plugins/bootstrap/3.3.6/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/plugins/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/plugins/animate/animate.min.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/plugins/bootstrap-table/bootstrap-table.min.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/plugins/sweetalert/sweetalert.css">
    
    <link rel="stylesheet" type="text/css" href="${ctx}/plugins/hplus/style.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/local/common.css">
    
</head>
<body class="gray-bg body-paper-student">
	<div class="wrapper wrapper-content animated fadeInRight">
		<div class="ibox float-e-margins">
			<div class="ibox-content">
				<div class="page-title">
					<h2>考生管理<small>${paper.title}</small></h2>
				</div>
				
				<div id="paper-student-table-toolbar" role="group">
					<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#modal-paper-student-dialog">
						<i class="fa fa-plus fa-fw"></i>添加考生
					</button>
					<button type="button" class="btn btn-white btn-paper-student-delete-batch" disabled="disabled">
 						<i class="fa fa-trash-o fa-fw"></i>批量删除
 					</button>
 					<a class="a-back" href="${ctx}/paperList">返回试卷管理</a>
				</div>
				<table id="paper-student-table" class="table-hm" data-mobile-responsive="true"></table>
			</div>
		</div>
	</div>
	
	<script type="text/javascript" src="${ctx}/plugins/jquery/2.1.4/jquery.min.js"></script>
    <script type="text/javascript" src="${ctx}/plugins/bootstrap/3.3.6/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="${ctx}/plugins/hplus/content.min.js"></script>
    <script type="text/javascript" src="${ctx}/local/common.js"></script>
    
    <script type="text/javascript" src="${ctx}/plugins/sweetalert/sweetalert.min.js"></script>
    <script type="text/javascript" src="${ctx}/plugins/bootstrap-table/bootstrap-table.min.js"></script>
    <script type="text/javascript" src="${ctx}/plugins/bootstrap-table/locale/bootstrap-table-zh-CN.min.js"></script>
    
    <script type="text/javascript">
    ;(function( $ ) {
    	
    	var $page = $('.body-paper-student');
    	var paper = {
    		id: '${paper.id}'
    	}
    	
    	var $table = $k.util.bsTable($page.find('#paper-student-table'), {
			url: '${ctx}/api/paper/listStudent?paperId=' + paper.id,
			toolbar: '#paper-student-table-toolbar',
			idField: 'id',
			pagination: false,
			responseHandler: function(res) {
				return res.data;
			},
			columns: [{
				field: 'state',
				checkbox: true
			}, {
				title: '#',
				width: '20',
				formatter: function(value, row, index) {
					return index + 1;
				}
			}, {
				field: 'username',
				title: '考号',
				formatter: function(value, row, index) {
					return '<a class="btn-student-detail">' + value + '</a>';
				},
				events: window.operateEvents = {
					'click .btn-student-detail': function(e, value, row, index) {
						e.stopPropagation();
					}
				}
			}, {
				field: 'name',
				title: '姓名',
			}, {
				field: 'group',
				title: '分组',
				formatter: function(value, row, index) {
					return value.name;
				}
			}, {
				title: '操作',
				align: 'center',
				width: '100',
				formatter: function(value, row, index) {
					var $edit = '<a class="btn-student-edit a-operate">编辑</a>';
					var $delete = '<a class="btn-student-delete a-operate">删除</a>';
					return $edit + $delete;
				},
				events: window.operateEvents = {
					'click .btn-student-edit': function(e, value, row, index) {
						e.stopPropagation();
					},
					'click .btn-student-delete': function(e, value, row, index) {
						e.stopPropagation();
					}
				}
			}]
		});
		
    })( jQuery );
    </script>
    
</body>
</html>