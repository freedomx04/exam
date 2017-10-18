<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/include/preload.jsp"%>

<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	
	<title>试题管理</title>
	
	<link rel="stylesheet" type="text/css" href="${ctx}/plugins/bootstrap/3.3.6/css/bootstrap.min.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/plugins/font-awesome/4.7.0/css/font-awesome.min.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/plugins/awesome-bootstrap-checkbox/awesome-bootstrap-checkbox.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/plugins/animate/animate.min.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/plugins/bootstrap-table/bootstrap-table.min.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/plugins/sweetalert/sweetalert.css">
	
	<link rel="stylesheet" type="text/css" href="${ctx}/plugins/hplus/style.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/local/common.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/plugins/toastr/toastr.min.css">
	
</head>

<body class="gray-bg body-question-list">
	<div class="wrapper wrapper-content animated fadeInRight">
		<div class="ibox float-e-margins">
			<div class="ibox-content">
				<div class="page-title">
					<h2>试题管理</h2>
				</div>
				
				<div id="question-list-table-toolbar" class="row" role="group">
					<div class="col-sm-6">
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
	 					<button type="button" class="btn btn-white btn-question-delete-batch" disabled="disabled">
	 						<i class="fa fa-trash-o fa-fw"></i>批量删除
	 					</button>
	 					<button type="button" class="btn btn-white btn-question-move" disabled="disabled">
	 						移动到题库
	 					</button>
					</div>
					
					<div class="col-sm-6 text-right">
						<select class="form-control" id="question-library" name="library" style="width: 160px; display: inline-block;">
							<option value="0">所有题库</option>
							<c:forEach var="library" items="${libraryList}">
								<option value="${library.id}">${library.name}</option>
							</c:forEach>
						</select>
						<select class="form-control" id="question-type" name="type" style="width: 160px; display: inline-block;">
							<option value="0">所有题型</option>
							<option value="1">单选题</option>
							<option value="2">多选题</option>
							<option value="3">判断题</option>
						</select>
					</div>
 				</div> 
 				<table id="question-list-table" class="table-hm" data-mobile-responsive="true"></table>
			</div>
		</div>
	</div>
	
    <div class="modal" id="modal-question-import-dialog" tabindex="-1" role="dialog" aria-hidden="true" data-backdrop="static">
    	<div class="modal-dialog">
    		<div class="modal-content animated fadeInDown">
    			<div class="modal-header">
    				<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                    <h3 class="modal-title">导入试题</h3>
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
                    <button type="button" class="btn btn-primary btn-fw" data-dismiss="modal">关&nbsp;闭</button>
                </div>
    		</div>
    	</div>
    </div>
    
    <div class="modal" id="modal-question-move-dialog" tabindex="-1" role="dialog" aria-hidden="true" data-backdrop="static">
    	<div class="modal-dialog">
    		<div class="modal-content animated fadeInDown">
    			<div class="modal-header">
    				<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                    <h3 class="modal-title">请选择题库</h3>
    			</div>
    			<div class="modal-body" style="max-height: 400px; overflow: auto;">
    				<div class="alert alert-success alert-question-move hide">
    					请先选择一项
    				</div>
    				<ul class="unstyled">
    					<c:forEach var="library" items="${libraryList}">
    						<li style="height: 30px;">
    							<div class="radio radio-success radio-inline">
    								<input type="radio" name="library" id="${library.id}" value="${library.id}">
    								<label for="${library.id}">${library.name}</label>
    							</div>
    						</li>
    					</c:forEach>
    				</ul>
    			</div>
    			<div class="modal-footer">
    				<button type="button" class="btn btn-white btn-fw" data-dismiss="modal">关&nbsp;闭</button>
                    <button type="button" class="btn btn-primary btn-fw btn-question-move-confirm">确&nbsp;定</button>
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
	<%@ include file="/WEB-INF/pages/question/dialog_question_detail.jsp"%>
	
	<script type="text/javascript">
		
		var $page = $('.body-question-list');
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
					field: 'title',
					title: '题干',
					formatter: function(value, row, index) {
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
					formatter: function(value, row, index) {
						return value.name;
					},
					cellStyle: function(row, index) {
						return {
							css: {
								'white-space': 'nowrap'
							}
						}
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
					width: '100',
					formatter: function(value, row, index) {
						if (row.editable == 0) {
							var $edit = '<a class="btn-question-edit a-operate">编辑</a>';
							var $delete = '<a class="btn-question-delete a-operate">删除</a>';
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
	            				title: '',
	            				text: '您确定要删除所选择的试题吗?',
	            				type: 'warning',
	            				showCancelButton: true,
	                            cancelButtonText: '取消',
	                            confirmButtonColor: '#DD6B55',
	                            confirmButtonText: '确定',
	                            closeOnConfirm: false
	            			}, function() {
	            				$.ajax({
	            					url: '${ctx}/api/question/delete',
	            					data: {
	            						questionId: row.id
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
	            selNum > 0 ? $page.find('.btn-question-delete-batch').removeAttr('disabled') : $page.find('.btn-question-delete-batch').attr('disabled', 'disabled');
	            selNum > 0 ? $page.find('.btn-question-move').removeAttr('disabled') : $page.find('.btn-question-move').attr('disabled', 'disabled');
	        });
		};
		
		$page
		.on('change', '#question-library', function() {
			libraryId = $(this).val();
			initTable(libraryId, type);
		})
		.on('change', '#question-type', function() {
			type = $(this).val();
			initTable(libraryId, type);
		})
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
		.on('click', '.btn-question-delete-batch', function() {
			swal({
                title: '',
                text: '您确定要删除所选择的试题吗?',
                type: 'warning',
                showCancelButton: true,
                cancelButtonText: '取消',
                confirmButtonColor: '#DD6B55',
                confirmButtonText: '确定',
                closeOnConfirm: false
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
		.on('click', '.btn-question-move', function() {
			$moveDialog.find('.alert-question-move').addClass('hide');
			$moveDialog.find('input[name="library"]').removeAttr('checked');
			$moveDialog.modal('show');
		})
		.on('click', '.btn-question-move-confirm', function() {
			var libraryId = $moveDialog.find('input[name="library"]:checked').val();
			if (!libraryId) {
				$moveDialog.find('.alert-question-move').removeClass('hide');
				return;
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