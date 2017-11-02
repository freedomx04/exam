<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/include/preload.jsp"%>

<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	
	<title>题库管理</title>
	
	<link rel="stylesheet" type="text/css" href="${ctx}/plugins/bootstrap/3.3.6/css/bootstrap.min.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/plugins/font-awesome/4.7.0/css/font-awesome.min.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/plugins/animate/animate.min.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/plugins/bootstrap-table/bootstrap-table.min.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/plugins/sweetalert/sweetalert.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/plugins/bootstrapValidator/css/bootstrapValidator.min.css">
	
	<link rel="stylesheet" type="text/css" href="${ctx}/plugins/hplus/style.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/local/common.css">
	
</head>

<body class="gray-bg body-library-list">
	<div class="wrapper wrapper-content animated fadeInRight">
		<div class="ibox float-e-margins">
			<div class="ibox-content">
				<div class="page-title">
					<h2>题库管理</h2>
				</div>
				
				<div id="library-list-table-toolbar" role="group">
 					<button type="button" class="btn btn-primary btn-library-add" data-toggle="modal" data-target="#modal-library-dialog">
 						<i class="fa fa-plus fa-fw"></i>新增题库
 					</button>
 					<button type="button" class="btn btn-white btn-library-delete-batch" disabled="disabled">
 						<i class="fa fa-trash-o fa-fw"></i>批量删除
 					</button>
 				</div>
 				<table id="library-list-table" class="table-hm" data-mobile-responsive="true"></table>
			</div>
		</div>
	</div>
	
	<div class="modal" id="modal-library-dialog" tabindex="-1" role="dialog" aria-hidden="true" data-backdrop="static">
        <div class="modal-dialog">
            <div class="modal-content animated fadeInDown">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                    <h4 class="modal-title"><strong></strong></h4>
                </div>
                <div class="modal-body">
                    <form class="form-horizontal" role="form" id="form-area" autocomplete="off">
                        <div class="form-group">
                            <label for="name" class="col-sm-3 control-label"><i class="form-required">*</i>题库名称</label>
                            <div class="col-sm-7">
                                <input type="text" class="form-control" name="name" required>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-white btn-fw" data-dismiss="modal">关&nbsp;闭</button>
                    <button type="button" class="btn btn-primary btn-fw btn-confirm">确&nbsp;定</button>
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
		
		var $page = $('.body-library-list');
		var $dialog = $page.find('#modal-library-dialog');
		var $form = $dialog.find('form');
		
		$k.util.bsValidator($form);
		
		var $table = $k.util.bsTable($page.find('#library-list-table'), {
			url: '${ctx}/api/library/list',
			toolbar: '#library-list-table-toolbar',
			idField: 'id',
			responseHandler: function(res) {
				return res.data;
			},
			columns: [{
				field: 'state',
				checkbox: true,
				formatter: function(value, row, index) {
					if (row.editable == 1) {
						return {
							disabled: true,
						};
					}
				} 
			}, {
				title: '#',
				width: '20',
				formatter: function(value, row, index) {
					return index + 1;
				}
			}, {
				field: 'name',
				title: '题库名称',
				formatter: function(value, row, index) {
					return '<a class="btn-library-detail">' + value + '</a>';
				},
				events: window.operateEvents = {
					'click .btn-library-detail': function(e, value, row, index) {
						e.stopPropagation();
					}
				} 
			}, {
				field: 'count',
				title: '试题',
				align: 'center',
				width: '100'
			}, {
				title: '操作',
				align: 'center',
				width: '80',
				formatter: function(value, row, index) {
					if (row.editable == 0) {
						var $start = '<div class="dropdown"><a data-toggle="dropdown" aria-expanded="true">操作<span class="caret"></span></a><ul class="dropdown-menu">';
						var $edit = '<li><a class="btn-library-edit"><i class="fa fa-edit fa-fw"></i>编辑</a></li>';
						var $delete = '<li><a class="btn-library-delete"><i class="fa fa-trash-o fa-fw"></i>删除</a></li>';
						var $end = '</ul></div>';
						return $start + $edit + $delete + $end;
					} 
				},
				events: window.operateEvents = {
					'click .btn-library-edit': function(e, value, row, index) {
						e.stopPropagation();
						$dialog.find('.modal-title strong').text('编辑题库');
            			$.each(row, function(key, val) {
            				$form.find('input[name="' + key + '"]').val(val);
            			});
            			$dialog.data('method', 'edit');
            			$dialog.data('libraryId', row.id);
            			$dialog.modal('show');
					},
					'click .btn-library-delete': function(e, value, row, index) {
						e.stopPropagation();
						var text = '您确定要删除所选择的题库吗?';
						if (row.count > 0) {
							text = '选择的题库将被删除，题库中包含的试题将会移动至系统默认题库。您确定要删除所选择的题库吗?';
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
            					url: '${ctx}/api/library/delete',
            					data: {
            						libraryId: row.id
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
            selNum > 0 ? $page.find('.btn-library-delete-batch').removeAttr('disabled') : $page.find('.btn-library-delete-batch').attr('disabled', 'disabled');
        });
		
		$dialog.on('click', '.btn-confirm', function() {
			var validator = $form.data('bootstrapValidator');
			validator.validate();
			
            if (validator.isValid()) {
            	var method = $dialog.data('method');
            	if (method == 'add') {
            		$.ajax({
 						url: '${ctx}/api/library/create',
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
                		url: '${ctx}/api/library/update',
                		type: 'POST',
                		data: {
                			libraryId: $dialog.data('libraryId'),
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
		.on('hidden.bs.modal', '#modal-library-dialog', function() {
            $form.bootstrapValidator('resetForm', true);
            $(this).removeData('bs.modal');
        }) 
		.on('click', '.btn-library-add', function() {
			$dialog.find('.modal-title strong').text('新增题库');
			$dialog.data('method', 'add');
		})
		.on('click', '.btn-library-delete-batch', function() {
			var rows = $table.bootstrapTable('getSelections');
			
			var count = 0;
            $.each(rows, function(k, row) {
            	count += row.count;
            });
            var text = count > 0 ? '选择的题库将被删除，题库中包含的试题将会移动至系统默认题库。您确定要删除所选择的题库吗?' : '您确定要删除所选择的题库吗?';
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
                    url: '${ctx}/api/library/batchDelete',
                    type: 'post',
                    data: { 
                    	libraryIdList: $k.util.getIdList(rows) 
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