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
	<link rel="stylesheet" type="text/css" href="${ctx}/local/common.css">
	
	<style type="text/css">
	.page-aside {
		position: absolute;
		top: 0;
		bottom: 0;
		left: 0;
		width: 220px;
		overflow-y: hidden;
		background-color: #fff;
		border-right: 1px solid #e4eaec;
		-webkit-transition: visibility .1s ease,top .3s ease,left .5s ease;
		transition: visibility .1s ease,top .3s ease,left .5s ease;
	}
	.page-aside-section {
		position: relative;
	}
	.page-aside-section:after {
		position: relative;
		display: block;
		margin: 11px;
		content: "";
		border-bottom: 1px solid #e7e7eb;
	}
	.page-aside-section:first-child {
		padding-top: 11px;
	}
	.page-aside-section:last-child:after {
		display: none;
	}
	.page-aside .list-group-item {
		padding: 13px 20px;
		margin-bottom: 1px;
		overflow: hidden;
		text-overflow: ellipsis;
		white-space: nowrap;
		border: none;
		border-radius: 0;
	}
	.page-aside .list-group-item .item-right {
		float: right;
	}
	.page-aside .list-group-item:FOCUS,
	.page-aside .list-group-item:HOVER {
		color: #459ae9;
		background-color: #f5f5f5;
	}
	.page-aside .list-group-item.active,
	.page-aside .list-group-item.active:focus, 
	.page-aside .list-group-item.active:hover {
		color: #459ae9;
		background-color: #f5f5f5;
	}
	.page-aside .list-group.has-actions .list-group-item {
		padding-top: 6px;
		padding-bottom: 6px;
		line-height: 32px;
		cursor: pointer;
	}
	.page-aside .list-group.has-actions .list-group-item:HOVER {
		color: #459ae9;
		background-color: #f5f5f5;
	}
	.page-aside .list-group.has-actions .list-group-item:HOVER .item-actions {
		display: block;
		color: #676a6c;
	}
	.page-aside .list-group.has-actions .list-group-item:HOVER .item-right {
		display: none;
	}
	.page-aside-title {
		padding: 10px 20px;
		overflow: hidden;
		font-weight: 400;
		color: #526069;
		text-overflow: ellipsis;
		white-space: nowrap;
		cursor: default;
	}
	.page-aside .list-group.has-actions .list-group-item .item-actions {
		position: absolute;
		top: 6px;
		right: 15px;
		display: none;
	}
	.btn-pure, .btn-pure.active, .btn-pure:active, .btn-pure:focus, .btn-pure[disabled], 
	.open>.dropdown-toggle.btn-pure, fieldset[disabled] .btn-pure {
		background-color: transparent;
		border-color: transparent;
		-webkit-box-shadow: none;
		box-shadow: none;
	}
	.btn-pure:hover {
		color: #459ae9;
	}
	.page-aside .btn-pure {
		padding-left: 2px;
		padding-right: 2px;
		background-color: transparent;
	}
	.page-main {
		height: 100%;
		margin-left: 220px;
		overflow-y: auto;
	}
	</style>
	
</head>

