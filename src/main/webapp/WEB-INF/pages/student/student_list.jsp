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
	<link rel="stylesheet" type="text/css" href="${ctx}/plugins/awesome-bootstrap-checkbox/awesome-bootstrap-checkbox.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/plugins/animate/animate.min.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/plugins/bootstrap-table/bootstrap-table.min.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/plugins/sweetalert/sweetalert.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/plugins/bootstrapValidator/css/bootstrapValidator.min.css">
	
	<link rel="stylesheet" type="text/css" href="${ctx}/plugins/hplus/style.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/plugins/web-icons/css/web-icons.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/plugins/toastr/toastr.min.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/local/common.css">
	
</head>

<body class="gray-bg body-student-list">
	<div class="animated fadeInRight height-full">
		<div class="ibox float-e-margins height-full" style="margin-bottom: 0;">
			<div class="height-full" style="position: relative;">
				<div class="page-aside">
					<div class="page-aside-inner height-full">
						<div class="page-aside-section">
							<div class="list-group">
								<a class="list-group-item active" href="javascript:;" data-id="0">
									<%-- <span class="item-right group-student-total">${total}</span> --%>
									<i class="fa fa-user fa-fw"></i>所有考生
								</a>
							</div>
						</div>
						
						<div class="page-aside-section">
							<h4 class="page-aside-title"><i class="fa fa-bars fa-fw"></i>分组列表</h4>
							<div class="list-group has-actions">
								<c:forEach var="group" items="${groupList}">
									<div class="list-group-item" data-id="${group.id}">
										<div class="list-content">
											<%-- <span class="item-right">${group.count}</span> --%>
											<span class="item-text">${group.name}</span>
											<c:if test="${group.editable == 0}">
												<div class="item-actions">
													<span class="btn btn-pure btn-group-edit"><i class="wb-edit"></i></span>
													<span class="btn btn-pure btn-group-delete"><i class="wb-close"></i></span>
												</div>
											</c:if>
										</div>
									</div>
								</c:forEach>
							</div>
						</div>
						
						<div class="page-aside-section">
							<a class="list-group-item btn-group-add" href="javascript:;">
								<i class="fa fa-plus fa-fw"></i>添加新分组
							</a>
						</div>
					</div>
				</div>
				
				<div class="page-main">
					<div class="ibox-content">
						<div class="page-title">
							<h2>考生列表</h2>
						</div>
						<div id="student-list-table-toolbar" role="group">
							<button type="button" class="btn btn-primary btn-student-add" data-toggle="modal" data-target="#modal-student-dialog">
		 						<i class="fa fa-user-plus fa-fw"></i>新增考生
		 					</button>
		 					<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#modal-student-import-dialog">
		 						<i class="fa fa-upload fa-fw"></i>导入考生
		 					</button>
		 					<button type="button" class="btn btn-white btn-student-move" disabled="disabled">
		 						 移动到分组
		 					</button>
		 					<button type="button" class="btn btn-danger btn-student-delete-batch" disabled='disabled'>
		 						<i class="fa fa-trash-o fa-fw"></i>删除
		 					</button>
						</div>
						<table id="student-list-table" class="table-hm table-fixed" data-mobile-responsive="true"></table>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<div class="modal" id="modal-group-dialog" tabindex="-1" role="dialog" aria-hidden="true" data-backdrop="static">
        <div class="modal-dialog modal-center">
            <div class="modal-content animated fadeInDown">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                    <h4 class="modal-title"></h4>
                </div>
                <div class="modal-body">
                    <form class="form-horizontal" role="form" autocomplete="off">
                        <div class="form-group">
                            <label for="name" class="col-sm-3 control-label"><i class="form-required">*</i>分组名称</label>
                            <div class="col-sm-7">
                                <input type="text" class="form-control" name="name" required data-bv-notempty-message="分组名称不能为空">
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
    
    <div class="modal" id="modal-student-add-dialog" tabindex="-1" role="dialog" aria-hidden="true" data-backdrop="static">
    	<div class="modal-dialog modal-center">
            <div class="modal-content animated fadeInDown">
            	<div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                    <h4 class="modal-title">添加考生</h4>
                </div>
                <div class="modal-body">
                	<form class="form-horizontal" role="form" autocomplete="off">
                		<div class="form-group">
                			<label for="groupId" class="col-sm-3 control-label"><i class="form-required">*</i>分组</label>
                			<div class="col-sm-7">
                				<select class="form-control" name="groupId"></select>
                			</div>
                		</div>
                		
                		<div class="form-group">
							<label for="username" class="col-sm-3 control-label"><i class="form-required">*</i>考号</label>
	                        <div class="col-sm-7">
	                            <input type="text" class="form-control" name="username" placeholder="只能包含英文、数字、下划线等字符" required data-bv-notempty-message="考号不能为空">
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
    
    <div class="modal" id="modal-student-edit-dialog" tabindex="-1" role="dialog" aria-hidden="true" data-backdrop="static">
    	<div class="modal-dialog modal-center">
    		<div class="modal-content animated fadeInDown">
    			<div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                    <h4 class="modal-title">编辑考生</h4>
                </div>
                <div class="modal-body">
                	<form class="form-horizontal" role="form" autocomplete="off">
                		<div class="form-group">
                			<label for="groupId" class="col-sm-3 control-label"><i class="form-required">*</i>分组</label>
                			<div class="col-sm-7">
                				<select class="form-control" name="groupId"></select>
                			</div>
                		</div>
                		
                		<div class="form-group">
							<label for="username" class="col-sm-3 control-label">考号</label>
	                        <div class="col-sm-7">
	                            <input type="text" class="form-control" name="username" placeholder="只能包含英文、数字、下划线等字符" required data-bv-notempty-message="考号不能为空" disabled="disabled">
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
    
    <div class="modal" id="modal-student-password-dialog" tabindex="-1" role="dialog" aria-hidden="true" data-backdrop="static">
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
	
	<div class="modal" id="modal-student-import-dialog" tabindex="-1" role="dialog" aria-hidden="true" data-backdrop="static">
    	<div class="modal-dialog modal-center">
    		<div class="modal-content animated fadeInDown">
    			<div class="modal-header">
    				<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                    <h4 class="modal-title">导入考生</h4>
    			</div>
    			<div class="modal-body">
    				<div>
    					<h2 style="margin-top: 0;">1.请先下载模板</h2>
    					<ul>
    						<li>建议按多次分批导入，导入前建议考生编好分组，方便题库管理</li>
    						<li>请使用<strong>微软的Office编辑，不要使用WPS</strong></li>
    					</ul>
    					<button type="button" class="btn btn-blue btn-student-template">
	 						<i class="fa fa-download fa-fw"></i>下载EXCEL格式模板
	 					</button>
    				</div>
    				<div>
    					<h2>2.导入考生</h2>
    					<ul>
    						<li>考号是唯一的，如果导入的考生考号重复，则会覆盖该考生信息</li>
    						<li>分组，考号，密码和姓名为必填字段，密码至少6个字符</li>
    					</ul>
    					<input id="import-file-input" type="file" style="display:none">
    					<button type="button" class="btn btn-primary btn-student-import">
	 						<i class="fa fa-upload fa-fw"></i>选择文件并上传
	 					</button>
    				</div>
    			</div>
    			<div class="modal-footer">
                    <button type="button" class="btn btn-primary btn-fw" data-dismiss="modal">取消</button>
                </div>
    		</div>
    	</div>
    </div>
    
    <div class="modal" id="modal-student-move-dialog" tabindex="-1" role="dialog" aria-hidden="true" data-backdrop="static">
        <div class="modal-dialog modal-center">
        	<div class="modal-content animated fadeInDown">
        		<div class="modal-header">
        			<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                    <h4 class="modal-title">请选择分组</h4>
                </div>
                <div class="modal-body" style="max-height: 400px; overflow: auto;">
                	<div class="alert alert-success alert-student-move hide">
                		 请先选择一项
                	</div>
                	<ul class="unstyled"></ul>
                </div>
               	<div class="modal-footer">
               		<button type="button" class="btn btn-white btn-fw" data-dismiss="modal">取消</button>
                    <button type="button" class="btn btn-primary btn-fw btn-student-move-confirm">确定</button>
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
		
		var $page = $('.body-student-list');
		var $aside = $('.page-aside');
		
		var $importDialog = $page.find('#modal-student-import-dialog');
		var $moveDialog = $page.find('#modal-student-move-dialog');
		
		var $table;
		var groupId = 0;
		initTable(groupId);
		
		function initTable(groupId) {
			$page.find('#student-list-table').bootstrapTable('destroy'); 
			
			$table = $k.util.bsTable($page.find('#student-list-table'), {
				url: '${ctx}/api/student/list?groupId=' + groupId,
				toolbar: '#student-list-table-toolbar',
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
					field: 'username',
					title: '考号',
					/* formatter: function(value, row, index) {
						return '<a class="btn-student-detail">' + value + '</a>';
					},
					events: window.operateEvents = {
						'click .btn-student-detail': function(e, value, row, index) {
							e.stopPropagation();
						}
					} */
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
						var $edit = '<span class="btn-operate btn-student-edit" data-toggle="tooltip" title="编辑"><i class="wb-edit"></i></span>';
						var $password = '<span class="btn-operate btn-student-password" data-toggle="tooltip" title="修改密码"><i class="wb-lock"></i></span>';
						var $delete = '<span class="btn-operate btn-student-delete" data-toggle="tooltip" title="删除"><i class="wb-close"></i></span>';
						return $edit + $password + $delete; 
					},
					events: window.operateEvents = {
						'click .btn-student-edit': function(e, value, row, index) {
							e.stopPropagation();
	            			$.each(row, function(key, val) {
	            				$editForm.find('input[name="' + key + '"]').val(val);
	            			});
	            			$.ajax({
	            				url: '${ctx}/api/group/list',
	            				success: function(ret) {
	            					if (ret.code == 0) {
	            						var $select = $editDialog.find('select[name="groupId"]');
	            						$select.empty();
	            						$.each(ret.data, function(k, val) {
	            							var $option = '<option value="' + val.id + '">' + val.name + '</option>';
	            							$select.append($option);
	            						});
	            						$select.val(row.group.id);
	            					}
	            				},
	            				error: function(err) {}
	            			});
	            			$editDialog.data('studentId', row.id);
	            			$editDialog.modal('show');
						},
						'click .btn-student-password': function(e, value, row, index) {
							e.stopPropagation();
							$passwordDialog.data('studentId', row.id);
	            			$passwordDialog.modal('show');
						},
						'click .btn-student-delete': function(e, value, row, index) {
							e.stopPropagation();
							swal({
	            				title: '您确定要删除所选择的考生吗?',
	            				type: 'warning',
	            				showCancelButton: true,
	            			}, function() {
	            				$.ajax({
	            					url: '${ctx}/api/student/delete',
	            					data: {
	            						studentId: row.id
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
	            selNum > 0 ? $page.find('.btn-student-delete-batch').removeAttr('disabled') : $page.find('.btn-student-delete-batch').attr('disabled', 'disabled');
	            selNum > 0 ? $page.find('.btn-student-move').removeAttr('disabled') : $page.find('.btn-student-move').attr('disabled', 'disabled');
	        });
		}
		
		// 分组添加/编辑对话框
		var $groupDialog = $page.find('#modal-group-dialog');
		var $groupForm = $groupDialog.find('form');
		$k.util.bsValidator($groupForm);
		$groupDialog.on('click', '.btn-confirm', function() {
			var validator = $groupForm.data('bootstrapValidator');
			validator.validate();
			
            if (validator.isValid()) {
            	var method = $groupDialog.data('method');
            	var name = $groupDialog.find('input[name = "name"]').val();
            	if (method == 'add') {
            		$.ajax({
 						url: '${ctx}/api/group/create',
                 		type: 'POST',
                 		data: {
                 			name: name,
                 		},
                 		success: function(ret) {
                 			if (ret.code == 0) {
	               				$groupDialog.modal('hide');
	               				toastr['success'](ret.msg);
	               				
	               				// 添加新分组到最后
	               				var group = ret.data;
	               				var $item = '<div class="list-group-item" data-id="' + group.id + '">'
	               							+ 	'<div class="list-content">'
	               							+		'<span class="item-text">' + group.name + '</span>'
	               							+ 		'<div class="item-actions">'
	               							+			'<span class="btn btn-pure btn-group-edit"><i class="wb-edit"></i></span>'
	               							+			'<span class="btn btn-pure btn-group-delete"><i class="wb-close"></i></span>'
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
            		var groupId = $groupDialog.data('groupId');
            		$.ajax({
                		url: '${ctx}/api/group/update',
                		type: 'POST',
                		data: { 
                			groupId: groupId, 
                			name: name 
                		},
                		success: function(ret) {
                			if (ret.code == 0) {
                				$groupDialog.modal('hide');
	               				toastr['success'](ret.msg);
	               				$aside.find('.list-group-item[data-id="' + groupId + '"]').find('.item-text').text(name);
                			} else {
                				toastr['error'](ret.msg);
                			}
                		},
                		error: function(err) {}
                	});
            	}
            }
		});
		
		// 考生添加对话框
		var $addDialog = $page.find('#modal-student-add-dialog');
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
					url: '${ctx}/api/student/create',
					type: 'post',
					data: formData,
					processData: false,
					contentType: false,
					cache: false,
					success: function(ret) {
						if (ret.code == 0) {
							$addDialog.modal('hide');
							toastr['success'](ret.msg);
							initTable(groupId);
						} else {
							toastr['error'](ret.msg);
						}
					},
					error: function(err) {}
				});
			}
		});
		
		// 考生编辑对话框
		var $editDialog = $page.find('#modal-student-edit-dialog');
		var $editForm = $editDialog.find('form');
		$k.util.bsValidator($editForm);
		$editDialog.on('click', '.btn-confirm', function() {
			var validator = $editForm.data('bootstrapValidator');
			validator.validate();
			
			if (validator.isValid()) {
				var formData = new FormData($editForm[0]);
				var studentId = $editDialog.data('studentId');
				formData.append('studentId', studentId);
				$.ajax({
					url: '${ctx}/api/student/update',
					type: 'post',
					data: formData,
					processData: false,
					contentType: false,
					cache: false,
					success: function(ret) {
						if (ret.code == 0) {
							$editDialog.modal('hide');
							toastr['success'](ret.msg);
							initTable(groupId);
						} else {
							toastr['error'](ret.msg);
						}
					},
					error: function(err) {}
				});
			}
		});
		
		// 考生修改密码对话框
		var $passwordDialog = $page.find('#modal-student-password-dialog');
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
				var studentId = $passwordDialog.data('studentId');
				$.ajax({
					url: '${ctx}/api/student/password',
					type: 'post',
					data: {
						studentId: studentId,
						password: $passwordForm.find('input[name="password"]').val()
					},
					success: function(ret) {
						if (ret.code == 0) {
							$passwordDialog.modal('hide');
							toastr['success'](ret.msg);
							initTable(groupId);
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
			groupId = $(this).data('id');
			if (groupId > -1) {
				$page.find('.list-group-item').removeClass('active');
				$(this).addClass('active');
				initTable(groupId);
			}
		})
		// group
		.on('hidden.bs.modal', '#modal-group-dialog', function() {
            $groupForm.bootstrapValidator('resetForm', true);
            $(this).removeData('bs.modal');
        }) 
		.on('click', '.btn-group-add', function() {
			$groupDialog.find('.modal-title').text('添加分组');
			$groupDialog.data('method', 'add');
			$groupDialog.modal('show');
		})
		.on('click', '.btn-group-edit', function(e) {
			e.stopPropagation();
			var groupId = $(this).closest('.list-group-item').data('id');
			var groupName = $(this).closest('.list-group-item').find('.item-text').text();
			$groupDialog.find('.modal-title').text('编辑分组');
			$groupForm.find('input[name="name"]').val(groupName);
			$groupDialog.data('method', 'edit');
			$groupDialog.data('groupId', groupId);
			$groupDialog.modal('show');
		})
		.on('click', '.btn-group-delete', function(e) {
			e.stopPropagation();
			var groupId = $(this).closest('.list-group-item').data('id');
			swal({
				title: '您确定要删除所选择的分组吗?',
				text: '分组中包含的考生将会移动至默认分组',
				type: 'warning',
				showCancelButton: true
			}, function() {
				$.ajax({
					url: '${ctx}/api/group/delete',
					data: {
						groupId: groupId
					},
					success: function(ret) {
						if (ret.code == 0) {
							toastr['success'](ret.msg);
							$aside.find('.list-group-item[data-id="' + groupId + '"]').remove();
						} else {
							toastr['error'](ret.msg);
						}
					},
					error: function(err) {}
				});
			});
		})
		// student
		.on('hidden.bs.modal', '#modal-student-add-dialog', function() {
            $addForm.bootstrapValidator('resetForm', true);
            $(this).removeData('bs.modal');
        }) 
        .on('hidden.bs.modal', '#modal-student-edit-dialog', function() {
            $editForm.bootstrapValidator('resetForm', true);
            $(this).removeData('bs.modal');
        }) 
		.on('click', '.btn-student-add', function() {
			$addDialog.modal('show');
			// 实时更新分组列表
			$.ajax({
				url: '${ctx}/api/group/list',
				success: function(ret) {
					if (ret.code == 0) {
						var $select = $addDialog.find('select[name="groupId"]');
						$select.empty();
						$.each(ret.data, function(k, val) {
							var $option = '<option value="' + val.id + '">' + val.name + '</option>';
							$select.append($option);
						});
						// 根据选中的分组初始化添加考生的分组
						if (groupId != 0) {
							$select.val(groupId);
						}
					}
				},
				error: function(err) {}
			});
		})
		// 考生导入
		.on('click', '.btn-student-template', function() {
			window.location.href = '${ctx}/api/student/template';
		})
		.on('click', '.btn-student-import', function() {
			$page.find('#import-file-input').click();
		})
		.on('change', '#import-file-input', function() {
			$importDialog.modal('hide');
			
			var formData = new FormData();
			formData.append('file', this.files[0]);
			
			$.ajax({
				url: '${ctx}/api/student/import',
				type: 'post',
				data: formData,
                enctype : 'multipart/form-data',
                processData: false,
                contentType: false,
                cache: false,
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
		})
		.on('click', '.btn-student-delete-batch', function() {
			swal({
                title: '您确定要删除所选择的考生吗?',
                type: 'warning',
                showCancelButton: true,
            }, function() {
                var rows = $table.bootstrapTable('getSelections');
                $.ajax({
                    url: '${ctx}/api/student/batchDelete',
                    type: 'post',
                    data: { 
                    	studentIdList: $k.util.getIdList(rows) 
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
		})
		// 移动分组
		.on('click', '.btn-student-move', function() {
			$moveDialog.find('.alert-student-move').addClass('hide');
			$moveDialog.find('ul').empty();
			$moveDialog.modal('show');
			$.ajax({
				url: '${ctx}/api/group/list',
				success: function(ret) {
					if (ret.code == 0) {
						$.each(ret.data, function(k, val) {
							var $li = '<li style="height: 30px;">'
									+	'<div class="radio radio-success radio-inline">'
									+		'<input type="radio" name="group" id="' + val.id + '" value="' + val.id + '">'
									+ 		'<label for="'+ val.id + '">' + val.name + '</label>'
									+ 	'</div>'
									+'</li>';
							$moveDialog.find('ul').append($li);
						});
					}
				},
				error: function(err) {}
			});
		})
		.on('click', '.btn-student-move-confirm', function() {
			var groupId = $moveDialog.find('input[name="group"]:checked').val();
			if (!groupId) {
				$moveDialog.find('.alert-student-move').removeClass('hide');
				return
			}
			
			var rows = $table.bootstrapTable('getSelections');
			$.ajax({
				url: '${ctx}/api/student/move',
				type: 'post',
				data: {
					studentIdList: $k.util.getIdList(rows),
					groupId: groupId
				},
				success: function(ret) {
                    if (ret.code == 0) {
                    	$moveDialog.modal('hide');
                		toastr['success'](ret.msg);
                		$table.bootstrapTable('refresh'); 
                	} else {
                		toastr['error'](ret.msg);
                	}
                },
                error: function(err) {}
			});
		});
		
	})( jQuery );
	</script>
	
</body>
</html>