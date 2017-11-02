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
    <link rel="stylesheet" type="text/css" href="${ctx}/plugins/bootstrap-datepicker/css/bootstrap-datetimepicker.min.css">
    
    <style type="text/css">
    .pearl-pane {
    	padding-top: 20px;
    }
    .body-paper-add .setting-title {
    	text-align: left;
    }
    .body-paper-add .setting-sub-title {
    	text-align: left;
    	width: 100px;
    }
    </style>
</head>

<body class="gray-bg body-paper-add">
	<div class="wrapper wrapper-content animated fadeInRight">
		<div class="ibox float-e-margins">
			<div class="ibox-content">
				<div class="page-title">
					<h2>试卷新增</h2>
					<a href="${ctx}/paperList"><i class="fa fa-mail-reply fa-fw"></i>试卷管理</a>
				</div>
				
				<div class="pearls row" style="padding-top: 20px;">
					<div class="pearl current col-sm-2" data-pearl="pearl-1" data-step="1" style="margin-left: 8.33333333%;">
						<span class="pearl-number">1</span> 
						<span class="pearl-title">基本信息</span>
					</div>
 					<div class="pearl col-sm-2" data-pearl="pearl-2" data-step="2">
						<span class="pearl-number">2</span> 
						<span class="pearl-title">添加试题</span>
					</div>
					<div class="pearl col-sm-2" data-pearl="pearl-3" data-step="3">
						<span class="pearl-number">3</span> 
						<span class="pearl-title">添加考生</span>
					</div> 
					<div class="pearl col-sm-2" data-pearl="pearl-4" data-step="4">
						<span class="pearl-number">4</span> 
						<span class="pearl-title">试卷设置</span>
					</div>
					<div class="pearl col-sm-2" data-pearl="pearl-5" data-step="5">
						<span class="pearl-number">5</span> 
						<span class="pearl-title">预览</span>
					</div>
				</div>
				
				<div class="pearl-pane" id="pearl-1">
					<form class="form-horizontal" role="form" id="form-basic" autocomplete="off">
						<div class="form-group">
							<div class="col-sm-5 col-sm-offset-3">
								<h3 class="help-block">请填写试卷基本信息</h3>
							</div>
						</div>
					
						<div class="form-group">
							<label for="title" class="col-sm-3 control-label"><i class="form-required">*</i>试卷标题</label>
							<div class="col-sm-5">
								<input type="text" class="form-control" name="title">
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
								<textarea class="form-control" name="description" style="resize:none; height: 150px;"></textarea>
							</div>
						</div>
						
						<div class="hr-line-solid"></div>
						<div class="form-group btn-operate">
							<div class="col-sm-5 col-sm-offset-3">
								<button type="button" class="btn btn-primary btn-paper-add-next">保存并进入下一步</button>
								<button type="button" class="btn btn-white btn-paper-cancel">取&nbsp;消</button>
							</div>
						</div>
					</form>
				</div>
				
				<div class="pearl-pane hide" id="pearl-2">
					<h2 style="font-size: 18px;">添加试题到试卷中:<span class="paper-title" style="padding-left: 10px;"></span></h2>
					<div id="paper-question-table-toolbar" role="group" style="margin-top: 20px;">
						<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#modal-paper-question-dialog">
							<i class="fa fa-plus fa-fw"></i>添加试题
						</button>
						<button type="button" class="btn btn-white btn-paper-question-delete-batch" disabled="disabled">
	 						<i class="fa fa-trash-o fa-fw"></i>批量删除
	 					</button>
					</div>
					<table id="paper-question-table" class="table-hm" data-mobile-responsive="true"></table>
					<div style="margin-top: 20px;">
						<button type="button" class="btn btn-primary btn-paper-question-next">保存并进入下一步</button>
					</div>
				</div>
				
				<div class="pearl-pane hide" id="pearl-3">
					<h2 style="font-size: 18px;">添加参加该考试的考生:<span class="paper-title" style="padding-left: 10px;"></span></h2>
					<div id="paper-student-table-toolbar" role="group" style="margin-top: 20px;">
						<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#modal-paper-student-dialog">
							<i class="fa fa-plus fa-fw"></i>添加考生
						</button>
						<button type="button" class="btn btn-white btn-paper-student-delete-batch" disabled="disabled">
	 						<i class="fa fa-trash-o fa-fw"></i>批量删除
	 					</button>
					</div>
					<table id="paper-student-table" class="table-hm" data-mobile-responsive="true"></table>
					<div style="margin-top: 20px;">
						<button type="button" class="btn btn-primary btn-paper-student-next">保存并进入下一步</button>
					</div>
				</div>
				
				<div class="pearl-pane hide" id="pearl-4">
					<form class="form-horizontal" role="form" id="form-setting" autocomplete="off">
						<div class="form-group">
							<div class="col-sm-5 col-sm-offset-3">
								<h3 class="help-block">试卷设置</h3>
							</div>
						</div>
						
						<div class="form-group">
							<label for="status" class="col-sm-3 control-label">试卷状态</label>
							<div class="col-sm-5">
								<div class="radio radio-success radio-inline" style="width: 80px;">
									<input type="radio" name="status" id="status-enable" value="0" checked>
									<label for="status-enable">可用</label>
								</div>
								<div class="radio radio-success radio-inline" style="width: 80px;">
									<input type="radio" name="status" id="status-unable" value="1">
									<label for="status-unable">不可用</label>
								</div>
							</div>
						</div>
						
						<div class="form-group">
							<label for="paper-valid-time" class="col-sm-3 control-label">有效时间</label>
							<div class="col-sm-5">
								<div class="input-daterange input-group col-sm-8" id="paper-valid-time" style="width: 400px;">
									<input type="text" class="form-control" name="startTime" id="startTime">
									<span class="input-group-addon">到</span>
									<input type="text" class="form-control" name="endTime" id="endTime">
								</div>
							</div>
						</div>
						
						<div class="form-group">
							<label for="duration" class="col-sm-3 control-label">时间限制</label>
							<div class="col-sm-5">
								<input type="number" class="form-control" name="duration" min="0" value="30" style="width: 80px; display: inline-block;">&nbsp;&nbsp;分钟
							</div>
						</div>
						
						<div class="hr-line-solid"></div>
						<div class="form-group">
							<div class="col-sm-5 col-sm-offset-3">
								<button type="button" class="btn btn-primary btn-fw btn-paper-setting-next">完&nbsp;成</button>
							</div>
						</div>
					</form>
				</div>
				
				<div class="pearl-pane hide" id="pearl-5" style="width: 450px; margin: 0 auto;">
					<div style="background-image: url('img/paper-success.png'); height: 128px; line-height: 128px; text-indent: 140px; 
						color: #32cd32; font-size: 36px; background-repeat: no-repeat; text-transform: uppercase;">
						试卷创建成功
					</div>
					<div style="padding-top: 20px;">
						<h2>复制下面的连接并分享给您的考生</h2>
						<div>
							<pre class="url-share"></pre>
							<button type="button" class="btn btn-primary btn-copy" data-clipboard-text="">
								<i class="fa fa-copy fa-fw"></i>点击复制
							</button>
						</div>
					</div>
					<div style="margin-top: 20px;">
						<a href="${ctx}/paperList">返回试卷管理</a>
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
    <script type="text/javascript" src="${ctx}/plugins/clipboard/clipboard.min.js"></script>
    <script type="text/javascript" src="${ctx}/plugins/bootstrap-datepicker/js/bootstrap-datetimepicker.min.js"></script>
    <script type="text/javascript" src="${ctx}/plugins/bootstrap-datepicker/js/locales/bootstrap-datetimepicker.zh-CN.js"></script>
    
    <%@ include file="/WEB-INF/pages/question/dialog_question_detail.jsp"%>
    <%@ include file="/WEB-INF/pages/exam/dialog_question_add.jsp"%>
    <%@ include file="/WEB-INF/pages/exam/dialog_student_add.jsp"%>

	<script type="text/javascript">
	
		var $page = $('.body-paper-add');
		var paper;
		var $paperQuestionTable;
		var $paperStudentTable;
		var clipboard = new Clipboard('.btn-copy');
		
		$page
		.on('click', '.btn-paper-cancel', function() {
			window.location.href = '${ctx}/paperList';
		})
		.on('click', '.btn-paper-add-next', function() {
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
		.on('click', '.btn-paper-question-next', function() {
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
                            swal('', '删除成功!', 'success');
						} else {
                            swal('', ret.msg, 'error');
                        }
                        $paperQuestionTable.bootstrapTable('refresh'); 
                    },
                    error: function(err) {}
                });
            });
		})
		.on('click', '.btn-paper-student-next', function() {
			var $pearl = $page.find('#pearl-3');
			pearl($pearl);
		})
		.on('click', '.btn-paper-student-delete-batch', function() {
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
                            swal('', '删除成功!', 'success');
						} else {
                            swal('', ret.msg, 'error');
                        }
                        $paperStudentTable.bootstrapTable('refresh'); 
                    },
                    error: function(err) {}
                });
            });
		})
		.on('click', '.btn-paper-setting-next', function() {
			var $pearl = $page.find('#pearl-4');
			
			var starttime = $('#startTime').val();
			var endtime = $('#endTime').val();
			if (starttime > endtime) {
				toastr['error']('开始时间大于结束时间！');
				return;
			}
			
			var $form = $('#form-setting');
			var formData = new FormData($form[0]);
			
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
                		pearl($pearl);
                	}
                },
                error: function(err) {}
			});
		});
		
		function pearl($pearl) {
			var $step = $page.find("[data-pearl='"+ $pearl.attr('id') +"']");
			
			$page.find('.pearl').removeClass('current');
			$step.addClass('done');
			$step.next().addClass('current');
			
			var step = Number($step.data('step'));
			var currentStep = step + 1;
			if (currentStep == 2) {
				setPearl2();
			} else if (currentStep ==3) {
				setPearl3();
			} else if (currentStep == 4) {
				setPearl4();
			} else if (currentStep == 5) {
				var shareUrl = 'http://' + window.location.host + '${ctx}/online/' + paper.id;
				$page.find('.btn-copy').attr('data-clipboard-text', shareUrl);
				$page.find('.url-share').text(shareUrl);
			}
			
			$page.find('.pearl-pane').addClass('hide');
			$pearl.next().removeClass("hide");
		}
		
		function setPearl2() {
			$page.find('.paper-title').text(paper.title);
			
			$paperQuestionTable = $k.util.bsTable($page.find('#paper-question-table'), {
				url: '${ctx}/api/paper/question/list?paperId=' + paper.id,
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
	            					url: '${ctx}/api/paper/question/delete',
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
	            						$paperQuestionTable.bootstrapTable('refresh'); 
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
		}
		
		function setPearl3() {
			$paperStudentTable = $k.util.bsTable($page.find('#paper-student-table'), {
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
					width: '100',
					formatter: function(value, row, index) {
						var $delete = '<a class="btn-student-delete a-operate">删除</a>';
						return $delete;
					},
					events: window.operateEvents = {
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
	            					url: '${ctx}/api/paper/student/delete',
	            					data: {
	            						paperId: paper.id,
	            						studentId: row.id
	            					},
	            					success: function(ret) {
	            						if (ret.code == 0) {
	            							swal('', '删除成功!', 'success');
	            						} else {
	            							swal('', ret.msg, 'error');
	            						}
	            						$paperStudentTable.bootstrapTable('refresh'); 
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
		}
		
		function setPearl4() {
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
			
			// 初始化时间
			var start = new Date().Format("yyyy-MM-dd") + ' 00:00'; 
			var end = new Date().Format("yyyy-MM-dd") + ' 23:59'; 
			$('#startTime').val(start);
			$('#endTime').val(end);
		}
		
	</script>

</body>
</html>