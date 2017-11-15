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
	<link rel="stylesheet" type="text/css" href="${ctx}/plugins/awesome-bootstrap-checkbox/awesome-bootstrap-checkbox.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/plugins/animate/animate.min.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/plugins/bootstrap-table/bootstrap-table.min.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/plugins/sweetalert/sweetalert.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/plugins/bootstrapValidator/css/bootstrapValidator.min.css">
	
	<link rel="stylesheet" type="text/css" href="${ctx}/plugins/hplus/style.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/plugins/toastr/toastr.min.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/local/common.css">
	
</head>
<body class="gray-bg body-user-list">
	<div class="wrapper wrapper-content animated fadeInRight height-full">
		<div class="ibox float-e-margins height-full" style="margin-bottom: 0;">
			<div class="height-full" style="position: relative;">
				<div class="page-aside">
					<div class="page-aside-inner height-full">
						<div class="page-aside-section">
							<div class="list-group">
								<a class="list-group-item active" href="javascript:;" data-id="0">
									<%-- <span class="item-right group-student-total">${total}</span> --%>
									<i class="fa fa-street-view fa-fw"></i>所有用户
								</a>
							</div>
						</div>
						
						<div class="page-aside-section">
							<h4 class="page-aside-title"><i class="fa fa-bars fa-fw"></i>角色列表</h4>
							<div class="list-group has-actions">
								<c:forEach var="role" items="${roleList}">
									<div class="list-group-item" data-id="${role.id}">
										<div class="list-content">
											<%-- <span class="item-right">${group.count}</span> --%>
											<span class="item-text">${role.name}</span>
											<c:if test="${role.editable == 0}">
												<div class="item-actions">
													<span class="btn btn-pure btn-role-edit"><i class="fa fa-edit"></i></span>
													<span class="btn btn-pure btn-role-delete"><i class="fa fa-remove"></i></span>
												</div>
											</c:if>
										</div>
									</div>
								</c:forEach>
							</div>
						</div>
						
						<div class="page-aside-section">
							<a class="list-group-item btn-role-add" href="javascript:;">
								<i class="fa fa-plus fa-fw"></i>添加新角色
							</a>
						</div>
					</div>
				</div>
				
				<div class="page-main ibox-content">
					<div class="page-title">
						<h2>考生列表</h2>
					</div>
					<div id="user-list-table-toolbar" role="group">
						<button type="button" class="btn btn-primary btn-user-add" data-toggle="modal" data-target="#modal-user-dialog">
	 						<i class="fa fa-user-plus fa-fw"></i>新增用户
	 					</button>
	 					<button type="button" class="btn btn-danger btn-user-delete-batch" disabled='disabled'>
	 						<i class="fa fa-trash-o fa-fw"></i>删除
	 					</button>
					</div>
					<table id="user-list-table" class="table-hm table-fixed" data-mobile-responsive="true"></table>
				</div>
			</div>
		</div>
	</div>
	
	<div class="modal" id="modal-role-dialog" tabindex="-1" role="dialog" aria-hidden="true" data-backdrop="static">
        <div class="modal-dialog modal-center">
            <div class="modal-content animated fadeInDown">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                    <h4 class="modal-title"></h4>
                </div>
                <div class="modal-body">
                    <form class="form-horizontal" role="form" autocomplete="off">
                        <div class="form-group">
                            <label for="name" class="col-sm-3 control-label"><i class="form-required">*</i>角色名称</label>
                            <div class="col-sm-7">
                                <input type="text" class="form-control" name="name" required data-bv-notempty-message="角色名称">
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
    
    <div class="modal" id="modal-user-add-dialog" tabindex="-1" role="dialog" aria-hidden="true" data-backdrop="static">
    	<div class="modal-dialog modal-center">
            <div class="modal-content animated fadeInDown">
            	<div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                    <h4 class="modal-title">添加用户</h4>
                </div>
                <div class="modal-body">
                	<form class="form-horizontal" role="form" autocomplete="off">
                		<div class="form-group">
                			<label for="roleId" class="col-sm-3 control-label"><i class="form-required">*</i>角色</label>
                			<div class="col-sm-7">
                				<select class="form-control" name="roleId"></select>
                			</div>
                		</div>
                		
                		<div class="form-group">
							<label for="username" class="col-sm-3 control-label"><i class="form-required">*</i>用户名</label>
	                        <div class="col-sm-7">
	                            <input type="text" class="form-control" name="username" placeholder="只能包含英文、数字、下划线等字符" required data-bv-notempty-message="用户名不能为空">
	                        </div>
						</div>
						
						<div class="form-group">
							<label for="password" class="col-sm-3 control-label"><i class="form-required">*</i>密码</label>
							<div class="col-sm-7">
								<input type="password" id="password" class="form-control" name="password" placeholder="6-16个字符,请使用字母加数字或者符号" required data-bv-notempty-message="密码不能为空">
							</div>
						</div>
						<div class="form-group">
							<label for="confirm-password" class="col-sm-3 control-label"><i class="form-required">*</i>确认密码</label>
							<div class="col-sm-7">
								<input type="password" class="form-control" name="confirmPassword" placeholder="请再次输入密码" required data-bv-notempty-message="确认密码不能为空">
							</div>
						</div>
						
						<div class="form-group">
							<label for="name" class="col-sm-3 control-label"><i class="form-required">*</i>姓名</label>
	                        <div class="col-sm-7">
	                            <input type="text" class="form-control" name="name" placeholder="请输入姓名" required data-bv-notempty-message="姓名不能为空">
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
    
    <div class="modal" id="modal-user-edit-dialog" tabindex="-1" role="dialog" aria-hidden="true" data-backdrop="static">
    	<div class="modal-dialog modal-center">
    		<div class="modal-content animated fadeInDown">
    			<div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                    <h4 class="modal-title">编辑用户</h4>
                </div>
                <div class="modal-body">
                	<form class="form-horizontal" role="form" autocomplete="off">
                		<div class="form-group">
                			<label for="roleId" class="col-sm-3 control-label"><i class="form-required">*</i>角色</label>
                			<div class="col-sm-7">
                				<select class="form-control" name="roleId"></select>
                			</div>
                		</div>
                		
                		<div class="form-group">
							<label for="username" class="col-sm-3 control-label">用户名</label>
	                        <div class="col-sm-7">
	                            <input type="text" class="form-control" name="username" placeholder="只能包含英文、数字、下划线等字符" required data-bv-notempty-message="用户名不能为空" disabled="disabled">
	                        </div>
						</div>
						
						<div class="form-group">
							<label for="name" class="col-sm-3 control-label"><i class="form-required">*</i>姓名</label>
	                        <div class="col-sm-7">
	                            <input type="text" class="form-control" name="name" placeholder="请输入姓名" required data-bv-notempty-message="姓名不能为空">
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
    
    <div class="modal" id="modal-user-password-dialog" tabindex="-1" role="dialog" aria-hidden="true" data-backdrop="static">
        <div class="modal-dialog modal-center">
            <div class="modal-content animated fadeInDown">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                    <h4 class="modal-title">修改密码</h4>
                </div>
                <div class="modal-body">
                    <form class="form-horizontal" role="form" id="form-password" autocomplete="off">
                        <div class="form-group">
							<label for="password" class="col-sm-3 control-label"><i class="form-required">*</i>密码</label>
							<div class="col-sm-7">
								<input type="password" id="password" class="form-control" name="password" placeholder="6-16个字符,请使用字母加数字或者符号" required data-bv-notempty-message="密码不能为空">
							</div>
						</div>
						<div class="form-group">
							<label for="confirm-password" class="col-sm-3 control-label"><i class="form-required">*</i>确认密码</label>
							<div class="col-sm-7">
								<input type="password" class="form-control" name="confirmPassword" placeholder="请再次输入密码" required data-bv-notempty-message="确认密码不能为空">
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
	;(function( $ ) {
		
		var $page = $('.body-user-list');
		var $aside = $('.page-aside');
		
		var $table;
		var roleId = 0;
		initTable(roleId);
		
		function initTable(roleId) {
			$page.find('#user-list-table').bootstrapTable('destroy'); 
			
			$table = $k.util.bsTable($page.find('#user-list-table'), {
				url: '${ctx}/api/user/listByRole?roleId=' + roleId,
				toolbar: '#user-list-table-toolbar',
				idField: 'id',
				responseHandler: function(res) {
					return res.data;
				},
				columns: [{
					field: 'state',
					checkbox: true,
					formatter: function(value, row, index) {
						if (row.editable == 1) {
							return { disabled: true };
						}
					}
				}, {
					title: '#',
					width: '50',
					formatter: function(value, row, index) {
						return index + 1;
					}
				}, {
					field: 'username',
	            	title: '用户名',
	            	formatter: function(value, row, index) {
	            		return '<a class="btn-user-detail">' + value + '</a>';
	            	},
	            	events: window.operateEvents = {
	            		'click .btn-user-detail': function(e, value, row, index) {
	            			e.stopPropagation();
	            		}	
	            	}
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
	            	width: '80',
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
	            	width: '80',
	            	formatter: function(value, row, index) {
	            		if (row.editable == 0) {
		            		var $start = '<div class="dropdown"><a data-toggle="dropdown" aria-expanded="true">操作<span class="caret"></span></a><ul class="dropdown-menu">';
							var $edit = '<li><a class="btn-user-edit"><i class="fa fa-edit fa-fw"></i>编辑</a></li>';
							var $password = '<li><a class="btn-user-password"><i class="fa fa-key fa-fw"></i>修改密码</a></li>';
							if (row.status == 0) {
								$status = '<li><a class="btn-user-disable"><i class="fa fa-ban fa-fw"></i>禁用</a></li>';
							} else {
								$status = '<li><a class="btn-user-enable"><i class="fa fa-circle-o fa-fw"></i>启用</a></li>';
							}
							var $delete = '<li><a class="btn-user-delete"><i class="fa fa-trash-o fa-fw"></i>删除</a></li>';
							var $end = '</ul></div>';
							return $start + $edit + $password + $status + $delete + $end;
	            		}
	            	},
	            	events: window.operateEvents = {
	           			'click .btn-user-edit': function(e, value, row, index) {
	           				e.stopPropagation();
	            			$.each(row, function(key, val) {
	            				$editForm.find('input[name="' + key + '"]').val(val);
	            			});
	            			$.ajax({
	            				url: '${ctx}/api/role/list',
	            				success: function(ret) {
	            					if (ret.code == 0) {
	            						var $select = $editDialog.find('select[name="roleId"]');
	            						$select.empty();
	            						$.each(ret.data, function(k, val) {
	            							var $option = '<option value="' + val.id + '">' + val.name + '</option>';
	            							$select.append($option);
	            						});
	            						$select.val(row.role.id);
	            					}
	            				},
	            				error: function(err) {}
	            			});
	            			$editDialog.data('userId', row.id);
	            			$editDialog.modal('show');
	               		},
	           			'click .btn-user-password': function(e, value, row, index) {
	           				e.stopPropagation();
							$passwordDialog.data('userId', row.id);
	            			$passwordDialog.modal('show');
	               		},
	            		'click .btn-user-enable': function(e, value, row, index) {
	            			e.stopPropagation();
	            			swal({
	            				title: '确定启用该用户?',
	            				type: 'warning',
	            				showCancelButton: true,
	            			}, function() {
	            				$.ajax({
	                				url: '${ctx}/api/user/status',
	                				data: {
	                					userId: row.id,
	                					status: 0
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
	            		'click .btn-user-disable': function(e, value, row, index) {
	            			e.stopPropagation();
	            			swal({
	            				title: '确定禁用该用户?',
	            				type: 'warning',
	            				showCancelButton: true,
	            			}, function() {
	            				$.ajax({
	                				url: '${ctx}/api/user/status',
	                				data: {
	                					userId: row.id,
	                					status: 1
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
	            		'click .btn-user-delete': function(e, value, row, index) {
							e.stopPropagation();
							swal({
	            				title: '您确定要删除所选择的用户吗?',
	            				type: 'warning',
	            				showCancelButton: true,
	            			}, function() {
	            				$.ajax({
	            					url: '${ctx}/api/user/delete',
	            					data: {
	            						userId: row.id
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
	            	},
	            	cellStyle: function(value, row, index) {
						return { css: {'overflow': 'visible'} };
					}
				}]
			});
			$table.on('all.bs.table', function(e, row) {
	            var selNum = $table.bootstrapTable('getSelections').length;
	            selNum > 0 ? $page.find('.btn-user-delete-batch').removeAttr('disabled') : $page.find('.btn-user-delete-batch').attr('disabled', 'disabled');
	            selNum > 0 ? $page.find('.btn-user-move').removeAttr('disabled') : $page.find('.btn-user-move').attr('disabled', 'disabled');
	        });
		}
		
		// 角色添加/编辑对话框
		var $roleDialog = $page.find('#modal-role-dialog');
		var $roleForm = $roleDialog.find('form');
		$k.util.bsValidator($roleForm);
		$roleDialog.on('click', '.btn-confirm', function() {
			var validator = $roleForm.data('bootstrapValidator');
			validator.validate();
			
            if (validator.isValid()) {
            	var method = $roleDialog.data('method');
            	var name = $roleDialog.find('input[name = "name"]').val();
            	if (method == 'add') {
            		$.ajax({
 						url: '${ctx}/api/role/create',
                 		type: 'POST',
                 		data: {
                 			name: name,
                 			resource: ''
                 		},
                 		success: function(ret) {
                 			if (ret.code == 0) {
	               				$roleDialog.modal('hide');
	               				toastr['success'](ret.msg);
	               				
	               				var role = ret.data;
	               				var $item = '<div class="list-group-item" data-id="' + role.id + '">'
	               							+ 	'<div class="list-content">'
	               							+		'<span class="item-text">' + role.name + '</span>'
	               							+ 		'<div class="item-actions">'
	               							+			'<span class="btn btn-pure btn-role-edit"><i class="fa fa-edit"></i></span>'
	               							+			'<span class="btn btn-pure btn-role-delete"><i class="fa fa-remove"></i></span>'
	               							+		'</div>'
	               							+ 	'</div>'
	               							+ '</div>';
	               				$aside.find('.list-group.has-actions').append($item);
	               			} else {
	               				toastr['error'](ret.msg);
	               			}
                 		},
                 		error: function(err) {}
                 	});
            	} else {
            		var roleId = $roleDialog.data('roleId');
            		$.ajax({
                		url: '${ctx}/api/role/update',
                		type: 'POST',
                		data: { 
                			roleId: roleId, 
                			name: name,
                			resource: ''
                		},
                		success: function(ret) {
                			if (ret.code == 0) {
                				$roleDialog.modal('hide');
	               				toastr['success'](ret.msg);
	               				$aside.find('.list-group-item[data-id="' + roleId + '"]').find('.item-text').text(name);
                			} else {
                				toastr['error'](ret.msg);
                			}
                		},
                		error: function(err) {}
                	});
            	}
            }
		});
		
		// 用户添加对话框
		var $addDialog = $page.find('#modal-user-add-dialog');
		var $addForm = $addDialog.find('form');
		$k.util.bsValidator($addForm, {
			fields: {
				username: {
					validators: {
						regexp: {
							regexp: /^[a-zA-Z0-9_\.]+$/,
	     	                message: '用户名只能包含英文、数字、下划线等字符'
						}
					}
				},
				password: {
	                 validators: {
	                     identical: {
	                         field: 'confirmPassword',
	                         message: '两次输入密码不一致'
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
	                    	field: 'password',
	                        message: '两次输入密码不一致'
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
		$addDialog.on('click', '.btn-confirm', function() {
			var validator = $addForm.data('bootstrapValidator');
			validator.validate();
			
			if (validator.isValid()) {
				var formData = new FormData($addForm[0]);
				$.ajax({
					url: '${ctx}/api/user/create',
					type: 'post',
					data: formData,
					processData: false,
					contentType: false,
					cache: false,
					success: function(ret) {
						if (ret.code == 0) {
							$addDialog.modal('hide');
							toastr['success'](ret.msg);
							initTable(roleId);
						} else {
							toastr['error'](ret.msg);
						}
					},
					error: function(err) {}
				});
			}
		});
		
		// 用户编辑对话框
		var $editDialog = $page.find('#modal-user-edit-dialog');
		var $editForm = $editDialog.find('form');
		$k.util.bsValidator($editForm);
		$editDialog.on('click', '.btn-confirm', function() {
			var validator = $editForm.data('bootstrapValidator');
			validator.validate();
			
			if (validator.isValid()) {
				var formData = new FormData($editForm[0]);
				var userId = $editDialog.data('userId');
				formData.append('userId', userId);
				$.ajax({
					url: '${ctx}/api/user/update',
					type: 'post',
					data: formData,
					processData: false,
					contentType: false,
					cache: false,
					success: function(ret) {
						if (ret.code == 0) {
							$editDialog.modal('hide');
							toastr['success'](ret.msg);
							initTable(roleId);
						} else {
							toastr['error'](ret.msg);
						}
					},
					error: function(err) {}
				});
			}
		});
		
		// 用户修改密码对话框
		var $passwordDialog = $page.find('#modal-user-password-dialog');
		var $passwordForm = $passwordDialog.find('form');
		$k.util.bsValidator($passwordForm, {
			fields: {
				password: {
	                 validators: {
	                     identical: {
	                         field: 'confirmPassword',
	                         message: '两次输入密码不一致'
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
	                    	field: 'password',
	                        message: '两次输入密码不一致'
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
		$passwordDialog.on('click', '.btn-confirm', function() {
			var validator = $passwordForm.data('bootstrapValidator');
			validator.validate();
			if (validator.isValid()) {
				var userId = $passwordDialog.data('userId');
				$.ajax({
					url: '${ctx}/api/user/password2',
					type: 'post',
					data: {
						userId: userId,
						password: $passwordForm.find('input[name="password"]').val()
					},
					success: function(ret) {
						if (ret.code == 0) {
							$passwordDialog.modal('hide');
							toastr['success'](ret.msg);
							initTable(roleId);
						} else {
							toastr['error'](ret.msg);
						}
					},
					error: function(err) {}
				});
			}
		});
		
		$page
		.on('click', '.list-group-item', function(e) {
			e.stopPropagation();
			roleId = $(this).data('id');
			if (roleId > -1) {
				$page.find('.list-group-item').removeClass('active');
				$(this).addClass('active');
				initTable(roleId);
			}
		})
		// role
		.on('hidden.bs.modal', '#modal-role-dialog', function() {
            $roleForm.bootstrapValidator('resetForm', true);
            $(this).removeData('bs.modal');
        }) 
		.on('click', '.btn-role-add', function() {
			$roleDialog.find('.modal-title').text('添加角色');
			$roleDialog.data('method', 'add');
			$roleDialog.modal('show');
		})
		.on('click', '.btn-role-edit', function(e) {
			e.stopPropagation();
			var roleId = $(this).closest('.list-group-item').data('id');
			var roleName = $(this).closest('.list-group-item').find('.item-text').text();
			$roleDialog.find('.modal-title').text('编辑分组');
			$roleForm.find('input[name="name"]').val(roleName);
			$roleDialog.data('method', 'edit');
			$roleDialog.data('roleId', roleId);
			$roleDialog.modal('show');
		})
		.on('click', '.btn-role-delete', function(e) {
			e.stopPropagation();
			var roleId = $(this).closest('.list-group-item').data('id');
			swal({
				title: '您确定要删除所选择的角色吗?',
				type: 'warning',
				showCancelButton: true
			}, function() {
				$.ajax({
					url: '${ctx}/api/role/delete',
					data: {
						roleId: roleId
					},
					success: function(ret) {
						if (ret.code == 0) {
							toastr['success'](ret.msg);
							$aside.find('.list-group-item[data-id="' + roleId + '"]').remove();
						} else {
							toastr['error'](ret.msg);
						}
					},
					error: function(err) {}
				});
			});
		})
		// user
		.on('hidden.bs.modal', '#modal-user-add-dialog', function() {
            $addForm.bootstrapValidator('resetForm', true);
            $(this).removeData('bs.modal');
        }) 
        .on('hidden.bs.modal', '#modal-user-edit-dialog', function() {
            $editForm.bootstrapValidator('resetForm', true);
            $(this).removeData('bs.modal');
        }) 
		.on('click', '.btn-user-add', function() {
			$addDialog.modal('show');
			// 实时更新角色列表
			$.ajax({
				url: '${ctx}/api/role/list',
				success: function(ret) {
					if (ret.code == 0) {
						var $select = $addDialog.find('select[name="roleId"]');
						$select.empty();
						$.each(ret.data, function(k, val) {
							var $option = '<option value="' + val.id + '">' + val.name + '</option>';
							$select .append($option);
						});
						// 根据选中的角色初始化添加用户的角色
						if (roleId != 0) {
							$select.val(roleId);
						}
					}
				},
				error: function(err) {}
			});
		})
		.on('click', '.btn-user-delete-batch', function() {
			swal({
                title: '您确定要删除所选择的用户吗?',
                type: 'warning',
                showCancelButton: true,
            }, function() {
                var rows = $table.bootstrapTable('getSelections');
                $.ajax({
                    url: '${ctx}/api/user/batchDelete',
                    type: 'post',
                    data: { 
                    	userIdList: $k.util.getIdList(rows) 
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
		
	})( jQuery );
	</script>
	
</body>
</html>