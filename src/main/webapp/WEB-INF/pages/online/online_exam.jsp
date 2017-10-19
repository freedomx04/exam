<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/include/preload.jsp"%>

<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <title>${paper.title}</title>
    
    <link rel="stylesheet" type="text/css" href="${ctx}/plugins/bootstrap/3.3.6/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/plugins/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/plugins/awesome-bootstrap-checkbox/awesome-bootstrap-checkbox.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/plugins/animate/animate.min.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/plugins/sweetalert/sweetalert.css">
    
    <link rel="stylesheet" type="text/css" href="${ctx}/plugins/hplus/style.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/local/common.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/plugins/toastr/toastr.min.css">
    
    <style type="text/css">
    .fixed {
    	position: fixed;
    	z-index: 2;
    	-webkit-font-smoothing: subpixel-antialiased;
    }
    .exam-banner {
    	top: 0; 
    	left: 0; 
    	width: 100%; 
    	z-index: 100;
    	background: #fff;
    	border-bottom: 1px solid rgba(30,35,42,.06);
    	-webkit-box-shadow: 0 1px 3px 0 rgba(0,34,77,.05);
    	box-shadow: 0 1px 3px 0 rgba(0,34,77,.05);
    	background-clip: content-box;
    }
    .exam-banner-inner {
    	position: relative;
    	display: flex;
    	width: 1000px;
    	height: 52px;
    	padding: 0 16px;
    	margin: 0 auto;
    	-webkit-box-align: center;
    	align-items: center;
    }
    .exam-banner-holder {
    	position: relative;
    	top: 0px;
    	right: 0px;
    	bottom: 0px;
    	left: 0px;
    	display: block;
    	float: none;
    	margin: 0;
    	height: 53px;
    	visibility: hidden;
    }
    .card {
    	margin-bottom: 10px;
    	background: #fff;
    	overflow: hidden;
    	border-radius: 2px;
    	-webkit-box-shadow: 0 1px 3px rgba(0,0,0,.1);
    	box-shadow: 0 1px 3px rgba(0,0,0,.1);
    	-webkit-box-sizing: border-box;
    	box-sizing: border-box;
    }
    .exam-container {
    	display: -webkit-box;
    	display: flex;
    	-webkit-box-align: start;
    	align-items: flex-start;
    	position: relative;
    	width: 1000px;
    	margin: 10px auto;
    }
    .exam-ques {
    	position: relative;
    	padding: 16px 20px;
    }
    .exam-ques .ques-num {
    	font-size: 14px;
    	background-color: #36aafd;
    	color: #fff;
    	border-radius: 10px;
    	padding: 2px 8px;
    }
    .exam-ques ul li {
    	height: 30px;
    }
    .exam-ques .ques-score {
    	color: #aeaeae;
    }
    .exam-controller .ques-list li {
    	font-size: 12px;
    	text-align: center;
    	display: block;
    	padding: 4px 0px;
    	border: 1px solid #aaa;
    	border-radius: 2px;
    	float: left;
    	margin-right: 3px;
    	margin-bottom: 3px;
    	min-width: 25px;
    	cursor: pointer;
    }
    .exam-controller .ques-list li.done, 
    .exam-controller .ques-list li:HOVER {
		background-color: #FF7B29;
		color: #fff;
		border: 1px solid #FF7B29;
	}
	.card-control {
		display: flex; 
		flex-direction: column; 
		padding: 10px;
	}
	.card-title {
		color: #676a6c;
		margin-bottom: 15px;
	}
	.corner-buttons {
		position: fixed;
		width: 100px;
		bottom: 10px;
		display: flex;
		flex-direction: column;
	}
	.corner-container {
		width: 40px;
	}
	.corner-btn {
		margin-top: 10px;
		padding: 0px;
		color: #999;
		background: #fff;
		border-radius: 4px;
		width: 40px;
		height: 40px;
		-webkit-box-shadow: 0 1px 3px rgba(0,0,0,.1);
		box-shadow: 0 1px 3px rgba(0,0,0,.1);
	}
	.corner-btn:HOVER,
	.corner-btn:FOCUS {
		color: #999;
		background: #d5dbe7;
	}
    </style>
    
