<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/include/preload.jsp"%>

<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	
	<title>系统公告</title>
	
	<link rel="stylesheet" type="text/css" href="${ctx}/plugins/bootstrap/3.3.6/css/bootstrap.min.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/plugins/font-awesome/4.7.0/css/font-awesome.min.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/plugins/animate/animate.min.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/plugins/bootstrap-table/bootstrap-table.min.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/plugins/bootstrapValidator/css/bootstrapValidator.min.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/plugins/sweetalert/sweetalert.css">
	
	<link rel="stylesheet" type="text/css" href="${ctx}/plugins/hplus/style.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/plugins/web-icons/css/web-icons.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/local/common.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/plugins/toastr/toastr.min.css">
</head>

<body class="gray-bg body-notice-list">
	<div class="wrapper wrapper-content animated fadeInRight">
		<div class="ibox float-e-margins22">
			<div class="ibox-content">
				<div class="page-title">
					<h2>系统公告</h2>
				</div>
				
				<div id="notice-list-table-toolbar" role="group">
					<button type="button" class="btn btn-primary btn-notice-add">
	 						<i class="fa fa-plus fa-fw"></i>发布公告
	 					</button>
					<button type="button" class="btn btn-danger btn-notice-delete-batch" disabled="disabled">
 						<i class="fa fa-trash-o fa-fw"></i>删除
 					</button>
				</div>
 				<table id="notice-list-table" class="table-hm table-fixed" data-mobile-responsive="true"></table>
			</div>
		</div>
	</div>
	
	<div class="modal" id="modal-notice-dialog" tabindex="-1" role="dialog" aria-hidden="true" data-backdrop="static">
    	<div class="modal-dialog modal-center">
    		<div class="modal-content animated fadeInDown">
    			<div class="modal-header">
    				<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                    <h4 class="modal-title"></h4>
    			</div>
    			<div class="modal-body">
    				<form class="form-horizontal" role="form" autocomplete="off">
    					<div class="form-group">
    						<label for="title" class="col-sm-3 control-label"><i class="form-required">*</i>公告标题</label>
    						<div class="col-sm-7">
    							<input type="text" class="form-control" name="title" required data-bv-notempty-message="公告标题不能为空">
    						</div>
    					</div>
    					
    					<div class="form-group">
							<label for="content" class="col-sm-3 control-label"><i class="form-required">*</i>公告内容</label>
							<div class="col-sm-7">
								<textarea class="form-control" name="content" style="resize:none; height: 150px;" required data-bv-notempty-message="公告内容不能为空"></textarea>
							</div>
						</div>
    				</form>
    			</div>
    			<div class="modal-footer">
    				<button type="button" class="btn btn-white btn-fw" data-dismiss="modal">取消</button>
                    <button type="button" class="btn btn-primary btn-fw btn-confirm">确定</button>
    			</div>
    		</div>
    	</div>
    </div>
    
    <div class="modal" id="modal-notice-detail-dialog" tabindex="-1" role="dialog" aria-hidden="true" data-backdrop="static">
    	<div class="modal-dialog modal-center">
    		<div class="modal-content animated fadeInDown">
    			<div class="modal-body" style="max-height: 500px; overflow: auto;">
    				<div class="notice-body" style="padding: 15px 10px 0;">
    					<div class="notice-title" style="font-size: 20px; font-weight: 700; margin-bottom: 15px;"></div>
    					<div class="notice-content"></div>
    					<div class="notice-other help-block text-right" style="margin: 10px 0 0;">
    						<span class="notice-user"></span>
    						<span>发布于</span>
    						<span class="notice-time"></span>
    					</div>
    				</div>
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
	<script type="text/javascript" src="${ctx}/plugins/bootstrapValidator/js/bootstrapValidator.min.js"></script>
	<script type="text/javascript" src="${ctx}/plugins/bootstrapValidator/js/language/zh_CN.js"></script>
	
	<script type="text/javascript">
		
		var $page = $('.body-notice-list');
		var userId = '${user.id}';
		var $detailDialog = $page.find('#modal-notice-detail-dialog');
		
		var $table = $k.util.bsTable($page.find('#notice-list-table'), {
			url: '${ctx}/api/notice/list',
			toolbar: '#notice-list-table-toolbar',
			idField: 'id',
			responseHandler: function(res) {
				return res.data;
			},
			columns: [{
				field: 'state',
				checkbox: true
			}, {
            	title: '#',
            	width: '50',
				formatter: function(value, row, index) {
					return index + 1;
				}
            }, {
				field: 'title',
				title: '公告标题',
				formatter: function(value, row, index) {
					return '<a class="btn-notice-detail">' + value + '</a>';
				},
				events: window.operateEvents = {
					'click .btn-notice-detail': function(e, value, row, index) {
						e.stopPropagation();
						$detailDialog.find('.notice-title').text(value);
						$detailDialog.find('.notice-content').text(row.content);
						$detailDialog.find('.notice-user').text(row.user.name);
						$detailDialog.find('.notice-time').text(formatDate2(row.updateTime));
						$detailDialog.modal('show');
					}
				}
			}, {
				field: 'content',
				title: '公告内容'
			}, {
				field: 'user',
				title: '发布人',
				width: '100',
				formatter: function(value, row, index) {
					return value.username;
				}
			}, {
				field: 'updateTime',
				title: '发布时间',
				align: 'center',
				width: 150,
				formatter: formatDate2
			}, {
				title: '操作',
				align: 'center',
				width: '100',
				formatter: function(value, row, index) {
					if (row.editable == 0) {
						var $top = '<span class="btn-operate btn-notice-top" data-toggle="tooltip" title="置顶"><i class="wb-arrow-up"></i></span>';
						var $edit = '<span class="btn-operate btn-notice-edit" data-toggle="tooltip" title="编辑"><i class="wb-edit"></i></span>';
						var $delete = '<span class="btn-operate btn-notice-delete" data-toggle="tooltip" title="删除"><i class="wb-close"></i></span>';
						return $top + $edit + $delete; 
					} 
				},
				events: window.operateEvents = {
					'click .btn-notice-top': function(e, value, row, index) {
						e.stopPropagation();
						swal({
            				title: '您确定要置顶所选的公告吗?',
            				type: 'warning',
            				showCancelButton: true,
            			}, function() {
            				$.ajax({
            					url: '${ctx}/api/notice/top',
            					data: {
            						noticeId: row.id
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
					},
					'click .btn-notice-edit': function(e, value, row, index) {
						e.stopPropagation();
						$dialog.find('.modal-title').text('编辑公告');
						$dialog.find('input[name="title"]').val(row.title);
						$dialog.find('textarea[name="content"]').val(row.content);
						$dialog.data('noticeId', row.id);
            			$dialog.modal('show');
					},
					'click .btn-notice-delete': function(e, value, row, index) {
						e.stopPropagation();
						swal({
            				title: '您确定要删除所选择的反馈吗?',
            				type: 'warning',
            				showCancelButton: true,
            			}, function() {
            				$.ajax({
            					url: '${ctx}/api/notice/delete',
            					data: {
            						noticeId: row.id
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
		
		$table
		.on('load-success.bs.table',function(data){
			$page.find('[data-toggle="tooltip"]').tooltip();
		})
		.on('all.bs.table', function(e, row) {
            var selNum = $table.bootstrapTable('getSelections').length;
            selNum > 0 ? $page.find('.btn-notice-delete-batch').removeAttr('disabled') : $page.find('.btn-notice-delete-batch').attr('disabled', 'disabled');
        });
		
		// 角色添加/编辑对话框
		var $dialog = $page.find('#modal-notice-dialog');
		var $form = $dialog.find('form');
		$k.util.bsValidator($form);
		$dialog.on('click', '.btn-confirm', function() {
			var validator = $form.data('bootstrapValidator');
			validator.validate();
			
            if (validator.isValid()) {
            	var method = $dialog.data('method');
            	if (method == 'add') {
            		$.ajax({
 						url: '${ctx}/api/notice/create',
                 		type: 'POST',
                 		data: {
                 			title: $dialog.find('input[name = "title"]').val(),
                 			content: $dialog.find('textarea[name = "content"]').val(),
                 			userId: userId
                 		},
                 		success: function(ret) {
                 			if (ret.code == 0) {
                 				$dialog.modal('hide');
	               				toastr['success'](ret.msg);
	                   			$table.bootstrapTable('refresh'); 
	               			} else {
	               				toastr['error'](ret.msg);
	               			}
                 		},
                 		error: function(err) {}
                 	});
            	} else {
            		$.ajax({
                		url: '${ctx}/api/notice/update',
                		type: 'POST',
                		data: {
                			noticeId: $dialog.data('noticeId'),
                			title: $dialog.find('input[name = "title"]').val(),
                 			content: $dialog.find('textarea[name = "content"]').val(),
                 			userId: userId
                		},
                		success: function(ret) {
                			if (ret.code == 0) {
                 				$dialog.modal('hide');
	               				toastr['success'](ret.msg);
	                   			$table.bootstrapTable('refresh'); 
	               			} else {
	               				toastr['error'](ret.msg);
	               			}
                		},
                		error: function(err) {}
                	});
            	}
            }
		});
		
		$page
		.on('hidden.bs.modal', '#modal-notice-dialog', function() {
            $form.bootstrapValidator('resetForm', true);
            $(this).removeData('bs.modal');
        }) 
		.on('click', '.btn-notice-add', function() {
			$dialog.find('.modal-title').text('发布公告');
			$dialog.data('method', 'add');
			$dialog.modal('show');
		})
		.on('click', '.btn-notice-delete-batch', function() {
			swal({
                title: '您确定要删除所选择的反馈吗?',
                type: 'warning',
                showCancelButton: true,
            }, function() {
                var rows = $table.bootstrapTable('getSelections');
                $.ajax({
                    url: '${ctx}/api/notice/batchDelete',
                    type: 'post',
                    data: { 
                        noticeIdList: $k.util.getIdList(rows) 
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