<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/include/preload.jsp"%>

<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <title>试卷编辑</title>
    
    <link rel="stylesheet" type="text/css" href="${ctx}/plugins/bootstrap/3.3.6/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/plugins/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/plugins/awesome-bootstrap-checkbox/awesome-bootstrap-checkbox.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/plugins/animate/animate.min.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/plugins/bootstrap-table/bootstrap-table.min.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/plugins/sweetalert/sweetalert.css">
    
    <link rel="stylesheet" type="text/css" href="${ctx}/plugins/hplus/style.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/local/common.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/plugins/toastr/toastr.min.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/plugins/bootstrap-datepicker/css/bootstrap-datetimepicker.min.css">
    
    <style type="text/css">
    .body-paper-edit .setting-title {
    	text-align: left;
    }
    .body-paper-edit .setting-sub-title {
    	text-align: left;
    	width: 100px;
    }
    </style>
    
</head>

<body class="gray-bg body-paper-edit">
	<div class="wrapper wrapper-content animated fadeInRight">
		<div class="ibox">
			<div class="ibox-content">
				<div class="page-title">
					<h2>试卷编辑<small style="margin-left: 20px;">${paper.title}</small></h2>
					<a href="${ctx}/paperList"><i class="fa fa-mail-reply fa-fw"></i>试卷管理</a>
				</div>
				
				<div class="tabs-container">
					<ul class="nav nav-tabs nav-tabs-line">
						<li class="active">
							<a data-toggle="tab" href="#tab-paper-info" aria-expanded="true">基本信息</a>
						</li>
						<li>
							<a data-toggle="tab" href="#tab-paper-question" aria-expanded="true">添加试题</a>
						</li>
						<li>
							<a data-toggle="tab" href="#tab-paper-student" aria-expanded="true">添加考生</a>
						</li>
						<li>
							<a data-toggle="tab" href="#tab-paper-setting" aria-expanded="true">试卷设置</a>
						</li>
						<li>
							<a data-toggle="tab" href="#tab-paper-preview" aria-expanded="true">预览</a>
						</li>
					</ul>
					<div class="tab-content" style="padding: 15px 0">
						<div id="tab-paper-info" class="tab-pane active">
							<form class="form-horizontal" id="form-paper-info" role="form" autocomplete="off">
								<div class="form-group">
									<div class="col-sm-5 col-sm-offset-3">
										<h3 class="help-block">请填写试卷基本信息</h3>
									</div>
								</div>
								
								<div class="form-group">
									<label for="title" class="col-sm-3 control-label"><i class="form-required">*</i>试卷标题</label>
									<div class="col-sm-5">
										<input type="text" class="form-control" name="title" value="${paper.title}">
									</div>
								</div>
								
								<div class="form-group">
									<label for="classifyId" class="col-sm-3 control-label"><i class="form-required">*</i>试卷分类</label>
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
										<textarea class="form-control" name="description" style="resize:none; height: 150px;">${paper.description}</textarea>
									</div>
								</div>
								
								<div class="hr-line-solid"></div>
								<div class="form-group">
									<div class="col-sm-5 col-sm-offset-3">
										<button type="button" class="btn btn-primary btn-fw btn-paper-info-save">保存</button>
									</div>
								</div>
							</form>
						</div>
						
						<div id="tab-paper-question" class="tab-pane">
							<div id="paper-question-table-toolbar" role="group">
								<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#modal-paper-question-dialog">
									<i class="fa fa-plus fa-fw"></i>添加试题
								</button>
								<button type="button" class="btn btn-white btn-paper-question-delete-batch" disabled="disabled">
			 						<i class="fa fa-trash-o fa-fw"></i>批量删除
			 					</button>
							</div>
							<table id="paper-question-table" class="table-hm" data-mobile-responsive="true"></table>
						</div>
						
						<div id="tab-paper-student" class="tab-pane">
							<div id="paper-student-table-toolbar" role="group">
								<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#modal-paper-student-dialog">
									<i class="fa fa-plus fa-fw"></i>添加考生
								</button>
								<button type="button" class="btn btn-white btn-paper-student-delete-batch" disabled="disabled">
			 						<i class="fa fa-trash-o fa-fw"></i>批量删除
			 					</button>
							</div>
							<table id="paper-student-table" class="table-hm" data-mobile-responsive="true"></table>
						</div>
						
						<div id="tab-paper-setting" class="tab-pane">
							<form class="form-horizontal" role="form" id="form-paper-setting" autocomplete="off">
								<div class="form-group">
									<div class="col-sm-5 col-sm-offset-3">
										<h3 class="help-block">试卷设置</h3>
									</div>
								</div>
								
								<div class="form-group">
									<label for="status" class="col-sm-3 control-label">试卷状态</label>
									<div class="col-sm-5">
										<c:if test="${paper.status == 0}">
											<div class="radio radio-success radio-inline" style="width: 80px;">
												<input type="radio" name="status" id="status-enable" value="0" checked>
												<label for="status-enable">可用</label>
											</div>
											<div class="radio radio-success radio-inline" style="width: 80px;">
												<input type="radio" name="status" id="status-unable" value="1">
												<label for="status-unable">不可用</label>
											</div>
										</c:if>
										<c:if test="${paper.status == 1}">
											<div class="radio radio-success radio-inline" style="width: 80px;">
												<input type="radio" name="status" id="status-enable" value="0">
												<label for="status-enable">可用</label>
											</div>
											<div class="radio radio-success radio-inline" style="width: 80px;">
												<input type="radio" name="status" id="status-unable" value="1" checked>
												<label for="status-unable">不可用</label>
											</div>
										</c:if>
									</div>
								</div>
								
								<div class="form-group">
									<label for="paper-valid-time" class="col-sm-3 control-label">有效时间</label>
									<div class="col-sm-5">
										<div class="input-daterange input-group col-sm-8" id="paper-valid-time" style="width: 400px;">
											<input type="text" class="form-control" name="startTime" id="startTime" 
												value="<fmt:formatDate value="${paper.startTime}" pattern='yyyy-MM-dd HH:mm'/>">
											<span class="input-group-addon">到</span>
											<input type="text" class="form-control" name="endTime" id="endTime"
												value="<fmt:formatDate value="${paper.endTime}" pattern='yyyy-MM-dd HH:mm'/>">
										</div>
									</div>
								</div>
								
								<div class="form-group">
									<label for="duration" class="col-sm-3 control-label">时间限制</label>
									<div class="col-sm-5">
										<input type="number" class="form-control" name="duration" min="0" value="${paper.duration}" style="width: 80px; display: inline-block;">&nbsp;&nbsp;分钟
									</div>
								</div>
							
								<div class="hr-line-solid"></div>
								<div class="form-group">
									<div class="col-sm-5 col-sm-offset-3">
										<button type="button" class="btn btn-primary btn-fw btn-paper-setting-save">保存</button>
									</div>
								</div>
							</form>
						</div>
						
						<div id="tab-paper-preview" class="tab-pane">
							<div style="width: 450px; margin: 20px auto;">
								<h2>复制下面的连接并分享给您的考生</h2>
								<div>
									<pre class="url-share"></pre>
									<button type="button" class="btn btn-primary btn-copy" data-clipboard-text="">
										<i class="fa fa-copy fa-fw"></i>点击复制
									</button>
								</div>
							</div>
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
	
	<script type="text/javascript" src="${ctx}/plugins/sweetalert/sweetalert.js"></script>
	<script type="text/javascript" src="${ctx}/plugins/bootstrap-table/bootstrap-table.min.js"></script>
    <script type="text/javascript" src="${ctx}/plugins/bootstrap-table/locale/bootstrap-table-zh-CN.min.js"></script>
    <script type="text/javascript" src="${ctx}/plugins/toastr/toastr.min.js"></script>
    <script type="text/javascript" src="${ctx}/plugins/clipboard/clipboard.min.js"></script>
    <script type="text/javascript" src="${ctx}/plugins/bootstrap-datepicker/js/bootstrap-datetimepicker.min.js"></script>
    <script type="text/javascript" src="${ctx}/plugins/bootstrap-datepicker/js/locales/bootstrap-datetimepicker.zh-CN.js"></script>
    
    <%@ include file="/WEB-INF/pages/question/dialog_question_detail.jsp"%>
    <%@ include file="/WEB-INF/pages/exam/dialog_question_add.jsp"%>
    <%@ include file="/WEB-INF/pages/exam/dialog_student_add.jsp"%>
    
    <script type="text/javascript">
    	
    	var $page = $('.body-paper-edit');
    	var paper = {
       		id: '${paper.id}'
       	}
    	
    	// info
    	var $infoForm = $page.find('#form-paper-info');
    	$infoForm.find('select[name="classifyId"]').val(${paper.classify.id});
    	
    	// question
    	var $paperQuestionTable = $k.util.bsTable($page.find('#paper-question-table'), {
			url: '${ctx}/api/paper/question/list?paperId=' + paper.id,
			toolbar: '#paper-question-table-toolbar',
			idField: 'id',
			pagination: false,
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
				width: '80',
				formatter: function(value, row, index) {
					var $delete = '<a class="btn-paper-question-delete a-operate">删除</a>';
					return $delete;
				},
				events: window.operateEvents = {
					'click .btn-paper-question-delete': function(e, value, row, index) {
						e.stopPropagation();
						swal({
            				title: '您确定要删除所选择的试题吗?',
            				type: 'warning',
            				showCancelButton: true
            			}, function() {
            				$.ajax({
            					url: '${ctx}/api/paper/question/delete',
            					data: {
            						paperId: paper.id,
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
		
		$paperQuestionTable.on('all.bs.table', function(e, row) {
            var selNum = $paperQuestionTable.bootstrapTable('getSelections').length;
            selNum > 0 ? $page.find('.btn-paper-question-delete-batch').removeAttr('disabled') : $page.find('.btn-paper-question-delete-batch').attr('disabled', 'disabled');
        });
		
		// student
		var $paperStudentTable = $k.util.bsTable($page.find('#paper-student-table'), {
			url: '${ctx}/api/paper/student/list?paperId=' + paper.id,
			toolbar: '#paper-student-table-toolbar',
			idField: 'id',
			pagination: false,
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
					var $delete = '<a class="btn-paper-student-delete a-operate">删除</a>';
					return $delete;
				},
				events: window.operateEvents = {
					'click .btn-paper-student-delete': function(e, value, row, index) {
						e.stopPropagation();
						swal({
            				title: '您确定要删除所选择的考生吗?',
            				type: 'warning',
            				showCancelButton: true
            			}, function() {
            				$.ajax({
            					url: '${ctx}/api/paper/student/delete',
            					data: {
            						paperId: paper.id,
            						studentId: row.id
            					},
            					success: function(ret) {
            						if (ret.code == 0) {
            							toastr['success'](ret.msg);
            							$paperStudentTable.bootstrapTable('refresh'); 
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
    	
    	$paperStudentTable.on('all.bs.table', function(e, row) {
            var selNum = $paperStudentTable.bootstrapTable('getSelections').length;
            selNum > 0 ? $page.find('.btn-paper-student-delete-batch').removeAttr('disabled') : $page.find('.btn-paper-student-delete-batch').attr('disabled', 'disabled');
        });
		
		// setting
		$('#paper-valid-time input').datetimepicker({
			format: 'yyyy-mm-dd hh:ii',
			language: 'zh-CN',
			autoclose: true,
			startDate:"2017-01-01",
		})
		.on('changeDate', function() {
			var starttime = $('#startTime').val();
			var endtime = $('#endTime').val();
			if (starttime > endtime) {
				toastr['error']('开始时间大于结束时间！');
			}
		});
		
		// preview
		var clipboard = new Clipboard('.btn-copy');
		var shareUrl = 'http://' + window.location.host + '${ctx}/online/' + paper.id;
		$page.find('.btn-copy').attr('data-clipboard-text', shareUrl);
		$page.find('.url-share').text(shareUrl);
    	
    	$page
    	// info
    	.on('click', '.btn-paper-info-save', function() {
    		var title = $infoForm.find('input[name="title"]').val();
			if (title == '') {
				toastr['error']('请填写试卷标题！');
				return;
			}
    		
    		var formData = new FormData($infoForm[0]);
    		formData.append('paperId', paper.id);
    		$.ajax({
    			url: '${ctx}/api/paper/update',
    			type: 'post',
    			data: formData,
    			processData: false,
    			contentType: false,
    			cache: false,
    			success: function(ret) {
    				if (ret.code == 0) {
    					toastr['success'](ret.msg);
    				}
    			},
    			error: function(err) {}
    		});
    	})
    	// question
    	.on('click', '.btn-paper-question-delete-batch', function() {
			swal({
                title: '您确定要删除所选择的试题吗?',
                type: 'warning',
                showCancelButton: true
            }, function() {
                var rows = $paperQuestionTable.bootstrapTable('getSelections');
                $.ajax({
                    url: '${ctx}/api/paper/question/batchDelete',
                    type: 'post',
                    data: { 
                    	paperId: paper.id,
                        questionIdList: $k.util.getIdList(rows) 
                    },
                    success: function(ret) {
                        if (ret.code == 0) {
                            toastr['success'](ret.msg);
                            $paperQuestionTable.bootstrapTable('refresh');
						} else {
							toastr['error'](ret.msg);
                        }
                    },
                    error: function(err) {}
                });
            });
		})
    	// student
    	.on('click', '.btn-paper-student-delete-batch', function() {
			swal({
                title: '您确定要删除所选择的考生吗?',
                type: 'warning',
                showCancelButton: true
            }, function() {
                var rows = $paperStudentTable.bootstrapTable('getSelections');
                $.ajax({
                    url: '${ctx}/api/paper/student/batchDelete',
                    type: 'post',
                    data: { 
                    	paperId: paper.id,
                        studentIdList: $k.util.getIdList(rows) 
                    },
                    success: function(ret) {
                        if (ret.code == 0) {
                        	toastr['success'](ret.msg);
                            $paperStudentTable.bootstrapTable('refresh');
						} else {
							toastr['error'](ret.msg);
                        }
                    },
                    error: function(err) {}
                });
            });
		})
    	// setting
    	.on('click', '.btn-paper-setting-save', function() {
    		var starttime = $('#startTime').val();
			var endtime = $('#endTime').val();
			if (starttime > endtime) {
				toastr['error']('开始时间大于结束时间！');
				return;
			}
			
			var $settingForm = $('#form-paper-setting');
			var formData = new FormData($settingForm[0]);
			
			formData.append('paperId', paper.id);
			$.ajax({
				url: '${ctx}/api/paper/setting',
				type: 'post',
				data: formData,
        		processData: false,
                contentType: false,
                cache: false, 
                success: function(ret) {
                	if (ret.code == 0) {
                		toastr['success'](ret.msg);
                	}
                },
                error: function(err) {}
			});
    	})
    	.on('click', '.btn-copy', function() {
			toastr['success']('复制成功');
		});;
    	
    
    </script>
</body>
</html>