</head>
<body class="gray-bg body-online-exam" style="min-width: 1000px; overflow: auto;">
	<div>
		<header role="banner" class="exam-banner fixed">
			<div class="exam-banner-inner">
				<div style="font-size: 18px;">${paper.title}</div>
				<div style="flex: 1; justify-content: flex-end; display: flex; align-items: center;">
					<i class="fa fa-user fa-fw"></i>孙明明
				</div>
			</div>
		</header>
		<div class="exam-banner-holder"></div>
	</div>
	
	<main role="main">
		<div class="exam-container">
			<div class="exam-ques-list" style="margin-right: 10px; width: 690px;">
				<c:forEach var="question" items="${paper.questions}" varStatus="status">
					<c:set var="seq" value="${status.index + 1}"></c:set>
					<div id="ques-${status.index + 1}" class="card exam-ques" data-index="${seq}" data-question-id="${question.id}">
						<div style="line-height: 1.6em;">
							<span class="ques-num">${status.index + 1}/${fn:length(paper.questions)}</span>
							<c:if test="${question.type == 1}">
								<span class="ques-type ques-single">单选题</span>
							</c:if>
							
							<c:if test="${question.type == 2}">
								<span class="ques-type ques-multiple">多选题</span>
							</c:if>
							
							<c:if test="${question.type == 3}">
								<span class="ques-type ques-boolean">判断题</span>
							</c:if>
							<span>${question.title}</span>
							<span class="ques-score">(${question.score}分)</span>
						</div>
						<div>
							<c:if test="${not empty question.imagePath}">
								<div style="margin: 10px 20px;">
									<img alt="图片" src="${ctx}${question.imagePath}">
								</div>
							</c:if>
							<ul class="unstyled" style="margin-top: 15px; padding-left: 20px;">
								<c:choose>
									<c:when test="${question.type == 1}">
										<li>
											<div class="radio radio-success radio-inline">
												<input type="radio" name="options-${seq}" id="options-${seq}-A" value="A">
												<label for="options-${seq}-A">A：${question.optionA}</label>
											</div>
										</li>
										<li>
											<div class="radio radio-success radio-inline">
												<input type="radio" name="options-${seq}" id="options-${seq}-B" value="B">
												<label for="options-${seq}-B">B：${question.optionB}</label>
											</div>
										</li>
										<c:if test="${not empty question.optionC}">
											<li>
												<div class="radio radio-success radio-inline">
													<input type="radio" name="options-${seq}" id="options-${seq}-C" value="C">
													<label for="options-${seq}-C">C：${question.optionC}</label>
												</div>
											</li> 
										</c:if>
										<c:if test="${not empty question.optionD}">
											<li>
												<div class="radio radio-success radio-inline">
													<input type="radio" name="options-${seq}" id="options-${seq}-D" value="D">
													<label for="options-${seq}-D">D：${question.optionD}</label>
												</div>
											</li> 
										</c:if>
										<c:if test="${not empty question.optionE}">
											<li>
												<div class="radio radio-success radio-inline">
													<input type="radio" name="options-${seq}" id="options-${seq}-E" value="E">
													<label for="options-${seq}-E">E：${question.optionE}</label>
												</div>
											</li> 
										</c:if>
										<c:if test="${not empty question.optionF}">
											<li>
												<div class="radio radio-success radio-inline">
													<input type="radio" name="options-${seq}" id="options-${seq}-F" value="F">
													<label for="options-${seq}-F">F：${question.optionF}</label>
												</div>
											</li>
										</c:if>
									</c:when>
									<c:when test="${question.type == 2}">
										<li>
											<div class="checkbox checkbox-success checkbox-inline">
												<input type="checkbox" name="options-${seq}" id="options-${seq}-A" value="A">
												<label for="options-${seq}-A">A：${question.optionA}</label>
											</div>
										</li>
										<li>
											<div class="checkbox checkbox-success checkbox-inline">
												<input type="checkbox" name="options-${seq}" id="options-${seq}-B" value="B">
												<label for="options-${seq}-B">B：${question.optionB}</label>
											</div>
										</li>
										<c:if test="${not empty question.optionC}">
											<li>
												<div class="checkbox checkbox-success checkbox-inline">
													<input type="checkbox" name="options-${seq}" id="options-${seq}-C" value="C">
													<label for="options-${seq}-C">C：${question.optionC}</label>
												</div>
											</li>
										</c:if>
										<c:if test="${not empty question.optionD}">
											<li>
												<div class="checkbox checkbox-success checkbox-inline">
													<input type="checkbox" name="options-${seq}" id="options-${seq}-D" value="D">
													<label for="options-${seq}-D">D：${question.optionD}</label>
												</div>
											</li>
										</c:if>
										<c:if test="${not empty question.optionE}">
											<li>
												<div class="checkbox checkbox-success checkbox-inline">
													<input type="checkbox" name="options-${seq}" id="options-${seq}-E" value="E">
													<label for="options-${seq}-E">E：${question.optionE}</label>
												</div>
											</li>
										</c:if>
										<c:if test="${not empty question.optionF}">
											<li>
												<div class="checkbox checkbox-success checkbox-inline">
													<input type="checkbox" name="options-${seq}" id="options-${seq}-F" value="F">
													<label for="options-${seq}-F">F：${question.optionF}</label>
												</div>
											</li>
										</c:if>
									</c:when>
									<c:when test="${question.type == 3}">
										<li>
											<div class="radio radio-success radio-inline">
												<input type="radio" name="options-${seq}" id="options-${seq}-A" value="A">
												<label for="options-${seq}-A">正确</label>
											</div>
										</li>
										<li>
											<div class="radio radio-success radio-inline">
												<input type="radio" name="options-${seq}" id="options-${seq}-B" value="B">
												<label for="options-${seq}-B">错误</label>
											</div>
										</li> 
									</c:when>
								</c:choose>
							</ul>
						</div>
					</div>
				</c:forEach> 
			</div>
			
			<div class="exam-controller fixed" style="width: 300px; color: #999;">
				<div class="card card-control text-center">
					<div><i class="fa fa-clock-o fa-fw fa-2x"></i></div>
					<div>总剩余时间</div>
					<div style="font-size: 16px;">08:15</div>
					<div style="padding: 10px;">
						<button type="button" class="btn btn-primary btn-submit" style="width: 100%;">提交试卷</button>
					</div>
				</div>
			
				<div class="card card-control">
					<label class="card-title">题卡</label>
					<div>
						<ul class="unstyled ques-list" style="padding: 0;">
							<c:forEach var="question" items="${paper.questions}" varStatus="status">
								<li class="ques-link" data-index="${status.index + 1}">${status.index + 1}</li>
							</c:forEach>
						</ul>
					</div>
					<div class="ques-list-tips text-center" style="margin-top: 10px;">
						<span>已做&nbsp;<i class="fa fa-square tips-done" style="color: #FF7B29;"></i></span>
						<span>未做&nbsp;<i class="fa fa-square-o tips-undone"></i></span>
					</div>
				</div>
				
				<div class="card card-control">
					<label class="card-title">考试描述</label>
					<c:if test="${not empty paper.description}">
						<div>${paper.description}</div>
					</c:if>
					<c:if test="${empty paper.description}">
						<div>无</div>
					</c:if>
				</div>
			</div> 
		</div>
	</main>
	
	<div class="corner-buttons">
		<div class="corner-container btn-feedback" data-toggle="tooltip" data-placement="top" title="建议反馈">
			<button type="button" class="btn corner-btn">
				<i class="fa fa-edit fa-lg"></i>
			</button>
		</div>
	
		<div class="corner-container btn-top hide" data-toggle="tooltip" data-placement="top" title="回到顶部">
			<button type="button" class="btn corner-btn">
				<i class="fa fa-chevron-up fa-lg"></i>
			</button>
		</div>
	</div>
	
	<div class="modal" id="modal-submit-dialog" tabindex="-1" role="dialog" aria-hidden="true" data-backdrop="static" style="top: 200px;">
		<div class="modal-dialog">
			<div class="modal-content animated fadeInDown">
				<div class="modal-body text-center">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true" style="font-size: 30px;">×</span><span class="sr-only">Close</span>
					</button>
					<h4 style="font-size: 24px; font-weight: 100;">提交试卷</h4>
					
					<div style="margin-top: 20px;">
						<button type="button" class="btn btn-blue btn-submit-submit" style="width: 200px;">提&nbsp;&nbsp;交</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<div class="modal" id="modal-feedback-dialog" tabindex="-1" role="dialog" aria-hidden="true" data-backdrop="static" style="top: 200px;">
		<div class="modal-dialog">
			<div class="modal-content animated fadeInDown">
				<div class="modal-body text-center">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true" style="font-size: 30px;">×</span><span class="sr-only">Close</span>
					</button>
					<h4 style="font-size: 24px; font-weight: 100;">提交反馈</h4>
					<textarea class="form-control textarea-feedback" style="height: 120px; resize: none; margin-top: 20px;" placeholder="告诉我们你的建议或遇到的问题。"></textarea>
					<div style="margin-top: 20px;">
						<button type="button" class="btn btn-blue btn-feedback-submit" style="width: 200px;">提&nbsp;&nbsp;交</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<script type="text/javascript" src="${ctx}/plugins/jquery/2.1.4/jquery.min.js"></script>
	<script type="text/javascript" src="${ctx}/plugins/bootstrap/3.3.6/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="${ctx}/plugins/hplus/content.min.js"></script>
	<script type="text/javascript" src="${ctx}/local/common.js"></script>
	
	<script type="text/javascript">
	
		var paperId = '${paper.id}';
		var studentId = '1';
		
		var $page = $('.body-online-exam');
		var $submit = $page.find('#modal-submit-dialog');
		var $feedback = $page.find('#modal-feedback-dialog');
		
		// tooltip
		$page.find('[data-toggle="tooltip"]').tooltip();
		
		setController();
		window.onresize = function() {
			setController();
		}
		
		// 回到顶部按钮
		var $top = $page.find('.btn-top');
		$(window).scroll(function() {
			if ($(window).scrollTop() > 800) {
				$top.removeClass('hide');
			} else {
				$top.addClass('hide');
			}
		});
		
		function setController() {
			var $controller = $page.find('.exam-controller');
			var $corner = $page.find('.corner-buttons');
			var $width = $(document).width();
			var left_val = ($width - 1000) / 2 + 690 + 10;
			$controller.css('left', left_val);
			$corner.css('left', left_val);
		}
		
		$page
		.on('change', '.exam-ques input', function() {
			var $this = $(this);
			var inputName = $this.attr('name');
			
			var val;
			var type = $this.attr('type');
			if (type == 'radio') {
				val = $page.find('input[name="' + inputName + '"]:checked').val();
			} else if (type == 'checkbox') {
				var checked = [];
				$page.find('input[name="' + inputName + '"]:checked').each(function() {
					checked.push($(this).val());
				});
				val = checked.toString();
			}
			
			var index = $this.closest('.exam-ques').data('index');
			if (val) {
				$page.find('.ques-link[data-index="' + index + '"]').addClass('done');
			} else {
				$page.find('.ques-link[data-index="' + index + '"]').removeClass('done');
			}
		})
		.on('click', '.ques-link', function() {
			var index = $(this).text();
			var offset = $page.find('#ques-' + index).offset().top - 62;
			$('html,body').animate({
				scrollTop: offset
			}, 1000);
		})
		.on('click', '.btn-submit', function() {
			$submit.modal('show');
		})
		.on('click', '.btn-submit-submit', function() {
			
		})
		.on('click', '.btn-feedback', function() {
			$feedback.modal('show');
		})
		.on('click', '.btn-feedback-submit', function() {
			var content = $feedback.find('.textarea-feedback').val();
			if (!content) {
				$feedback.find('.textarea-feedback').css('border', '1px solid #f75659');
				return;
			} else {
				$feedback.find('.textarea-feedback').css('border', '1px solid #e5e6e7');
				$.ajax({
					url: '${ctx}/api/feedback/create',
					type: 'post',
					data: {
						paperId: paperId,
						studentId: studentId,
						content: content
					},
					success: function(ret) {
						if (ret.code == 0) {
							$feedback.modal('hide');
						}
					},
					error: function(err) {}
				});
			}
		})
		.on('hidden.bs.modal', '#modal-feedback-dialog', function() {
			$feedback.find('.textarea-feedback').val('');
        }) 
		.on('click', '.btn-top', function() {
			$('html, body').animate({scrollTop: 0}, 1000);
		});
	
	</script>
	
</body>
</html>