<body class="gray-bg body-group-list">
	<div class="wrapper wrapper-content animated fadeInRight height-full">
		<div class="ibox float-e-margins height-full">
			<div class="height-full" style="position: relative;">
				<div class="page-aside">
					<div class="page-aside-inner height-full">
						<div class="page-aside-section">
							<div class="list-group">
								<a class="list-group-item active" href="javascript:;" data-id="0">
									<span class="item-right group-student-total">${total}</span>
									<i class="fa fa-tag fa-fw"></i>所有分组
								</a>
							</div>
						</div>
						
						<div class="page-aside-section">
							<h4 class="page-aside-title">分组</h4>
							<div class="list-group has-actions">
								<c:forEach var="group" items="${groupList}">
									<div class="list-group-item" data-id="${group.id}">
										<div class="list-content">
											<span class="item-right">${group.count}</span>
											<span class="item-text">${group.name}</span>
											<div class="item-actions">
												<span class="btn btn-pure btn-group-edit"><i class="fa fa-edit"></i></span>
												<span class="btn btn-pure btn-group-delete"><i class="fa fa-remove"></i></span>
											</div>
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
				
				<div class="page-main ibox-content">
					<div class="page-title">
						<h2>考生列表</h2>
					</div>
					
					<div id="student-list-table-toolbar" role="group">
						<button type="button" class="btn btn-primary btn-student-add" data-toggle="modal" data-target="#modal-student-dialog">
	 						<i class="fa fa-plus fa-fw"></i>新增考生
	 					</button>
	 					<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#modal-student-import-dialog">
	 						<i class="fa fa-upload fa-fw"></i>导入考生
	 					</button>
	 					<button type="button" class="btn btn-white btn-student-delete-batch" disabled='disabled'>
	 						<i class="fa fa-trash-o fa-fw"></i>批量删除
	 					</button>
	 					<button type="button" class="btn btn-white btn-student-move" disabled="disabled">
	 						 移动到分组
	 					</button>
					</div>
					<table id="student-list-table" class="table-hm" data-mobile-responsive="true"></table>
				</div>
			</div>
		</div>
	</div>
	
	<div class="modal" id="modal-student-import-dialog" tabindex="-1" role="dialog" aria-hidden="true" data-backdrop="static">
    	<div class="modal-dialog">
    		<div class="modal-content animated fadeInDown">
    			<div class="modal-header">
    				<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                    <h3 class="modal-title">导入考生</h3>
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
                    <button type="button" class="btn btn-primary btn-fw" data-dismiss="modal">关&nbsp;闭</button>
                </div>
    		</div>
    	</div>
    </div>
    
    <div class="modal" id="modal-student-move-dialog" tabindex="-1" role="dialog" aria-hidden="true" data-backdrop="static">
        <div class="modal-dialog">
        	<div class="modal-content animated fadeInDown">
        		<div class="modal-header">
        			<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                    <h3 class="modal-title">请选择分组</h3>
                </div>
                <div class="modal-body" style="max-height: 400px; overflow: auto;">
                	<div class="alert alert-success alert-student-move hide">
                		 请先选择一项
                	</div>
                	<ul class="unstyled">
                		<c:forEach var="group" items="${groupList}">
                			<li style="height: 30px;">
                				<div class="radio radio-success radio-inline">
                					<input type="radio" name="group" id="${group.id}" value="${group.id}">
                					<label for="${group.id}">${group.name}</label>
                				</div>
                			</li>
                		</c:forEach>
                	</ul>
                </div>
               	<div class="modal-footer">
               		<button type="button" class="btn btn-white btn-fw" data-dismiss="modal">关&nbsp;闭</button>
                    <button type="button" class="btn btn-primary btn-fw btn-student-move-confirm">确&nbsp;定</button>
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
	
	<script type="text/javascript">
		
		var $page = $('.body-group-list');
		var $importDialog = $page.find('#modal-student-import-dialog');
		var $moveDialog = $page.find('#modal-student-move-dialog');
		
		var $table;
		var groupId = 0;
		
		initTable(0);
		
		function refreshGroup() {
			$.ajax({
				url: '${ctx}/api/group/list',
				success: function(ret) {
					if (ret.code == 0) {
						$page.find('.group-student-total').text(ret.msg);
					}
				},
				error: function(err) {}
			});
		}
		
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
					width: '80',
					formatter: function(value, row, index) {
						var $start = '<div class="dropdown"><a data-toggle="dropdown" aria-expanded="true">操作<span class="caret"></span></a><ul class="dropdown-menu">';
						var $edit = '<li><a class="btn-student-edit"><i class="fa fa-edit fa-fw"></i>编辑</a></li>';
						var $delete = '<li><a class="btn-student-delete"><i class="fa fa-trash-o fa-fw"></i>删除</a></li>';
						var $end = '</ul></div>';
						return $start + $edit + $delete + $end;
					},
					events: window.operateEvents = {
						'click .btn-student-edit': function(e, value, row, index) {
							e.stopPropagation();
							$dialog.find('.modal-title strong').text('编辑考生');
	            			$.each(row, function(key, val) {
	            				$form.find('input[name="' + key + '"]').val(val);
	            			});
	            			$dialog.data('method', 'edit');
	            			$dialog.data('studentId', row.id);
	            			$dialog.modal('show');
						},
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
	            					url: '${ctx}/api/student/delete',
	            					data: {
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
	            selNum > 0 ? $page.find('.btn-student-delete-batch').removeAttr('disabled') : $page.find('.btn-student-delete-batch').attr('disabled', 'disabled');
	            selNum > 0 ? $page.find('.btn-student-move').removeAttr('disabled') : $page.find('.btn-student-move').attr('disabled', 'disabled');
	        });
		}
		
		$page
		.on('click', '.list-group-item', function(e) {
			e.stopPropagation();
			var groupId = $(this).data('id');
			if (groupId > -1) {
				$page.find('.list-group-item').removeClass('active');
				$(this).addClass('active');
				initTable(groupId);
			}
		})
		.on('click', '.btn-group-edit', function(e) {
			e.stopPropagation();
			alert('edit');
		})
		.on('click', '.btn-group-delete', function(e) {
			e.stopPropagation();
			alert('delete');
		})
		.on('click', '.btn-group-add', function() {
			alert('add group');
		})
		.on('click', '.btn-student-add', function() {
			window.location.href = '${ctx}/studentAdd?method=add';
		})
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
                    url: '${ctx}/api/student/batchDelete',
                    type: 'post',
                    data: { 
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
		})
		.on('click', '.btn-student-move', function() {
			$moveDialog.find('.alert-student-move').addClass('hide');
			$moveDialog.find('input[name="group"]').removeAttr('checked');
			$moveDialog.modal('show');
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
                    $moveDialog.modal('hide');
                    if (ret.code == 0) {
                    	swal('', '移动成功!', 'success');
                    } else {
                    	swal('', ret.msg, 'error');
                    }
                    $table.bootstrapTable('refresh');
                },
                error: function(err) {}
			});
		});
		
		
	</script>
	
</body>
</html>