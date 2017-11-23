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

<body class="gray-bg body-question-list">
	<div class="wrapper wrapper-content animated fadeInRight height-full">
		<div class="ibox float-e-margins height-full" style="margin-bottom: 0;">
			<div class="height-full" style="position: relative;">
				<div class="page-aside">
					<div class="page-aside-inner height-full">
						<div class="page-aside-section">
							<div class="list-group">
								<a class="list-group-item active" href="javascript:;" data-id="0">
									<i class="fa fa-question-circle-o fa-fw"></i>所有试题
								</a>
							</div>
						</div>
						
						<div class="page-aside-section">
							<h4 class="page-aside-title"><i class="fa fa-bars fa-fw"></i>题库列表</h4>
							<div class="list-group has-actions">
								<c:forEach var="library" items="${libraryList}">
									<div class="list-group-item" data-id="${library.id}">
										<div class="list-content">
											<span class="item-text">${library.name}</span>
											<c:if test="${library.editable == 0}">
												<div class="item-actions">
													<span class="btn btn-pure btn-library-edit"><i class="wb-edit"></i></span>
													<span class="btn btn-pure btn-library-delete"><i class="wb-close"></i></span>
												</div>
											</c:if>
										</div>
									</div>
								</c:forEach>
							</div>
						</div>
						
						<div class="page-aside-section">
							<a class="list-group-item btn-library-add" href="javascript:;">
								<i class="fa fa-plus fa-fw"></i>添加新题库
							</a>
						</div>
					</div>
				</div>
				
				<div class="page-main ibox-content">
					<div class="page-title">
						<h2>试题列表</h2>
					</div>
					<div id="question-list-table-toolbar" role="group">
						<div class="btn-group">
							<button data-toggle="dropdown" type="button" class="btn btn-primary dropdown-toggle" aria-expanded=false>
		 						<i class="fa fa-plus fa-fw"></i>新增试题&nbsp;<span class="caret"></span>
		 					</button>
		 					<ul class="dropdown-menu" style="left: 0;">
		 						<li><a href="${ctx}/questionAdd?type=1&method=add">单选题</a></li>
		 						<li><a href="${ctx}/questionAdd?type=2&method=add">多选题</a></li>
		 						<li><a href="${ctx}/questionAdd?type=3&method=add">判断题</a></li>
		 					</ul>
						</div>
	 					<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#modal-question-import-dialog">
	 						<i class="fa fa-upload fa-fw"></i>导入试题
	 					</button>
	 					<button type="button" class="btn btn-white btn-question-move" disabled="disabled">
	 						 移动到分组
	 					</button>
	 					<button type="button" class="btn btn-danger btn-question-delete-batch" disabled='disabled'>
	 						<i class="fa fa-trash-o fa-fw"></i>删除
	 					</button>
	 					<select class="form-control" id="question-type" name="type" style="width: 160px; display: inline-block;">
							<option value="0">所有题型</option>
							<option value="1">单选题</option>
							<option value="2">多选题</option>
							<option value="3">判断题</option>
						</select>
					</div>
					<table id="question-list-table" class="table-hm table-fixed" data-mobile-responsive="true"></table>
				</div>
			</div>
		</div>
	</div>
	
	<div class="modal" id="modal-library-dialog" tabindex="-1" role="dialog" aria-hidden="true" data-backdrop="static">
        <div class="modal-dialog modal-center">
            <div class="modal-content animated fadeInDown">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                    <h4 class="modal-title"></h4>
                </div>
                <div class="modal-body">
                    <form class="form-horizontal" role="form" autocomplete="off">
                        <div class="form-group">
                            <label for="name" class="col-sm-3 control-label"><i class="form-required">*</i>题库名称</label>
                            <div class="col-sm-7">
                                <input type="text" class="form-control" name="name" required data-bv-notempty-message="题库名称不能为空">
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
    
    <div class="modal" id="modal-question-import-dialog" tabindex="-1" role="dialog" aria-hidden="true" data-backdrop="static">
    	<div class="modal-dialog modal-center">
    		<div class="modal-content animated fadeInDown">
    			<div class="modal-header">
    				<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                    <h4 class="modal-title">导入试题</h4>
    			</div>
    			<div class="modal-body">
    				<div>
    					<h2 style="margin-top: 0;">1.请先下载模板</h2>
    					<ul>
    						<li>建议按多次分批导入，导入前建议试题编好题库，方便题库管理</li>
    						<li>请使用<strong>微软的Office编辑，不要使用WPS</strong></li>
    					</ul>
    					<button type="button" class="btn btn-blue btn-question-template">
	 						<i class="fa fa-download fa-fw"></i>下载EXCEL格式模板
	 					</button>
    				</div>
    				<div>
    					<h2>2.导入试题</h2>
    					<input id="import-file-input" type="file" style="display:none">
    					<button type="button" class="btn btn-primary btn-question-import">
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
    
    <div class="modal" id="modal-question-move-dialog" tabindex="-1" role="dialog" aria-hidden="true" data-backdrop="static">
    	<div class="modal-dialog modal-center">
    		<div class="modal-content animated fadeInDown">
    			<div class="modal-header">
    				<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                    <h4 class="modal-title">请选择题库</h4>
    			</div>
    			<div class="modal-body" style="max-height: 400px; overflow: auto;">
    				<div class="alert alert-success alert-question-move hide">
    					请先选择一项
    				</div>
    				<ul class="unstyled"></ul>
    			</div>
    			<div class="modal-footer">
    				<button type="button" class="btn btn-white btn-fw" data-dismiss="modal">取消</button>
                    <button type="button" class="btn btn-primary btn-fw btn-question-move-confirm">确定</button>
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
	
	<%@ include file="/WEB-INF/pages/question/dialog_question_detail.jsp"%>

	<script type="text/javascript">
	;(function( $ ) {
		
		var $page = $('.body-question-list');
		var $aside = $('.page-aside');
		
		var $importDialog = $page.find('#modal-question-import-dialog');
		var $moveDialog = $page.find('#modal-question-move-dialog');
		
		var $table;
		var libraryId = 0;
		var type = 0;
		initTable(0, 0);
		
		function initTable(libraryId, type) {
			$page.find('#question-list-table').bootstrapTable('destroy'); 
			
			$table = $k.util.bsTable($page.find('#question-list-table'), {
				url: '${ctx}/api/question/list?libraryId=' + libraryId + '&type=' + type,
				toolbar: '#question-list-table-toolbar',
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
					title: '题干',
					formatter: function(value, row, index) {
						if (row.imagePath) {
							value += '<i class="fa fa-image fa-fw"></i>'
						}
						return '<a class="question-detail">' + value + '</a>';
					},
					events: window.operateEvents = {
						'click .question-detail': function(e, value, row, index) {
							e.stopPropagation();
							showQuestion(row);
						}
					}
				}, {
					field: 'library',
					title: '题库',
					width: '200',
					formatter: function(value, row, index) {
						return value.name;
					},
					cellStyle: function(row, index) {
						return { css: {'white-space': 'nowrap'} };
					}
				}, {
					field: 'type',
					title: '题型',
					align: 'center',
					width: '100',
					formatter: function(value, row, index) {
						var type;
						switch (value) {
						case 1:		
							type = '<span class="ques-type ques-single">单选题</span>';
							break;
						case 2:		
							type = '<span class="ques-type ques-multiple">多选题</span>';
							break;
						case 3:		
							type = '<span class="ques-type ques-boolean">判断题</span>';
							break;
						}
						return type;
					}
				}, {
					field: 'score',
					title: '分数',
					align: 'center',
					width: '50'
				}, {
					title: '操作',
					align: 'center',
					width: '80',
					formatter: function(value, row, index) {
						if (row.editable == 0) {
							var $edit = '<span class="btn-operate btn-question-edit" data-toggle="tooltip" title="编辑"><i class="wb-edit"></i></span>';
							var $delete = '<span class="btn-operate btn-question-delete" data-toggle="tooltip" title="删除"><i class="wb-close"></i></span>';
							return $edit + $delete; 
						} 
					},
					events: window.operateEvents = {
						'click .btn-question-edit': function(e, value, row, index) {
							e.stopPropagation();
							window.location.href = './questionAdd?method=edit&questionId=' + row.id;
						},
						'click .btn-question-delete': function(e, value, row, index) {
							e.stopPropagation();
							swal({
	            				title: '您确定要删除所选择的试题吗?',
	            				type: 'warning',
	            				showCancelButton: true,
	            			}, function() {
	            				$.ajax({
	            					url: '${ctx}/api/question/delete',
	            					data: {
	            						questionId: row.id
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
	            selNum > 0 ? $page.find('.btn-question-delete-batch').removeAttr('disabled') : $page.find('.btn-question-delete-batch').attr('disabled', 'disabled');
	            selNum > 0 ? $page.find('.btn-question-move').removeAttr('disabled') : $page.find('.btn-question-move').attr('disabled', 'disabled');
	        });
		};
		
		// 题库添加/编辑对话框
		var $libraryDialog = $page.find('#modal-library-dialog');
		var $libraryForm = $libraryDialog.find('form');
		$k.util.bsValidator($libraryForm);
		$libraryDialog.on('click', '.btn-confirm', function() {
			var validator = $libraryForm.data('bootstrapValidator');
			validator.validate();
			
            if (validator.isValid()) {
            	var method = $libraryDialog.data('method');
            	var name = $libraryDialog.find('input[name = "name"]').val();
            	if (method == 'add') {
            		$.ajax({
 						url: '${ctx}/api/library/create',
                 		type: 'POST',
                 		data: {
                 			name: name,
                 		},
                 		success: function(ret) {
                 			if (ret.code == 0) {
	               				$libraryDialog.modal('hide');
	               				toastr['success'](ret.msg);
	               				
	               				// 添加新分组到最后
	               				var library = ret.data;
	               				var $item = '<div class="list-group-item" data-id="' + library.id + '">'
	               							+ 	'<div class="list-content">'
	               							+		'<span class="item-text">' + library.name + '</span>'
	               							+ 		'<div class="item-actions">'
	               							+			'<span class="btn btn-pure btn-library-edit"><i class="wb-edit"></i></span>'
	               							+			'<span class="btn btn-pure btn-library-delete"><i class="wb-close"></i></span>'
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
            		var libraryId = $libraryDialog.data('libraryId');
            		$.ajax({
                		url: '${ctx}/api/library/update',
                		type: 'POST',
                		data: { 
                			libraryId: libraryId, 
                			name: name 
                		},
                		success: function(ret) {
                			if (ret.code == 0) {
                				$libraryDialog.modal('hide');
	               				toastr['success'](ret.msg);
	               				$aside.find('.list-group-item[data-id="' + libraryId + '"]').find('.item-text').text(name);
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
			libraryId = $(this).data('id');
			if (libraryId > -1) {
				$page.find('.list-group-item').removeClass('active');
				$(this).addClass('active');
				initTable(libraryId, 0);
			}
		})
		// 题库
		.on('hidden.bs.modal', '#modal-library-dialog', function() {
            $libraryForm.bootstrapValidator('resetForm', true);
            $(this).removeData('bs.modal');
        }) 
		.on('click', '.btn-library-add', function() {
			$libraryDialog.find('.modal-title').text('添加题库');
			$libraryDialog.data('method', 'add');
			$libraryDialog.modal('show');
		})
		.on('click', '.btn-library-edit', function(e) {
			e.stopPropagation();
			var libraryId = $(this).closest('.list-group-item').data('id');
			var libraryName = $(this).closest('.list-group-item').find('.item-text').text();
			$libraryDialog.find('.modal-title').text('编辑题库');
			$libraryForm.find('input[name="name"]').val(libraryName);
			$libraryDialog.data('method', 'edit');
			$libraryDialog.data('libraryId', libraryId);
			$libraryDialog.modal('show');
		})
		.on('click', '.btn-library-delete', function(e) {
			e.stopPropagation();
			var libraryId = $(this).closest('.list-group-item').data('id');
			swal({
				title: '您确定要删除所选择的题库吗?',
				text: '题库中包含的试题将会移动至默认题库',
				type: 'warning',
				showCancelButton: true
			}, function() {
				$.ajax({
					url: '${ctx}/api/library/delete',
					data: {
						libraryId: libraryId
					},
					success: function(ret) {
						if (ret.code == 0) {
							toastr['success'](ret.msg);
							$aside.find('.list-group-item[data-id="' + libraryId + '"]').remove();
						} else {
							toastr['error'](ret.msg);
						}
					},
					error: function(err) {}
				});
			});
		})
		// 试题导入
		.on('click', '.btn-question-template', function() {
			window.location.href = '${ctx}/api/question/template';
		})
		.on('click', '.btn-question-import', function() {
			$page.find('#import-file-input').click();
		})
		.on('change', '#import-file-input', function() {
			$importDialog.modal('hide');
			
			var formData = new FormData();
			formData.append('file', this.files[0]);
			
			$.ajax({
				url: '${ctx}/api/question/import',
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
		// 移动到题库
		.on('click', '.btn-question-move', function() {
			$moveDialog.find('.alert-library-move').addClass('hide');
			$moveDialog.find('ul').empty();
			$moveDialog.modal('show');
			$.ajax({
				url: '${ctx}/api/library/list',
				success: function(ret) {
					if (ret.code == 0) {
						$.each(ret.data, function(k, val) {
							var $li = '<li style="height: 30px;">'
									+	'<div class="radio radio-success radio-inline">'
									+		'<input type="radio" name="library" id="' + val.id + '" value="' + val.id + '">'
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
		.on('click', '.btn-question-move-confirm', function() {
			var libraryId = $moveDialog.find('input[name="library"]:checked').val();
			if (!libraryId) {
				$moveDialog.find('.alert-library-move').removeClass('hide');
				return
			}
			var rows = $table.bootstrapTable('getSelections');
			$.ajax({
				url: '${ctx}/api/question/move',
				type: 'post',
				data: {
					questionIdList: $k.util.getIdList(rows),
					libraryId: libraryId
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
		.on('click', '.btn-question-delete-batch', function() {
			swal({
                title: '您确定要删除所选择的试题吗?',
                type: 'warning',
                showCancelButton: true,
            }, function() {
                var rows = $table.bootstrapTable('getSelections');
                $.ajax({
                    url: '${ctx}/api/question/batchDelete',
                    type: 'post',
                    data: { 
                    	questionIdList: $k.util.getIdList(rows) 
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
		// 试题类型选择
		.on('change', '#question-type', function() {
			type = $(this).val();
			initTable(libraryId, type);
		});
		
	})( jQuery );
	</script>

</body>
</html>