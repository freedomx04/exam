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
    <%@ include file="/WEB-INF/pages/exam/dialog_student_add.jsp"%>
    
    <script type="text/javascript">
    	
    	var $page = $('.body-paper-student');
    	var paper = {
    		id: '${paper.id}'
    	}
    	
    	var $table = $k.util.bsTable($page.find('#paper-student-table'), {
			url: '${ctx}/api/paper/student/list?paperId=' + paper.id,
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
					var $delete = '<a class="btn-student-delete a-operate">删除</a>';
					return $delete;
				},
				events: window.operateEvents = {
					'click .btn-student-delete': function(e, value, row, index) {
						e.stopPropagation();
						swal({
            				title: '',
            				text: '您确定要删除所选择的考生吗?',
            				type: 'warning',
            				showCancelButton: true,
                            cancelButtonText: '取消',
                            confirmButtonColor: '#DD6B55',
                            confirmButtonText: '确定',
                            closeOnConfirm: false
            			}, function() {
            				$.ajax({
            					url: '${ctx}/api/paper/student/delete',
            					data: {
            						paperId: paper.id,
            						studentId: row.id
            					},
            					success: function(ret) {
            						if (ret.code == 0) {
            							swal('', '删除成功!', 'success');
            						} else {
            							swal('', ret.msg, 'error');
            						}
            						$table.bootstrapTable('refresh'); 
            					},
            					error: function(err) {}
            				});
            			});
					}
				}
			}]
		});
    	
    	$table.on('all.bs.table', function(e, row) {
            var selNum = $table.bootstrapTable('getSelections').length;
            selNum > 0 ? $page.find('.btn-paper-student-delete-batch').removeAttr('disabled') : $page.find('.btn-paper-student-delete-batch').attr('disabled', 'disabled');
        });
    	
    	$page
		.on('click', '.btn-paper-student-delete-batch', function() {
			swal({
                title: '',
                text: '您确定要删除所选择的考生吗?',
                type: 'warning',
                showCancelButton: true,
                cancelButtonText: '取消',
                confirmButtonColor: '#DD6B55',
                confirmButtonText: '确定',
                closeOnConfirm: false
            }, function() {
                var rows = $table.bootstrapTable('getSelections');
                $.ajax({
                    url: '${ctx}/api/paper/student/batchDelete',
                    type: 'post',
                    data: { 
                    	paperId: paper.id,
                        studentIdList: $k.util.getIdList(rows) 
                    },
                    success: function(ret) {
                        if (ret.code == 0) {
                            swal('', '删除成功!', 'success');
						} else {
                            swal('', ret.msg, 'error');
                        }
                        $table.bootstrapTable('refresh'); 
                    },
                    error: function(err) {}
                });
            });
		});
		
    </script>
    
</body>
</html>