<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/include/preload.jsp"%>

<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	
	<title>试卷分类</title>
	
	<link rel="stylesheet" type="text/css" href="${ctx}/plugins/bootstrap/3.3.6/css/bootstrap.min.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/plugins/font-awesome/4.7.0/css/font-awesome.min.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/plugins/animate/animate.min.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/plugins/bootstrap-table/bootstrap-table.min.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/plugins/sweetalert/sweetalert.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/plugins/bootstrapValidator/css/bootstrapValidator.min.css">
	
	<link rel="stylesheet" type="text/css" href="${ctx}/plugins/hplus/style.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/local/common.css">
	
</head>

<body class="gray-bg body-classify-list">
	<div class="wrapper wrapper-content animated fadeInRight">
		<div class="ibox float-e-margins">
			<div class="ibox-content">
				<h2 class="page-title">试卷分类</h2>
				
				<div id="classify-list-table-toolbar" role="group">
 					<button type="button" class="btn btn-primary btn-classify-add" data-toggle="modal" data-target="#modal-classify-dialog">
 						<i class="fa fa-plus fa-fw"></i>新增分类
 					</button>
 				</div>
 				<table id="classify-list-table" class="table-hm" data-mobile-responsive="true"></table>
			</div>
		</div>
	</div>
	
	<div class="modal" id="modal-classify-dialog" tabindex="-1" role="dialog" aria-hidden="true" data-backdrop="static">
        <div class="modal-dialog">
            <div class="modal-content animated fadeInDown">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                    <h4 class="modal-title"><strong></strong></h4>
                </div>
                <div class="modal-body">
                    <form class="form-horizontal" role="form" id="form-area" autocomplete="off">
                        <div class="form-group">
                            <label for="name" class="col-sm-3 control-label"><i class="form-required">*</i>分类名称</label>
                            <div class="col-sm-7">
                                <input type="text" class="form-control" name="name" required>
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
		
		var $page = $('.body-classify-list');
		var $dialog = $page.find('#modal-classify-dialog');
		var $form = $dialog.find('form');
		
		$k.util.bsValidator($form);
		
		var $table = $k.util.bsTable($page.find('#classify-list-table'), {
			url: '${ctx}/api/classify/list',
			toolbar: '#classify-list-table-toolbar',
			idField: 'id',
			responseHandler: function(res) {
				return res.data;
			},
			columns: [{
				field: 'state',
				checkbox: true
			}, {
				field: 'name',
				title: '试卷分类',
			}, {
				field: 'count',
				title: '试卷',
				align: 'center',
				width: '100'
			}, {
				title: '操作',
				align: 'center',
				width: '100',
				formatter: function(value, row, index) {
					if (row.editable == 0) {
						var $edit = '<a class="btn-classify-edit a-operate">编辑</a>';
						var $delete = '<a class="btn-classify-delete a-operate">删除</a>';
						return $edit + $delete;
					} 
				},
				events: window.operateEvents = {
					'click .btn-classify-edit': function(e, value, row, index) {
						e.stopPropagation();
						$dialog.find('.modal-title strong').text('编辑分类');
            			$.each(row, function(key, val) {
            				$form.find('input[name="' + key + '"]').val(val);
            			});
            			$dialog.data('method', 'edit');
            			$dialog.data('classifyId', row.id);
            			$dialog.modal('show');
					},
					'click .btn-classify-delete': function(e, value, row, index) {
						e.stopPropagation();
						var text = '您确定要删除所选择的分类吗?';
						if (row.count > 0) {
							text = '选择的分类将被删除，分类中包含的试卷将会移动至系统默认分类。您确定要删除所选择的分类吗?';
						}
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
            					url: '${ctx}/api/classify/delete',
            					data: {
            						classifyId: row.id
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
		
		$dialog.on('click', '.btn-confirm', function() {
			var validator = $form.data('bootstrapValidator');
			validator.validate();
			
            if (validator.isValid()) {
            	var method = $dialog.data('method');
            	if (method == 'add') {
            		$.ajax({
 						url: '${ctx}/api/classify/create',
                 		type: 'POST',
                 		data: {
                 			name: $dialog.find('input[name = "name"]').val(),
                 		},
                 		success: function(ret) {
                 			if (ret.code == 0) {
	               				$dialog.modal('hide');
	                   			swal('', '添加成功!', 'success');
	                   			$table.bootstrapTable('refresh'); 
	               			} else {
	               				swal('', ret.msg, 'error');
	               			}
                 		},
                 		error: function(err) {}
                 	});
            	} else {
            		$.ajax({
                		url: '${ctx}/api/classify/update',
                		type: 'POST',
                		data: {
                			classifyId: $dialog.data('classifyId'),
                			name: $dialog.find('input[name="name"]').val(),
                		},
                		success: function(ret) {
                			if (ret.code == 0) {
                				$dialog.modal('hide');
                                swal('', '编辑成功!', 'success');
                                $table.bootstrapTable('refresh');
                			} else {
                				swal('', ret.msg, 'error');
                			}
                		},
                		error: function(err) {}
                	});
            	}
            }
		});
	
		$page
		.on('hidden.bs.modal', '#modal-classify-dialog', function() {
            $form.bootstrapValidator('resetForm', true);
            $(this).removeData('bs.modal');
        }) 
		.on('click', '.btn-classify-add', function() {
			$dialog.find('.modal-title strong').text('新增分类');
			$dialog.data('method', 'add');
		});
		
	</script>
	
</body>
</html>