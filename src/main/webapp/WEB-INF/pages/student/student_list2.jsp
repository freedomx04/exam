<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/include/preload.jsp"%>

<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	
	<title>分组管理</title>
	
	<link rel="stylesheet" type="text/css" href="${ctx}/plugins/bootstrap/3.3.6/css/bootstrap.min.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/plugins/font-awesome/4.7.0/css/font-awesome.min.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/plugins/animate/animate.min.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/plugins/bootstrap-table/bootstrap-table.min.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/plugins/sweetalert/sweetalert.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/plugins/bootstrapValidator/css/bootstrapValidator.min.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/plugins/bootstrap-treeview/bootstrap-treeview.min.css">
	
	<link rel="stylesheet" type="text/css" href="${ctx}/plugins/hplus/style.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/local/common.css">
	
</head>

<body class="gray-bg body-group-list">
	<div class="wrapper wrapper-content animated fadeInRight">
		<div class="row">
			<div class="col-xs-3" style="padding-right: 0;">
				<div class="ibox float-e-margins">
					<div class="ibox-content">
						<div class="page-title">
							<h2>考生分组列表</h2>
						</div>
						<div>
							<button type="button" class="btn btn-primary">
								<i class="fa fa-plus fa-fw"></i>新增
							</button>
							<button type="button" class="btn btn-white" disabled="disabled">
								<i class="fa fa-edit fa-fw"></i>编辑
							</button>
							<button type="button" class="btn btn-white" disabled="disabled">
								<i class="fa fa-trash-o fa-fw"></i>删除
							</button>
						</div>
						<div id="tree"></div>
					</div>
				</div>
			</div>
		
			<div class="col-xs-9">
				<div class="ibox float-e-margins">
					<div class="ibox-content">
						<div class="page-title">
							<h2>考生管理</h2>
						</div>
					</div>
				</div>
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
	<script type="text/javascript" src="${ctx}/plugins/bootstrap-treeview/bootstrap-treeview.min.js"></script>
	
	<script type="text/javascript">
		
		var $page = $('.body-group-list');
		
		var tree = [{
			text: '所有分组',
			id: '1',
			state: {
				checked: true
			},
			tags: ['24'],
			nodes: [{
				text: '默认分组',
				tags: ['12']
			}, {
				text: '自定义分组',
				id: '2',
				nodes: [{
					text: '小组1'
				}, {
					text: '小组2'
				}]
			}]
		}];
		
		$('#tree').treeview({
			data: tree,
			showTags: true,
		});
		
		$('#tree').treeview('checkNode',[ '1', { silent: true }]); 
		
		
		
	</script>
	
</body>
</html>