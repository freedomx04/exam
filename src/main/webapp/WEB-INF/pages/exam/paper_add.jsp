<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/include/preload.jsp"%>

<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <title>试卷新增</title>
    
    <link rel="stylesheet" type="text/css" href="${ctx}/plugins/bootstrap/3.3.6/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/plugins/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/plugins/awesome-bootstrap-checkbox/awesome-bootstrap-checkbox.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/plugins/animate/animate.min.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/plugins/bootstrap-table/bootstrap-table.min.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/plugins/sweetalert/sweetalert.css">
    
    <link rel="stylesheet" type="text/css" href="${ctx}/plugins/hplus/style.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/local/pearls.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/local/common.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/plugins/toastr/toastr.min.css">
    
    <style type="text/css">
    .pearl-pane {
    	padding-top: 20px;
    }
    .body-paper-add .desc {
    	text-align: left!important;
    }
    .body-paper-add .sub-desc {
    	font-weight: normal;
    }
    </style>
</head>

<body class="gray-bg body-paper-add">
	<div class="wrapper wrapper-content animated fadeInRight">
		<div class="ibox float-e-margins">
			<div class="ibox-content">
				<h2 class="page-title">试卷新增</h2>
				
				<div class="pearls row" style="padding-top: 20px;">
					<div class="pearl col-sm-3" data-pearl="pearl-1">
						<span class="pearl-number">1</span> 
						<span class="pearl-title">基本信息</span>
					</div>
					<div class="pearl col-sm-3" data-pearl="pearl-2">
						<span class="pearl-number">2</span> 
						<span class="pearl-title">选择试题</span>
					</div>
					<div class="pearl current col-sm-3" data-pearl="pearl-3">
						<span class="pearl-number">3</span> 
						<span class="pearl-title">试卷设置</span>
					</div>
					<div class="pearl col-sm-3" data-pearl="pearl-4">
						<span class="pearl-number">4</span> 
						<span class="pearl-title">预览</span>
					</div>
				</div>
				
				<div class="pearl-pane hide" id="pearl-1">
					<form class="form-horizontal" role="form" id="form-basic" autocomplete="off">
						<div class="form-group">
							<div class="col-sm-5 col-sm-offset-3">
								<h3 class="help-block">请填写试卷基本信息</h3>
							</div>
						</div>
					
						<div class="form-group">
							<label for="title" class="col-sm-3 control-label">试卷标题</label>
							<div class="col-sm-5">
								<input type="text" class="form-control" name="title">
							</div>
						</div>
						
						<div class="form-group">
							<label for="classifyId" class="col-sm-3 control-label">试卷分类</label>
							<div class="col-sm-5">
								<select class="form-control" name="classifyId">
									<c:forEach var="classify" items="${classifyList}">
										<option value="${classify.id}">${classify.name}</option>
									</c:forEach>
								</select>
							</div>
						</div>
						
						<div class="form-group">
							<label for="description" class="col-sm-3 control-label">试卷描述</label>
							<div class="col-sm-5">
								<textarea class="form-control" name="description" style="resize:none; height: 150px;"></textarea>
							</div>
						</div>
						
						<div class="form-group">
							<div class="col-sm-5 col-sm-offset-3">
								<button type="button" class="btn btn-primary btn-paper-add">保存并进入下一步</button>
							</div>
						</div>
					</form>
				</div>
				
				<div class="pearl-pane hide" id="pearl-2">
					<h2>添加试题到试卷中:<span class="paper-title" style="padding-left: 10px;">语文</span></h2>
					<div id="paper-question-table-toolbar" role="group" style="margin-top: 20px;">
						<button type="button" class="btn btn-primary btn-paper-question-add" data-toggle="modal" data-target="#modal-paper-question-dialog">
							<i class="fa fa-plus fa-fw"></i>添加试题
						</button>
						<button type="button" class="btn btn-white btn-paper-question-delete-batch" disabled="disabled">
	 						<i class="fa fa-trash-o fa-fw"></i>批量删除
	 					</button>
					</div>
					<table id="paper-question-table" class="table-hm" data-mobile-responsive="true"></table>
					<div style="margin-top: 20px;">
						<button type="button" class="btn btn-primary btn-paper-question-add">保存并进入下一步</button>
					</div>
				</div>
				
				<div class="pearl-pane" id="pearl-3">
					<form class="form-horizontal" role="form" id="form-setting" autocomplete="off">
						<div class="form-group">
							<div class="col-sm-5 col-sm-offset-2">
								<h2>试卷设置:<span class="paper-title" style="padding-left: 10px;">语文</span></h2>
							</div>
						</div>
						
						<div class="form-group">
							<label for="" class="desc col-sm-2 col-sm-offset-2 control-label">进行考试</label>
							<div class="col-sm-6">
								<div>
									<label class="control-label sub-desc">考试总时长：</label>
									<input type="number" class="form-control" name="duration" min="0" value="30" style="width: 80px; display: inline-block;">&nbsp;&nbsp;分钟
								</div>
								<div style="margin-top: 10px;">
									<label class="control-label sub-desc">最短交卷时间, 0表示不限制时间：</label>
									<input type="number" class="form-control" name="duration" min="0" value="0" style="width: 80px; display: inline-block;">&nbsp;&nbsp;分钟
								</div>
							</div>
						</div>
						
						<div class="hr-line-dashed"></div>
						
						<div class="form-group">
							<div class="col-sm-5 col-sm-offset-2">
								<button type="button" class="btn btn-primary btn-paper-setting">完成</button>
							</div>
						</div>
						
					</form>
				</div>
				
				<div class="pearl-pane hide" id="pearl-4">
					4
				</div>
			</div>
		</div>
	</div>
	
	<div class="modal" id="modal-paper-question-dialog" tabindex="-1" role="dialog" aria-hidden="true" data-backdrop="true">
		<div class="modal-dialog" style="width: 850px;">
			<div class="modal-content animated fadeInDown">
				<div class="modal-body" style="max-height: 700px; overflow: auto;">
					<div class="tabs-container">
						<ul class="nav nav-tabs nav-tabs-line">
							<li class="active">
								<a data-toggle="tab" href="#paper-question-library-random" aria-expanded="true">
                        			从题库随机选择试题
                        		</a>
							</li>
							<li>
								<a data-toggle="tab" href="#paper-question-library-manual" aria-expanded="true">
									手动从题库中选择试题
								</a>
							</li>
							<!-- <li>
								<a data-toggle="tab" href="#paper-question-add" aria-expanded="true">
									<i class="fa fa-plus fa-fw"></i>新增试题
								</a>
							</li>
							<li>
								<a data-toggle="tab" href="#paper-question-import" aria-expanded="true">
									<i class="fa fa-upload fa-fw"></i>导入试题
								</a>
							</li> -->
						</ul>
						<div class="tab-content">
							<div id="paper-question-library-random" class="tab-pane active">
								<div class="panel-body">
									<ul class="unstyled">
										<c:forEach var="library" items="${libraryList}">
											<li data-library-id="${library.id}" style="height: 40px; line-height: 40px;">
												<div class="row">
													<div class="col-sm-4">
														<span>${library.name}&nbsp;<i style="font-style: normal; color: #bbb;">(共&nbsp;${library.count}&nbsp;道试题)</i></span>
													</div>
													<div class="col-sm-4">
														<span>选择&nbsp;</span>
														<span>
															<input class="form-control input-question-count" style="display: inline-block; width: 80px" 
																type="number" value="0" min="0" max="${library.count}">
														</span>
														<span>&nbsp;道试题</span> 
													</div>
												</div>
											</li>
										</c:forEach>
									</ul>
									<button type="button" class="btn btn-primary btn-question-random-add" style="margin-left: 40px;" disabled>
										将从题库中选择&nbsp;<span class="question-random-add-count">0</span>&nbsp;个试题
									</button>
								</div>
							</div>
							
							<div id="paper-question-library-manual" class="tab-pane">
								<div class="panel-body">
									<div id="question-list-table-toolbar" role="group">
										<select class="form-control" id="question-library" style="width: 160px; display: inline-block;">
											<option value="0">所有题库</option>
											<c:forEach var="library" items="${libraryList}">
												<option value="${library.id}">${library.name}</option>
											</c:forEach>
										</select>
										<select class="form-control" id="question-type" style="width: 160px; display: inline-block;">
											<option value="0">所有题型</option>
											<option value="1">单选题</option>
											<option value="2">多选题</option>
											<option value="3">判断题</option>
										</select> 
									</div>
									<table id="question-list-table" class="table-hm" data-mobile-responsive="true"></table>
								</div>
							</div>
							
							<!-- <div id="paper-question-add" class="tab-pane">
								<div class="panel-body">
									c
								</div>
							</div>
							
							<div id="paper-question-import" class="tab-pane">
								<div class="panel-body">
									<div>
										<h2>1.请先下载模板</h2>
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
							</div> -->
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<script type="text/javascript" src="${ctx}/plugins/jquery/2.1.4/jquery.min.js"></script>
    <script type="text/javascript" src="${ctx}/plugins/bootstrap/3.3.6/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="${ctx}/plugins/hplus/content.min.js"></script>
    <script type="text/javascript" src="${ctx}/local/common.js"></script>
    
    <script type="text/javascript" src="${ctx}/plugins/sweetalert/sweetalert.min.js"></script>
    <script type="text/javascript" src="${ctx}/plugins/toastr/toastr.min.js"></script>
    <script type="text/javascript" src="${ctx}/plugins/bootstrap-table/bootstrap-table.min.js"></script>
    <script type="text/javascript" src="${ctx}/plugins/bootstrap-table/locale/bootstrap-table-zh-CN.min.js"></script>

	<script type="text/javascript">
	
		var $page = $('.body-paper-add');
		var $dialog = $('#modal-paper-question-dialog');
		var paper;
		
		paper = {
			id: 1
		}
		
		var $table = $k.util.bsTable($page.find('#paper-question-table'), {
			url: '${ctx}/api/paper/listQuestion?paperId=' + paper.id,
			toolbar: '#paper-question-table-toolbar',
			idField: 'id',
			pagination: false,
			search: false,
			showRefresh: false,
			showColumns: false,
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
				}
			}, {
				field: 'library',
				title: '题库',
				align: 'center',
				width: '150',
				formatter: function(value, row, index) {
					return value.name
				}
			}, {
				field: 'type',
				title: '题型',
				align: 'center',
				width: '100',
				formatter: function(value, row, index) {
					var quesType;
					switch (value) {
					case 1:		
						quesType = '<span class="ques-type ques-single">单选题</span>';
						break;
					case 2:		
						quesType = '<span class="ques-type ques-multiple">多选题</span>';
						break;
					case 3:		
						quesType = '<span class="ques-type ques-boolean">判断题</span>';
						break;
					 }
					return quesType;
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
					var $delete = '<a class="btn-question-delete a-operate">删除</a>';
					return $delete;
				},
				events: window.operateEvents = {
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
            					url: '${ctx}/api/paper/deleteQuestion',
            					data: {
            						paperId: paper.id,
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
            selNum > 0 ? $page.find('.btn-paper-question-delete-batch').removeAttr('disabled') : $page.find('.btn-paper-question-delete-batch').attr('disabled', 'disabled');
        });
		
		$page
		.on('click', '.btn-paper-add', function() {
			var $pearl = $page.find('#pearl-1');
			
			var $form = $('#form-basic');
			var title = $form.find('input[name="title"]').val();
			if (title == '') {
				toastr['error']('请填写试卷标题！');
				return;
			}
			
			var formData = new FormData($form[0]);
			$.ajax({
				url: '${ctx}/api/paper/create',
				type: 'post',
				data: formData,
        		processData: false,
                contentType: false,
                cache: false, 
                success: function(ret) {
                	if (ret.code == 0) {
                		paper = ret.data;
                		pearl($pearl);
                	}
                },
                error: function(err) {}
			});
		})
		.on('click', '.btn-paper-question-add', function() {
			var $pearl = $page.find('#pearl-2');
			pearl($pearl);
		})
		.on('click', '.btn-paper-question-delete-batch', function() {
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
                    url: '${ctx}/api/paper/batchDeleteQuestion',
                    type: 'post',
                    data: { 
                    	paperId: paper.id,
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
		});
		
		function pearl($pearl) {
			var $nextP = $page.find("[data-pearl='"+ $pearl.attr("id") +"']");
			$page.find('.pearl-pane').addClass('hide');
			$pearl.next().removeClass("hide");
			
			$page.find('.pearl').removeClass('current');
			$nextP.addClass('done');
			$nextP.next().addClass('current');
		}
		
		// 添加试题对话框
		var $questionTable;
		var libraryId = 0;
		var type = 0;
		initTable(0, 0);
		
		function initTable(libraryId, type) {
			$dialog.find('#question-list-table').bootstrapTable('destroy');
			
			$questionTable = $k.util.bsTable($dialog.find('#question-list-table'), {
				url: '${ctx}/api/question/list?libraryId=' + libraryId + '&type=' + type,
				toolbar: '#question-list-table-toolbar',
				idField: 'id',
				pageSize: 10, 
				responseHandler: function(res) {
					return res.data;
				},
				columns: [{
					field: 'title',
					title: '题干',
				}, {
					field: 'library',
					title: '题库',
					align: 'center',
					width: '150',
					formatter: function(value, row, index) {
						return value.name;
					}
				}, {
					field: 'type',
					title: '题型',
					align: 'center',
					width: '100',
					formatter: function(value, row, index) {
						var quesType;
						switch (value) {
						case 1:		
							quesType = '<span class="ques-type ques-single">单选题</span>';
							break;
						case 2:		
							quesType = '<span class="ques-type ques-multiple">多选题</span>';
							break;
						case 3:		
							quesType = '<span class="ques-type ques-boolean">判断题</span>';
							break;
						 }
						return quesType;
					}
				}, {
					title: '操作',
					align: 'center',
					width: '80',
					formatter: function(value, row, index) {
						var $add = '<a class="btn-question-append a-operate">加入试卷</a>';
						return $add;
					},
					events: window.operateEvents = {
						'click .btn-question-append': function(e, value, row, index) {
							var $this = $(this);
							e.stopPropagation();
							$.ajax({
								url: '${ctx}/api/paper/manualAdd',
								data: {
									paperId: paper.id,
									questionId: row.id
								},
								success: function(ret) {
									if (ret.code == 0) {
										$this.text('已加入').addClass('disabled');
										$table.bootstrapTable('refresh');
									}
								},
								error: function(ret) {}
							});
						}
					}
				}]
			});
		}
		
		$dialog
		// 从题库随机选择试题
		.on('keyup', '.input-question-count', function() {
			var value = Number($(this).val());
			var min = Number($(this).attr('min'));
			var max = Number($(this).attr('max'));
			if (value > max) {
				$(this).val(max);
			} else if (value < min) {
				$(this).val(min);
			}
			
			var randomCount = 0;
			$.each($dialog.find('.input-question-count'), function(k, val) {
				var count = Number($(this).val());
				randomCount += count;
			});
			if (randomCount > 0) {
				$dialog.find('.question-random-add-count').text(randomCount);
				$dialog.find('.btn-question-random-add').removeAttr('disabled');
			} else {
				$dialog.find('.question-random-add-count').text(0);
				$dialog.find('.btn-question-random-add').attr('disabled', 'disabled');
			}
		})
		.on('click', '.btn-question-random-add', function() {
			var randomList = [];
			$.each($dialog.find('#paper-question-library-random li'), function(k, val) {
				var libraryId = $(this).data('libraryId');
				var count = $(this).find('.input-question-count').val();
				if (count > 0) {
					randomList.push(libraryId + '-' + count);
				}
			});
			
			$.ajax({
				url: '${ctx}/api/paper/randomAdd',
				type: 'post',
				data: {
					paperId: paper.id,
					randomList: randomList
				},
				success: function(ret) {
					if (ret.code == 0) {
						$table.bootstrapTable('refresh');
						$dialog.modal('hide');
					}
				},
				error: function(err) {}
			});
		})
		// 手动从题库中选择试题
		.on('change', '#question-library', function() {
			libraryId = $(this).val();
			initTable(libraryId, type);
		})
		.on('change', '#question-type', function() {
			type = $(this).val();
			initTable(libraryId, type);
		})
		// 导入试题
		.on('click', '.btn-question-template', function() {
			window.location.href = '${ctx}/api/question/template';
		})
		.on('click', '.btn-question-import', function() {
			$dialog.find('#import-file-input').click();
		})
		.on('change', '#import-file-input', function() {
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
		});
	</script>

</body>
</html>