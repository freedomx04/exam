<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/include/preload.jsp"%>

<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	
	<title>用户管理</title>
	
	<link rel="stylesheet" type="text/css" href="${ctx}/plugins/bootstrap/3.3.6/css/bootstrap.min.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/plugins/font-awesome/4.7.0/css/font-awesome.min.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/plugins/animate/animate.min.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/plugins/bootstrap-table/bootstrap-table.min.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/plugins/sweetalert/sweetalert.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/plugins/bootstrapValidator/css/bootstrapValidator.min.css">
	
	<link rel="stylesheet" type="text/css" href="${ctx}/plugins/hplus/style.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/local/common.css">
	
</head>

<body class="gray-bg body-user-list">
	<div class="wrapper wrapper-content animated fadeInRight">
		<div class="ibox">
			<div class="ibox-content">
				<h2 class="page-title">用户管理</h2>
				
				<div class="btn-group" id="user-list-table-toolbar" role="group">
                    <button type="button" class="btn btn-primary btn-user-add">
                        <i class="fa fa-plus fa-fw"></i>新增用户
                    </button>
                </div>
                <table id="user-list-table" class="table-hm" data-mobile-responsive="true"> </table>
			</div>
		</div>
	</div>
	
	<div class="modal" id="modal-password-dialog" tabindex="-1" role="dialog" aria-hidden="true" data-backdrop="static">
        <div class="modal-dialog">
            <div class="modal-content animated fadeInDown">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                    <h4 class="modal-title"><strong>修改密码</strong></h4>
                </div>
                <div class="modal-body">
                    <form class="form-horizontal" role="form" id="form-password" autocomplete="off">
                        <div class="form-group">
							<label for="newPassword" class="col-sm-3 control-label"><i class="form-required">*</i>新密码</label>
							<div class="col-sm-7">
								<input type="password" class="form-control" name="newPassword" id="newPassword" required data-bv-notempty-message="请输入新密码">
							</div>
						</div>
						
						<div class="form-group">
							<label for="confirmPassword" class="col-sm-3 control-label"><i class="form-required">*</i>确认密码</label>
							<div class="col-sm-7">
								<input type="password" class="form-control" name="confirmPassword" required data-bv-notempty-message="请输入确认密码">
							</div>
						</div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-white" data-dismiss="modal">
                        <i class="fa fa-close fa-fw"></i>关闭
                    </button>
                    <button type="button" class="btn btn-primary btn-confirm">
                        <i class="fa fa-check fa-fw"></i>确定
                    </button>
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
	<script type="text/javascript" src="${ctx}/plugins/bootstrapValidator/js/bootstrapValidator.min.js"></script>
	<script type="text/javascript" src="${ctx}/plugins/bootstrapValidator/js/language/zh_CN.js"></script>
	
	<script type="text/javascript">
	;(function( $ ) {
		
		var $page = $('.body-user-list');
		
		var $dialog = $page.find('#modal-password-dialog');
		var $form = $dialog.find('form');
		$k.util.bsValidator($form, {
			fields: {
				newPassword: {
					validators: {
						identical: {
							field: 'confirmPassword',
							message: '输入的两次密码不一致'
						}, 
						stringLength: {
							min: 6,
							max: 16,
							message: '密码长度必须在6到16之间'
						}
					}
				},
				confirmPassword: {
					validators: {
						identical: {
							field: 'newPassword',
							message: '输入的两次密码不一致'
						}, 
						stringLength: {
							min: 6,
							max: 16,
							message: '密码长度必须在6到16之间'
						}
					}
				}
			}
		});
		
		var $table = $k.util.bsTable($page.find('#user-list-table'), {
			url: '${ctx}/api/user/list',
			toolbar: '#user-list-table-toolbar',
			idField: 'id',
			showExport: true, 
			responseHandler: function(res) {
                return res.data;
            },
            columns: [{
            	title: '#',
            	width: '20',
				formatter: function(value, row, index) {
					return index + 1;
				}
            }, {
            	field: 'username',
            	title: '用户名',
            }, {
            	field: 'name',
            	title: '姓名',
            }, {
            	field: 'role',
            	title: '角色',
            	formatter: function(value, row, index) {
            		return value.name;
            	}
            }, {
            	field: 'status',
            	title: '状态',
            	align: 'center',
            	width: '100',
            	formatter: function(value, row, index) {
            		if (value == 0) {
            			return '<span class="label label-primary">正常</span>';
            		} else {
            			return '<span class="label label-warning">禁用</span>';
            		}
            	}
            }, {
            	title: '操作',
            	align: 'center',
            	width: '200',
            	formatter: function(value, row, index) {
            		var $edit = '<a class="btn-user-edit a-operate">编辑</a>';
            		var $password = '<a class="btn-user-password a-operate">修改密码</a>';
           			if (row.status == 0) {
               			$status = '<a class="btn-user-disable a-operate">禁用</a>';
               		} else {
               			$status = '<a class="btn-user-enable a-operate">启用</a>';
               		}
           			var $delete = '<a class="btn-user-delete a-operate">删除</a>';
            		return $edit + $password + $status + $delete;
            	},
            	events: window.operateEvents = {
           			'click .btn-user-edit': function(e, value, row, index) {
               			e.stopPropagation();
               			window.location.href = '${ctx}/userAdd?method=edit&userId=' + row.id;
               		},
           			'click .btn-user-password': function(e, value, row, index) {
               			e.stopPropagation();
               			$dialog.data('userId', row.id);
               			$dialog.modal('show');
               		},
            		'click .btn-user-enable': function(e, value, row, index) {
            			e.stopPropagation();
            			swal({
            				title: '',
            				text: '确定启用该用户?',
            				type: 'warning',
            				showCancelButton: true,
                            cancelButtonText: '取消',
                            confirmButtonColor: '#DD6B55',
                            confirmButtonText: '确定',
                            closeOnConfirm: false		
            			}, function() {
            				$.ajax({
                				url: '${ctx}/api/user/status',
                				data: {
                					userId: row.id,
                					status: 0
                				},
                				success: function(ret) {
                					if (ret.code == 0) {
                						swal({
                                            title: '',
                                            text: '操作成功',
                                            type: 'success'
                                        }, function() {
                                        	$table.bootstrapTable('refresh'); 
                                        });
                					} else {
                						swal('', ret.msg, 'error');
                					}
                				},
                				error: function(err) {}
                			});
            			});
            		},
            		'click .btn-user-disable': function(e, value, row, index) {
            			e.stopPropagation();
            			swal({
            				title: '',
            				text: '确定禁用该用户?',
            				type: 'warning',
            				showCancelButton: true,
                            cancelButtonText: '取消',
                            confirmButtonColor: '#DD6B55',
                            confirmButtonText: '确定',
                            closeOnConfirm: false		
            			}, function() {
            				$.ajax({
                				url: '${ctx}/api/user/status',
                				data: {
                					userId: row.id,
                					status: 1
                				},
                				success: function(ret) {
                					if (ret.code == 0) {
                						swal({
                                            title: '',
                                            text: '操作成功',
                                            type: 'success'
                                        }, function() {
                                        	$table.bootstrapTable('refresh'); 
                                        });
                					} else {
                						swal('', ret.msg, 'error');
                					}
                				},
                				error: function(err) {}
                			});
            			});
            		}
            	}
            }]
		});
		
		$page
		.on('hidden.bs.modal', '#modal-password-dialog', function() {
			$form.bootstrapValidator('resetForm', true);
			$(this).removeData('bs.modal');
		})
		.on('click', '.btn-user-add', function() {
			window.location.href = './userAdd?method=add';
		});
		
		$dialog.on('click', '.btn-confirm', function() {
			var validator = $form.data('bootstrapValidator');
			validator.validate();
			
			if (validator.isValid()) {
				$.ajax({
					url: '${ctx}/api/user/password2',
					type: 'post',
					data: {
						userId: $dialog.data('userId'),
						password: $form.find('input[name="newPassword"]').val()
					},
					success: function(ret) {
						if (ret.code == 0) {
							$dialog.modal('hide');
							swal('', '密码修改成功', 'success');
                    	} else {
                    		swal('', ret.msg, 'error');
                    	}
					},
					error: function(err) {}
				});
			}
		});
		
		
	})( jQuery );
	</script>
</body>
</html>
