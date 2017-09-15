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
						<label for="" class="col-sm-2 control-label">正确答案</label>
						<div class="col-sm-7">
							<div class="radio radio-success radio-inline">
								<input type="radio" name="answer" id="A" value="A">
								<label for="A">正确</label>
							</div>
							
							<div class="radio radio-success radio-inline">
								<input type="radio" name="answer" id="B" value="B">
								<label for="B">错误</label>
							</div>
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
		var type = 3;
		
		if (method == 'edit') {
			$page.find('select[name="libraryId"]').val(${question.library.id});
			$page.find('input[type="radio"][value="${question.answer}"]').attr('checked', 'checked');
		}
		
		$page
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
			return result;
		}
		
	})( jQuery );
	</script>
    
</body>
</html>