<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/include/preload.jsp"%>

<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	
	<title>新增试题</title>
	
	<link rel="stylesheet" type="text/css" href="${ctx}/plugins/bootstrap/3.3.6/css/bootstrap.min.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/plugins/font-awesome/4.7.0/css/font-awesome.min.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/plugins/awesome-bootstrap-checkbox/awesome-bootstrap-checkbox.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/plugins/animate/animate.min.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/plugins/sweetalert/sweetalert.css">
	
	<link rel="stylesheet" type="text/css" href="${ctx}/plugins/hplus/style.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/local/common.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/plugins/toastr/toastr.min.css">
	
	<style type="text/css">
	.body-question-add .input-group-addon {
		background-color: #f5f5f5; 
		padding: 0 0 0 10px;
	}
	.body-question-add .btn-operate button {
		min-width: 100px;
	}
	.body-question-add .spinner input {
		width: 100px;
	}
	</style>
	
</head>

<body class="gray-bg body-question-add">
	<div class="wrapper wrapper-content animated fadeInRight">
		<div class="ibox">
			<div class="ibox-content">
				<h2 class="page-title">${title}<small>${typeTitle}</small></h2>
				
				<form class="form-horizontal" role="form" autocomplete="off">
					<div class="hr-line-dashed"></div>
					<div class="form-group">
						<label for="libraryId" class="col-sm-2 control-label">题库</label>
                        <div class="col-sm-4">
                        	<select class="form-control" name="libraryId" required>
                        		<c:forEach var="library" items="${libraryList}">
                        			<option value="${library.id}">${library.name}</option>
                        		</c:forEach>
                        	</select>
                        </div>
					</div>
					
					<div class="form-group">
						<label for="title" class="col-sm-2 control-label">题干</label>
						<div class="col-sm-7">
							<textarea class="form-control" name="title" style="resize: none; height: 150px;">${question.title}</textarea>
						</div>
					</div>
					
					<div class="form-group">
						<label for="optionA" class="col-sm-2 control-label">选项A</label>
						<div class="col-sm-7">
							<div class="input-group">
								<input type="text" class="form-control option" name="optionA" seq="0" value="${question.optionA}">
								<div class="input-group-addon">
									<div class="radio radio-success radio-inline">
										<input type="radio" name="answer" id="A" value="A">
										<label for="A">正确答案</label>
									</div>
								</div>
							</div>
						</div>
					</div>
					
					<div class="form-group">
						<label for="optionB" class="col-sm-2 control-label">选项B</label>
						<div class="col-sm-7">
							<div class="input-group">
								<input type="text" class="form-control option" name="optionB" seq="1" value="${question.optionB}">
								<div class="input-group-addon">
									<div class="radio radio-success radio-inline">
										<input type="radio" name="answer" id="B" value="B">
										<label for="B">正确答案</label>
									</div>
								</div>
							</div>
						</div>
					</div>
					
					<c:if test="${method == 'add' || not empty question.optionC}">
					<div class="form-group">
						<label for="optionC" class="col-sm-2 control-label">选项C</label>
						<div class="col-sm-7">
							<div class="input-group">
								<input type="text" class="form-control option" name="optionC" seq="2" value="${question.optionC}">
								<div class="input-group-addon">
									<div class="radio radio-success radio-inline">
										<input type="radio" name="answer" id="C" value="C">
										<label for="C">正确答案</label>
									</div>
								</div>
							</div>
						</div>
						<div class="col-sm-1" style="padding-left: 0;">
							<button type="button" class="btn btn-white btn-option-delete" title="删除选项">
								<i class="fa fa-trash-o"></i>
							</button>
						</div>
					</div>
					</c:if>
					
					<c:if test="${method == 'add' || not empty question.optionD}">
					<div class="form-group">
						<label for="optionD" class="col-sm-2 control-label">选项D</label>
						<div class="col-sm-7">
							<div class="input-group">
								<input type="text" class="form-control option" name="optionD" seq="3" value="${question.optionD}">
								<div class="input-group-addon">
									<div class="radio radio-success radio-inline">
										<input type="radio" name="answer" id="D" value="D">
										<label for="D">正确答案</label>
									</div>
								</div>
							</div>
						</div>
						<div class="col-sm-1" style="padding-left: 0;">
							<button type="button" class="btn btn-white btn-option-delete" title="删除选项">
								<i class="fa fa-trash-o"></i>
							</button>
						</div>
					</div>
					</c:if>
					
					<c:if test="${not empty question.optionE}">
					<div class="form-group">
						<label for="optionE" class="col-sm-2 control-label">选项E</label>
						<div class="col-sm-7">
							<div class="input-group">
								<input type="text" class="form-control option" name="optionE" seq="4" value="${question.optionE}">
								<div class="input-group-addon">
									<div class="radio radio-success radio-inline">
										<input type="radio" name="answer" id="E" value="E">
										<label for="E">正确答案</label>
									</div>
								</div>
							</div>
						</div>
						<div class="col-sm-1" style="padding-left: 0;">
							<button type="button" class="btn btn-white btn-option-delete" title="删除选项">
								<i class="fa fa-trash-o"></i>
							</button>
						</div>
					</div>
					</c:if>
					
					<c:if test="${not empty question.optionF}">
					<div class="form-group">
						<label for="optionF" class="col-sm-2 control-label">选项F</label>
						<div class="col-sm-7">
							<div class="input-group">
								<input type="text" class="form-control option" name="optionF" seq="5" value="${question.optionF}">
								<div class="input-group-addon">
									<div class="radio radio-success radio-inline">
										<input type="radio" name="answer" id="F" value="F">
										<label for="F">正确答案</label>
									</div>
								</div>
							</div>
						</div>
						<div class="col-sm-1" style="padding-left: 0;">
							<button type="button" class="btn btn-white btn-option-delete" title="删除选项">
								<i class="fa fa-trash-o"></i>
							</button>
						</div>
					</div>
					</c:if>
					
					<div class="form-group">
						<div class="col-sm-9 text-right">
							<button type="button" class="btn btn-primary btn-option-add">新增选项</button>
						</div>
					</div>
					
					<div class="form-group" style="margin: 20px 0 5px;">
						<div class="col-sm-4 col-sm-offset-2">
							<label style="color: #36964d;">其他选项...</label>
						</div>
					</div>
					
					<div class="form-group">
						<label for="analysis" class="col-sm-2 control-label">解析</label>
						<div class="col-sm-7">
							<textarea class="form-control" name="analysis" style="resize: none; height: 150px;">${question.analysis}</textarea>
						</div>
					</div>
					
					<div class="form-group">
						<label for="score" class="col-sm-2 control-label">分数</label>
						<div class="col-sm-2 spinner" style="display: table;">
							<c:if test="${method == 'add'}">
								<input type="text" class="form-control" value="0" name="score" onKeyUp="value=value.replace(/[^\d]/g, '0')">
							</c:if>
							<c:if test="${method == 'edit'}">
								<input type="text" class="form-control" value="${question.score}" name="score" onKeyUp="value=value.replace(/[^\d]/g, '0')">
							</c:if>
							<div class="input-group-btn-vertical">  
								<button class="btn btn-white" type="button"><i class="fa fa-caret-up"></i></button>  
						      	<button class="btn btn-white" type="button"><i class="fa fa-caret-down"></i></button>  
						    </div> 
						</div>
					</div>
					
					<div class="hr-line-dashed"></div>
					<div class="form-group btn-operate">
                        <div class="col-sm-8 col-sm-offset-2">
                        	<c:if test="${method == 'add'}">
                            	<button type="button" class="btn btn-primary btn-question-add-continue">保存并继续</button>
                            	<button type="button" class="btn btn-primary btn-question-add">保存</button>
                            </c:if>
                            <c:if test="${method == 'edit'}">
                            	<button type="button" class="btn btn-primary btn-question-edit">保存</button>
                            </c:if>
                            <button type="button" class="btn btn-white btn-question-cancel">返回</button>
                        </div>
                    </div>
				</form>
			</div>
		</div>
	</div>
	
	<script type="text/javascript" src="${ctx}/plugins/jquery/2.1.4/jquery.min.js"></script>
	<script type="text/javascript" src="${ctx}/plugins/bootstrap/3.3.6/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="${ctx}/plugins/hplus/content.min.js"></script>
	<script type="text/javascript" src="${ctx}/local/common.js"></script>
	
	<script type="text/javascript" src="${ctx}/plugins/sweetalert/sweetalert.min.js"></script>
    <script type="text/javascript" src="${ctx}/plugins/toastr/toastr.min.js"></script>
    
    <script type="text/javascript">
	;(function( $ ) {
		
		var $page = $('.body-question-add');
		var $form = $page.find('form');
		var method = '${method}';
		var type = 1;
		var arr = ['A', 'B', 'C', 'D', 'E', 'F'];
		
		if (method == 'edit') {
			$page.find('select[name="libraryId"]').val(${question.library.id});
			$page.find('input[type="radio"][value="${question.answer}"]').attr('checked', 'checked');
			
			var optionF = '${question.optionF}';
			if (optionF) {
				$page.find('.btn-option-add').addClass('hide');
			}
		}
		
		$page
		.on('click', '.btn-option-add', function() {
			var $last = $page.find('.option').last();
			var seq = $last.attr('seq');
			var next = parseInt(seq) + 1;
			var option = arr[next];
			
			if (next == (arr.length - 1)) {
				$(this).addClass('hide');
			}
			
			var $row = $(this).closest('.form-group');
			var $option = 
				'<div class="form-group">' + 
					'<label for="" class="col-sm-2 control-label">选项' + option + '</label>' +
					'<div class="col-sm-7">' + 
						'<div class="input-group">' +
							'<input type="text" class="form-control option" name="option' + option + '" seq="' + next + '">' + 
							'<div class="input-group-addon">' + 
								'<div class="radio radio-success radio-info radio-inline">' +
									'<input type="radio" name="answer" id="' + option + '" value="' + option + '">' +
									'<label for="' + option + '">正确答案</label>' + 
								'</div>' +
							'</div>' +
						'</div>' +
					'</div>' +
					'<div class="col-sm-1" style="padding-left: 0;">' +
						'<button type="button" class="btn btn-white btn-option-delete" title="删除选项">' +
							'<i class="fa fa-trash-o"></i>' +
						'</button>' +
					'</div>' +
				'</div>';
			$row.before($option); 
		})
		.on('click', '.btn-option-delete', function() {
			$(this).closest('.form-group').remove();
			
			var $btnAdd = $page.find('.btn-option-add');
			if ($btnAdd.hasClass('hide')) {
				$btnAdd.removeClass('hide');
			}
		})
		.on('click', '.btn-question-add-continue', function() {
			if (validate()) {
				var formData = new FormData($form[0]); 
				formData.append('type', type);
				
				$.ajax({
					url: '${ctx}/api/question/create',
					type: 'post',
					data: formData,
	        		processData: false,
	                contentType: false,
	                cache: false, 
	                success: function(ret) {
	                	if (ret.code == 0) {
                    		swal({
                                title: '',
                                text: '操作成功',
                                type: 'success'
                            }, function() {
                                window.location.href = './questionAdd?type=' + type + '&method=add';
                            });
                    	} else {
                    		swal('', ret.msg, 'error');
                    	}
	                },
	                error: function(err) {}
				});
			}
		})
		.on('click', '.btn-question-add', function() {
			if (validate()) {
				var formData = new FormData($form[0]); 
				formData.append('type', type);
				
				$.ajax({
					url: '${ctx}/api/question/create',
					type: 'post',
					data: formData,
	        		processData: false,
	                contentType: false,
	                cache: false, 
	                success: function(ret) {
	                	if (ret.code == 0) {
                    		swal({
                                title: '',
                                text: '操作成功',
                                type: 'success'
                            }, function() {
                                window.location.href = './questionList';
                            });
                    	} else {
                    		swal('', ret.msg, 'error');
                    	}
	                },
	                error: function(err) {}
				});
			}
		})
		.on('click', '.btn-question-edit', function() {
			if (validate()) {
				var formData = new FormData($form[0]); 
				formData.append('questionId', '${question.id}');
				
				$.ajax({
					url: '${ctx}/api/question/update',
					type: 'post',
					data: formData,
	        		processData: false,
	                contentType: false,
	                cache: false, 
	                success: function(ret) {
	                	if (ret.code == 0) {
                    		swal({
                                title: '',
                                text: '操作成功',
                                type: 'success'
                            }, function() {
                                window.location.href = './questionList';
                            });
                    	} else {
                    		swal('', ret.msg, 'error');
                    	}
	                },
	                error: function(err) {}
				});
			}
		})
		.on('click', '.btn-question-cancel', function() {
			window.location.href = '${ctx}/questionList';
		})
		.on('click', '.spinner .btn:first-of-type', function() {  
			var score = $page.find('.spinner input').val();
			$page.find('.spinner input').val(parseInt(score, 10) + 1);  
		})
		.on('click', '.spinner .btn:last-of-type', function() {  
			var score = $page.find('.spinner input').val();
			if (score == 0) {
				$page.find('.spinner input').val(0);
			} else {
				$page.find('.spinner input').val(parseInt(score, 10) - 1);  
			}
		}); 
		
		// 表单验证
		function validate() {
			var result = true;
			
			if ($form.find('textarea[name="title"]').val() == '') {
				toastr['error']('请填写题干！');
				return false;
			}
			
			if ($form.find('input[name="answer"]:checked').val() == undefined) {
				toastr['error']('请勾选正确答案！');
				return false;
			}
			
			$.each($form.find('.option'), function(k, option) {
				if ($(option).val() == '') {
					toastr['error']('请填写选项！');
					result = false;
					return false;
				}
			});
			return result;
		}
		
	})( jQuery );
	</script>
    
</body>
</html>