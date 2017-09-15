<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/include/preload.jsp"%>

<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	
	<title>新增考生</title>
	
	<link rel="stylesheet" type="text/css" href="${ctx}/plugins/bootstrap/3.3.6/css/bootstrap.min.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/plugins/font-awesome/4.7.0/css/font-awesome.min.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/plugins/animate/animate.min.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/plugins/sweetalert/sweetalert.css">
	
	<link rel="stylesheet" type="text/css" href="${ctx}/plugins/hplus/style.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/local/common.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/plugins/toastr/toastr.min.css">
	
</head>

<body class="gray-bg body-student-add">
	<div class="wrapper wrapper-content animated fadeInRight">
		<div class="ibox">
			<div class="ibox-content">
				<h2 class="page-title">${title}</h2>
				
				<form class="form-horizontal" role="form" autocomplete="off">
					<div class="hr-line-dashed"></div>
					<div class="form-group">
						<label for="groupId" class="col-sm-2 control-label">分组</label>
                        <div class="col-sm-4">
                        	<select class="form-control" name="groupId" required>
                        		<c:forEach var="group" items="${groupList}">
                        			<option value="${group.id}">${group.name}</option>
                        		</c:forEach>
                        	</select>
                        </div>
					</div>
					
					<div class="hr-line-dashed"></div>
					<div class="form-group btn-operate">
                        <div class="col-sm-8 col-sm-offset-2">
                        	<c:if test="${method == 'add'}">
                            	<button type="button" class="btn btn-primary btn-student-add-continue">保存并继续</button>
                            	<button type="button" class="btn btn-primary btn-student-add">保存</button>
                            </c:if>
                            <c:if test="${method == 'edit'}">
                            	<button type="button" class="btn btn-primary btn-student-edit">保存</button>
                            </c:if>
                            <button type="button" class="btn btn-white btn-student-cancel">返回</button>
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
		
		var $page = $('.body-student-add');
		var $form = $page.find('form');
		var method = '${method}';
		var type = 1;
		var arr = ['A', 'B', 'C', 'D', 'E', 'F'];
		
		if (method == 'edit') {
			$page.find('select[name="groupId"]').val(${student.group.id});
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
		.on('click', '.btn-student-add-continue', function() {
			if (validate()) {
				var formData = new FormData($form[0]); 
				formData.append('type', type);
				
				$.ajax({
					url: '${ctx}/api/student/create',
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
                                window.location.href = './studentAdd?type=' + type + '&method=add';
                            });
                    	} else {
                    		swal('', ret.msg, 'error');
                    	}
	                },
	                error: function(err) {}
				});
			}
		})
		.on('click', '.btn-student-add', function() {
			if (validate()) {
				var formData = new FormData($form[0]); 
				formData.append('type', type);
				
				$.ajax({
					url: '${ctx}/api/student/create',
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
                                window.location.href = './studentList';
                            });
                    	} else {
                    		swal('', ret.msg, 'error');
                    	}
	                },
	                error: function(err) {}
				});
			}
		})
		.on('click', '.btn-student-edit', function() {
			if (validate()) {
				var formData = new FormData($form[0]); 
				formData.append('studentId', '${student.id}');
				
				$.ajax({
					url: '${ctx}/api/student/update',
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
                                window.location.href = './studentList';
                            });
                    	} else {
                    		swal('', ret.msg, 'error');
                    	}
	                },
	                error: function(err) {}
				});
			}
		})
		.on('click', '.btn-student-cancel', function() {
			window.location.href = '${ctx}/studentList';
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