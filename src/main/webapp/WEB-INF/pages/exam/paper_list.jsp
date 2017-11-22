<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/include/preload.jsp"%>

<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	
	<title>试卷管理</title>
	
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
<body class="gray-bg body-paper-list">
	<div class="wrapper wrapper-content animated fadeInRight height-full">
		<div class="ibox float-e-margins height-full" style="margin-bottom: 0;">
			<div class="height-full" style="position: relative;">
				<div class="page-aside">
					<div class="page-aside-inner height-full">
						<div class="page-aside-section">
							<div class="list-group">
								<a class="list-group-item active" href="javascript:;" data-id="0">
									<%-- <span class="item-right group-student-total">${total}</span> --%>
									<i class="fa fa-clock-o fa-fw"></i>所有试卷
								</a>
							</div>
						</div>
						
						<div class="page-aside-section">
							<h4 class="page-aside-title"><i class="fa fa-bars fa-fw"></i>试卷分类列表</h4>
							<div class="list-group has-actions">
								<c:forEach var="classify" items="${classifyList}">
									<div class="list-group-item" data-id="${classify.id}">
										<div class="list-content">
											<%-- <span class="item-right">${group.count}</span> --%>
											<span class="item-text">${classify.name}</span>
											<c:if test="${classify.editable == 0}">
												<div class="item-actions">
													<span class="btn btn-pure btn-classify-edit"><i class="fa fa-edit"></i></span>
													<span class="btn btn-pure btn-classify-delete"><i class="fa fa-remove"></i></span>
												</div>
											</c:if>
										</div>
									</div>
								</c:forEach>
							</div>
						</div>
						
						<div class="page-aside-section">
							<a class="list-group-item btn-classify-add" href="javascript:;">
								<i class="fa fa-plus fa-fw"></i>添加新试卷分类
							</a>
						</div>
					</div>
				</div>
				
				<div class="page-main ibox-content">
					<div class="page-title">
						<h2>试卷列表</h2>
					</div>
					<div id="paper-list-table-toolbar" role="group">
						<button type="button" class="btn btn-primary btn-paper-add">
	 						<i class="fa fa-plus fa-fw"></i>新增试卷
	 					</button>
	 					<button type="button" class="btn btn-white btn-paper-move" disabled="disabled">
	 						 移动到分组
	 					</button>
	 					<button type="button" class="btn btn-danger btn-paper-delete-batch" disabled='disabled'>
	 						<i class="fa fa-trash-o fa-fw"></i>删除
	 					</button>
					</div>
					<table id="paper-list-table" class="table-hm table-fixed" data-mobile-responsive="true"></table>
				</div>
			</div>
		</div>
	</div>
	
	<div class="modal" id="modal-classify-dialog" tabindex="-1" role="dialog" aria-hidden="true" data-backdrop="static">
        <div class="modal-dialog modal-center">
            <div class="modal-content animated fadeInDown">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                    <h4 class="modal-title"></h4>
                </div>
                <div class="modal-body">
                    <form class="form-horizontal" role="form" autocomplete="off">
                        <div class="form-group">
                            <label for="name" class="col-sm-3 control-label"><i class="form-required">*</i>试卷分类名称</label>
                            <div class="col-sm-7">
                                <input type="text" class="form-control" name="name" required data-bv-notempty-message="试卷分类不能为空">
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
	
	<div class="modal" id="modal-paper-move-dialog" tabindex="-1" role="dialog" aria-hidden="true" data-backdrop="static">
        <div class="modal-dialog modal-center">
        	<div class="modal-content animated fadeInDown">
        		<div class="modal-header">
        			<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                    <h4 class="modal-title">请选择试卷分类</h4>
                </div>
                <div class="modal-body" style="max-height: 400px; overflow: auto;">
                	<div class="alert alert-success alert-paper-move hide">
                		 请先选择一项
                	</div>
                	<ul class="unstyled"></ul>
                </div>
               	<div class="modal-footer">
               		<button type="button" class="btn btn-white btn-fw" data-dismiss="modal">取消</button>
                    <button type="button" class="btn btn-primary btn-fw btn-paper-move-confirm">确定</button>
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
		
		var $page = $('.body-paper-list');
		var $aside = $('.page-aside');
		
		var $moveDialog = $page.find('#modal-paper-move-dialog');
		
		var $table;
		var classifyId = 0;
		initTable(classifyId);
		
		function initTable(classifyId) {
			$page.find('#paper-list-table').bootstrapTable('destroy');
			
			$table = $k.util.bsTable($page.find('#paper-list-table'), {
				url: '${ctx}/api/paper/list?classifyId=' + classifyId,
				toolbar: '#paper-list-table-toolbar',
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
					title: '试卷标题'
				}, {
					field: 'classify',
					title: '试卷分类',
					width: '200',
					formatter: function(value, row, index) {
						return value.name
					}
				}, {
					field: 'questions',
					title: '试题',
					align: 'center',
					width: '50',
					formatter: function(value, row, index) {
						return value.length;
					}
				}, {
					field: 'students',
					title: '考生',
					align: 'center',
					width: '50',
					formatter: function(value, row, index) {
						return value.length;
					}
				}, {
					field: 'feedbacks',
					title: '反馈',
					align: 'center',
					width: '50',
					formatter: function(value, row, index) {
						return '<a class="btn-paper-feedback">' + value.length + '</a>';
					},
					events: window.operateEvetns = {
						'click .btn-paper-feedback': function(e, value, row, index) {
							e.stopPropagation();
							window.location.href = '${ctx}/feedback?paperId=' + row.id;
						}
					}
				}, {
					field: 'updateTime',
					title: '修改时间',
					align: 'center',
					width: 150,
					formatter: formatDate2
				}, {
					field: 'status',
					title: '状态',
					align: 'center',
					width: '100',
					formatter: function(value, row, index) {
						if (value == 0) {
	            			return '<span class="label label-primary">可用</span>';
	            		} else {
	            			return '<span class="label label-warning">不可用</span>';
	            		}
					}
				}, {
					title: '操作',
					align: 'center',
					width: '80',
					formatter: function(value, row, index) {
						var $start = '<div class="dropdown"><a data-toggle="dropdown" aria-expanded="true">操作<span class="caret"></span></a><ul class="dropdown-menu">';
						var $edit = '<li><a class="btn-paper-edit"><i class="fa fa-edit fa-fw"></i>编辑</a></li>';
						var $delete = '<li><a class="btn-paper-delete"><i class="fa fa-trash-o fa-fw"></i>删除</a></li>';
						var $end = '</ul></div>';
						return $start + $edit + $delete + $end;
					},
					events: window.operateEvents = {
						'click .btn-paper-edit': function(e, value, row, index) {
							e.stopPropagation();
							window.location.href = '${ctx}/paperEdit?paperId=' + row.id;
						},
						'click .btn-paper-delete': function(e, value, row, index) {
							e.stopPropagation();
							swal({
	            				title: '您确定要删除所选择的试卷吗?',
	            				type: 'warning',
	            				showCancelButton: true,
	            			}, function() {
	            				$.ajax({
	            					url: '${ctx}/api/paper/delete',
	            					data: {
	            						paperId: row.id
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
		}
		$table.on('all.bs.table', function(e, row) {
            var selNum = $table.bootstrapTable('getSelections').length;
            selNum > 0 ? $page.find('.btn-paper-delete-batch').removeAttr('disabled') : $page.find('.btn-paper-delete-batch').attr('disabled', 'disabled');
            selNum > 0 ? $page.find('.btn-paper-move').removeAttr('disabled') : $page.find('.btn-paper-move').attr('disabled', 'disabled');
        });
		
		// 试卷分类添加/编辑对话框
		var $classifyDialog = $page.find('#modal-classify-dialog');
		var $classifyForm = $classifyDialog.find('form');
		$k.util.bsValidator($classifyForm);
		$classifyDialog.on('click', '.btn-confirm', function() {
			var validator = $classifyForm.data('bootstrapValidator');
			validator.validate();
			
            if (validator.isValid()) {
            	var method = $classifyDialog.data('method');
            	var name = $classifyDialog.find('input[name = "name"]').val();
            	if (method == 'add') {
            		$.ajax({
 						url: '${ctx}/api/classify/create',
                 		type: 'POST',
                 		data: {
                 			name: name,
                 		},
                 		success: function(ret) {
                 			if (ret.code == 0) {
	               				$classifyDialog.modal('hide');
	               				
	               				toastr['success'](ret.msg);
	               				
	               				// 添加新分类到最后
	               				var classify = ret.data;
	               				var $item = '<div class="list-group-item" data-id="' + classify.id + '">'
	               							+ 	'<div class="list-content">'
	               							+		'<span class="item-text">' + classify.name + '</span>'
	               							+ 		'<div class="item-actions">'
	               							+			'<span class="btn btn-pure btn-classify-edit"><i class="fa fa-edit"></i></span>'
	               							+			'<span class="btn btn-pure btn-classify-delete"><i class="fa fa-remove"></i></span>'
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
            		var classifyId = $classifyDialog.data('classifyId');
            		$.ajax({
                		url: '${ctx}/api/classify/update',
                		type: 'POST',
                		data: { 
                			classifyId: classifyId, 
                			name: name 
                		},
                		success: function(ret) {
                			if (ret.code == 0) {
                				$classifyDialog.modal('hide');
	               				toastr['success'](ret.msg);
	               				$aside.find('.list-group-item[data-id="' + classifyId + '"]').find('.item-text').text(name);
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
		.on('click', '.list-group-item', function(e) {
			e.stopPropagation();
			classifyId = $(this).data('id');
			if (classifyId > -1) {
				$page.find('.list-group-item').removeClass('active');
				$(this).addClass('active');
				initTable(classifyId);
			}
		})
		// classify
		.on('hidden.bs.modal', '#modal-classify-dialog', function() {
            $classifyForm.bootstrapValidator('resetForm', true);
            $(this).removeData('bs.modal');
        }) 
		.on('click', '.btn-classify-add', function() {
			$classifyDialog.find('.modal-title').text('添加试卷分类');
			$classifyDialog.data('method', 'add');
			$classifyDialog.modal('show');
		})
		.on('click', '.btn-classify-edit', function(e) {
			e.stopPropagation();
			var classifyId = $(this).closest('.list-group-item').data('id');
			var classifyName = $(this).closest('.list-group-item').find('.item-text').text();
			$classifyDialog.find('.modal-title').text('编辑试卷分类');
			$classifyForm.find('input[name="name"]').val(classifyName);
			$classifyDialog.data('method', 'edit');
			$classifyDialog.data('classifyId', classifyId);
			$classifyDialog.modal('show');
		})
		.on('click', '.btn-classify-delete', function(e) {
			e.stopPropagation();
			var classifyId = $(this).closest('.list-group-item').data('id');
			swal({
				title: '您确定要删除所选择的试卷分类吗?',
				text: '试卷分类中包含的试卷将会移动至默认试卷',
				type: 'warning',
				showCancelButton: true
			}, function() {
				$.ajax({
					url: '${ctx}/api/classify/delete',
					data: {
						classifyId: classifyId
					},
					success: function(ret) {
						if (ret.code == 0) {
							toastr['success'](ret.msg);
							$aside.find('.list-group-item[data-id="' + classifyId + '"]').remove();
						} else {
							toastr['error'](ret.msg);
						}
					},
					error: function(err) {}
				});
			});
		})
		// paper
		.on('click', '.btn-paper-add', function() {
			window.location.href = '${ctx}/paperAdd';
		})
		.on('click', '.btn-paper-move', function() {
			$moveDialog.find('.alert-paper-move').addClass('hide');
			$moveDialog.find('ul').empty();
			$moveDialog.modal('show');
			$.ajax({
				url: '${ctx}/api/classify/list',
				success: function(ret) {
					if (ret.code == 0) {
						$.each(ret.data, function(k, val) {
							var $li = '<li style="height: 30px;">'
									+	'<div class="radio radio-success radio-inline">'
									+		'<input type="radio" name="classify" id="' + val.id + '" value="' + val.id + '">'
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
		.on('click', '.btn-paper-move-confirm', function() {
			var classifyId = $moveDialog.find('input[name="classify"]:checked').val();
			if (!classifyId) {
                $moveDialog.find('.alert-paper-move').removeClass('hide');
                return;
        	}
			var rows = $table.bootstrapTable('getSelections');
			$.ajax({
				url: '${ctx}/api/paper/move',
				type: 'post',
				data: {
					paperIdList: $k.util.getIdList(rows),
					classifyId: classifyId
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
		})
		.on('click', '.btn-paper-delete-batch', function() {
			swal({
                title: '您确定要删除所选择的试题吗?',
                type: 'warning',
                showCancelButton: true,
            }, function() {
                var rows = $table.bootstrapTable('getSelections');
                $.ajax({
                    url: '${ctx}/api/paper/batchDelete',
                    type: 'post',
                    data: { 
                    	paperIdList: $k.util.getIdList(rows) 
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