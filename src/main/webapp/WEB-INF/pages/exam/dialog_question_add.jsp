<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/include/preload.jsp"%>

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
												<div class="col-sm-6">
													<span>${library.name}&nbsp;<i style="font-style: normal; color: #bbb;">(共&nbsp;${library.count}&nbsp;道试题)</i></span>
												</div>
												<div class="col-sm-6">
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

<script type="text/javascript">

	//添加试题对话框
	var $questionDialog = $('#modal-paper-question-dialog');
	var $questionTable;
	var libraryId = 0;
	var type = 0;
	initQuestionTable(0, 0);
	
	function initQuestionTable(libraryId, type) {
		$questionDialog.find('#question-list-table').bootstrapTable('destroy');
		
		$questionTable = $k.util.bsTable($questionDialog.find('#question-list-table'), {
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
							url: '${ctx}/api/paper/question/manualAdd',
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
	
	$questionDialog
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
		$.each($questionDialog.find('.input-question-count'), function(k, val) {
			var count = Number($(this).val());
			randomCount += count;
		});
		if (randomCount > 0) {
			$questionDialog.find('.question-random-add-count').text(randomCount);
			$questionDialog.find('.btn-question-random-add').removeAttr('disabled');
		} else {
			$questionDialog.find('.question-random-add-count').text(0);
			$questionDialog.find('.btn-question-random-add').attr('disabled', 'disabled');
		}
	})
	.on('click', '.btn-question-random-add', function() {
		var randomList = [];
		$.each($questionDialog.find('#paper-question-library-random li'), function(k, val) {
			var libraryId = $(this).data('libraryId');
			var count = $(this).find('.input-question-count').val();
			if (count > 0) {
				randomList.push(libraryId + '-' + count);
			}
		});
		
		$.ajax({
			url: '${ctx}/api/paper/question/randomAdd',
			type: 'post',
			data: {
				paperId: paper.id,
				randomList: randomList
			},
			success: function(ret) {
				if (ret.code == 0) {
					$table.bootstrapTable('refresh');
					$questionDialog.modal('hide');
				}
			},
			error: function(err) {}
		});
	})
	// 手动从题库中选择试题
	.on('change', '#question-library', function() {
		libraryId = $(this).val();
		initQuestionTable(libraryId, type);
	})
	.on('change', '#question-type', function() {
		type = $(this).val();
		initQuestionTable(libraryId, type);
	})
	// 导入试题
	.on('click', '.btn-question-template', function() {
		window.location.href = '${ctx}/api/question/template';
	})
	.on('click', '.btn-question-import', function() {
		$questionDialog.find('#import-file-input').click();
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
