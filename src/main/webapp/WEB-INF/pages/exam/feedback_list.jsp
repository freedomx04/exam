<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/include/preload.jsp"%>

<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	
	<title>建议反馈</title>
	
	<link rel="stylesheet" type="text/css" href="${ctx}/plugins/bootstrap/3.3.6/css/bootstrap.min.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/plugins/font-awesome/4.7.0/css/font-awesome.min.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/plugins/animate/animate.min.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/plugins/bootstrap-table/bootstrap-table.min.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/plugins/sweetalert/sweetalert.css">
	
	<link rel="stylesheet" type="text/css" href="${ctx}/plugins/hplus/style.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/local/common.css">
	
</head>

<body class="gray-bg body-feedback-list">
	<div class="wrapper wrapper-content animated fadeInRight">
		<div class="ibox float-e-margins">
			<div class="ibox-content">
				<div class="page-title">
					<h2>建议反馈</h2>
				</div>
				
				<div id="feedback-list-table-toolbar" role="group">
					<button type="button" class="btn btn-white btn-feedback-delete-batch" disabled="disabled">
 						<i class="fa fa-trash-o fa-fw"></i>批量删除
 					</button>
				</div>
 				<table id="feedback-list-table" class="table-hm" data-mobile-responsive="true"></table>
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
		
		var $page = $('.body-feedback-list');
		
		var $table = $k.util.bsTable($page.find('#feedback-list-table'), {
			url: '${ctx}/api/feedback/list',
			toolbar: '#feedback-list-table-toolbar',
			idField: 'id',
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
				field: 'content',
				title: '反馈内容',
			}, {
				field: 'paper',
				title: '试卷标题',
				formatter: function(value, row, index) {
					return value.title;
				},
				cellStyle: function(row, index) {
					return { css: {'white-space': 'nowrap'} };
				}
			}, {
				field: 'student',
				title: '反馈考生',
				formatter: function(value, row, index) {
					return value.name;
				},
				cellStyle: function(row, index) {
					return { css: {'white-space': 'nowrap'} };
				}
			}, {
				title: '操作',
				align: 'center',
				width: '80',
				formatter: function(value, row, index) {
					if (row.editable == 0) {
						var $start = '<div class="dropdown"><a data-toggle="dropdown" aria-expanded="true">操作<span class="caret"></span></a><ul class="dropdown-menu">';
						var $delete = '<li><a class="btn-feedback-delete"><i class="fa fa-trash-o fa-fw"></i>删除</a></li>';
						var $end = '</ul></div>';
						return $start + $delete + $end;
					} 
				},
				events: window.operateEvents = {
					'click .btn-feedback-delete': function(e, value, row, index) {
						e.stopPropagation();
						var text = '您确定要删除所选择的反馈吗?';
						swal({
            				title: '',
            				text: text,
            				type: 'warning',
            				showCancelButton: true,
                            cancelButtonText: '取消',
                            confirmButtonColor: '#DD6B55',
                            confirmButtonText: '确定',
                            closeOnConfirm: false
            			}, function() {
            				$.ajax({
            					url: '${ctx}/api/feedback/delete',
            					data: {
            						feedbackId: row.id
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
            selNum > 0 ? $page.find('.btn-feedback-delete-batch').removeAttr('disabled') : $page.find('.btn-feedback-delete-batch').attr('disabled', 'disabled');
        });
		
		$page
		.on('click', '.btn-feedback-delete-batch', function() {
			swal({
                title: '',
                text: '您确定要删除所选择的反馈吗?',
                type: 'warning',
                showCancelButton: true,
                cancelButtonText: '取消',
                confirmButtonColor: '#DD6B55',
                confirmButtonText: '确定',
                closeOnConfirm: false
            }, function() {
                var rows = $table.bootstrapTable('getSelections');
                $.ajax({
                    url: '${ctx}/api/feedback/batchDelete',
                    type: 'post',
                    data: { 
                        feedbackIdList: $k.util.getIdList(rows) 
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