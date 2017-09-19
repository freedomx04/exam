<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/include/preload.jsp"%>

<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	
	<title>考生列表</title>
	
	<link rel="stylesheet" type="text/css" href="${ctx}/plugins/bootstrap/3.3.6/css/bootstrap.min.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/plugins/font-awesome/4.7.0/css/font-awesome.min.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/plugins/animate/animate.min.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/plugins/bootstrap-table/bootstrap-table.min.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/plugins/sweetalert/sweetalert.css">
	
	<link rel="stylesheet" type="text/css" href="${ctx}/plugins/hplus/style.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/local/common.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/plugins/toastr/toastr.min.css">
	
</head>

<body class="gray-bg body-student-list">
	<div class="wrapper wrapper-content animated fadeInRight">
		<div class="ibox float-e-margins">
			<div class="ibox-content">
				<h2 class="page-title">考生列表</h2>
				
				<div id="student-list-table-toolbar" class="row" role="student">
					<div class="col-sm-6">
						<button type="button" class="btn btn-primary btn-student-add" data-toggle="modal" data-target="#modal-student-dialog">
	 						<i class="fa fa-plus fa-fw"></i>新增考生
	 					</button>
	 					<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#modal-student-import-dialog">
	 						<i class="fa fa-upload fa-fw"></i>导入考生
	 					</button>
	 					<button type="button" class="btn btn-white btn-student-delete-batch" disabled='disabled'>
	 						<i class="fa fa-trash-o fa-fw"></i>批量删除
	 					</button>
	 					<button type="button" class="btn btn-white btn-student-refresh">
	 						<i class="fa fa-refresh fa-fw"></i>刷新
	 					</button>
					</div>
 					
 					<div class="col-sm-6 text-right">
 						<select class="form-control" id="student-group" style="width: 200px; display: inline-block;">
 							<option value="0">所有分组</option>
 							<c:forEach var="group" items="${groupList}">
 								<option value="${group.id}">${group.name}</option>
 							</c:forEach>
 						</select>
 					</div>
 				</div>
 				<table id="student-list-table" class="table-hm" data-mobile-responsive="true"></table>
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
                    <button type="button" class="btn btn-primary" data-dismiss="modal" style="width: 100px;">关闭</button>
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
	<script type="text/javascript" src="${ctx}/plugins/toastr/toastr.min.js"></script>
	
	<script type="text/javascript">
		
		var $page = $('.body-student-list');
		var $importDialog = $page.find('#modal-student-import-dialog');
		
		var $table;
		var groupId = 0;
		
		initTable(0);
		
		function initTable(groupId) {
			$page.find('#student-list-table').bootstrapTable('destroy'); 
			
			$table = $k.util.bsTable($page.find('#student-list-table'), {
				url: '${ctx}/api/student/list?groupId=' + groupId,
				idField: 'id',
				responseHandler: function(res) {
					return res.data;
				},
				columns: [{
					field: 'state',
					checkbox: true
				}, {
					field: 'username',
					title: '考号',
					align: 'center'
				}, {
					field: 'name',
					title: '姓名',
					align: 'center'
				}, {
					field: 'group',
					title: '分组',
					align: 'center',
					formatter: function(value, row, index) {
						return value.name;
					}
				}, {
					title: '操作',
					align: 'center',
					width: '100',
					formatter: function(value, row, index) {
						if (row.editable == 0) {
							var $edit = '<a class="btn-student-edit a-operate">编辑</a>';
							var $delete = '<a class="btn-student-delete a-operate">删除</a>';
							return $edit + $delete;
						} 
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
	        });
		}
		
		$page
		.on('change', '#student-group', function() {
			groupId = $(this).val();
			initTable(groupId);
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
		.on('click', '.btn-student-refresh', function() {
			$table.bootstrapTable('refresh');
		});
		
	</script>
	
</body>
</html>