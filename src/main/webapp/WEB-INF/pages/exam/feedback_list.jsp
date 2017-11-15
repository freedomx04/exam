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
	<link rel="stylesheet" type="text/css" href="${ctx}/plugins/toastr/toastr.min.css">
</head>

<body class="gray-bg body-feedback-list">
	<div class="wrapper wrapper-content animated fadeInRight">
		<div class="ibox float-e-margins">
			<div class="ibox-content">
				<div class="page-title">
					<h2>建议反馈<small style="margin-left: 20px;">${title}</small></h2>
					<a href="${ctx}/paperList"><i class="fa fa-mail-reply fa-fw"></i>试卷管理</a>
				</div>
				
				<div id="feedback-list-table-toolbar" role="group">
					<button type="button" class="btn btn-danger btn-feedback-delete-batch" disabled="disabled">
 						<i class="fa fa-trash-o fa-fw"></i>删除
 					</button>
				</div>
 				<table id="feedback-list-table" class="table-hm table-fixed" data-mobile-responsive="true"></table>
			</div>
		</div>
	</div>
	
	<div class="modal" id="modal-feedback-dialog" tabindex="-1" role="dialog" aria-hidden="true" data-backdrop="static">
    	<div class="modal-dialog modal-center">
    		<div class="modal-content animated fadeInDown">
    			<div class="modal-header">
    				<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                    <h4 class="modal-title">反馈内容</h4>
    			</div>
    			<div class="modal-body" style="max-height: 400px; overflow: auto;">
    				<div class="feedback-detail"></div>
    			</div>
    			<div class="modal-footer">
    				<button type="button" class="btn btn-primary btn-fw" data-dismiss="modal">取消</button>
    			</div>
    		</div>
    	</div>
    </div>
	
	<script type="text/javascript" src="${ctx}/plugins/jquery/2.1.4/jquery.min.js"></script>
	<script type="text/javascript" src="${ctx}/plugins/bootstrap/3.3.6/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="${ctx}/plugins/hplus/content.min.js"></script>
	<script type="text/javascript" src="${ctx}/local/common.js"></script>
	
	<script type="text/javascript" src="${ctx}/plugins/sweetalert/sweetalert.js"></script>
	<script type="text/javascript" src="${ctx}/plugins/toastr/toastr.min.js"></script>
	<script type="text/javascript" src="${ctx}/plugins/bootstrap-table/bootstrap-table.min.js"></script>
	<script type="text/javascript" src="${ctx}/plugins/bootstrap-table/locale/bootstrap-table-zh-CN.min.js"></script>
	
	<script type="text/javascript">
		
		var $page = $('.body-feedback-list');
		var $dialog = $page.find('#modal-feedback-dialog');
		
		var $table = $k.util.bsTable($page.find('#feedback-list-table'), {
			url: '${ctx}/api/feedback/listByPaperId?paperId=${paperId}',
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
				formatter: function(value, row, index) {
					return '<a class="btn-feedback-detail">' + value + '</a>';
				},
				events: window.operateEvents = {
					'click .btn-feedback-detail': function(e, value, row, index) {
						e.stopPropagation();
						$dialog.find('.feedback-detail').text(value);
						$dialog.modal('show');
					}
				}
			}, {
				field: 'student',
				title: '反馈考生',
				width: '100',
				formatter: function(value, row, index) {
					return value.name;
				}
			}, {
				title: '操作',
				align: 'center',
				width: '80',
				formatter: function(value, row, index) {
					if (row.editable == 0) {
						var $delete = '<a class="btn-feedback-delete a-operate">删除</a>';
						return $delete;
					} 
				},
				events: window.operateEvents = {
					'click .btn-feedback-delete': function(e, value, row, index) {
						e.stopPropagation();
						swal({
            				title: '您确定要删除所选择的反馈吗?',
            				type: 'warning',
            				showCancelButton: true,
            			}, function() {
            				$.ajax({
            					url: '${ctx}/api/feedback/delete',
            					data: {
            						feedbackId: row.id
            					},
            					success: function(ret) {
            						if (ret.code == 0) {
            							toastr['success'](ret.msg);
            							$table.bootstrapTable('refresh'); 
            						} else {
            							toastr['error'](ret.msg);
            						}
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
                title: '您确定要删除所选择的反馈吗?',
                type: 'warning',
                showCancelButton: true,
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
							toastr['success'](ret.msg);
							$table.bootstrapTable('refresh'); 
						} else {
							toastr['error'](ret.msg);
						}
                    },
                    error: function(err) {}
                });
            });
		});
		
	</script>
	
</body>
</html>