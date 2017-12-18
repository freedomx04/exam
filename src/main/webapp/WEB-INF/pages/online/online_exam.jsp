<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/include/preload.jsp"%>

<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
   	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1, user-scalable=no">
    
    <title>${paper.title}</title>
    
    <link rel="stylesheet" type="text/css" href="${ctx}/plugins/bootstrap/3.3.6/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/plugins/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/plugins/awesome-bootstrap-checkbox/awesome-bootstrap-checkbox.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/plugins/animate/animate.min.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/plugins/sweetalert/sweetalert.css">
    
    <link rel="stylesheet" type="text/css" href="${ctx}/plugins/hplus/style.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/plugins/toastr/toastr.min.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/local/common.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/local/online2.css">
    
    <style type="text/css">
    .exam-controller .card {
    	padding: 15px;
    }
    .exam-controller .ques-list li {
	  	font-size: 14px;
	  	text-align: center;
	  	display: block;
	  	padding: 4px;
	  	border: 1px solid #aaa;
	  	border-radius: 2px;
	  	float: left;
	  	margin-right: 4px;
	  	margin-bottom: 6px;
	  	min-width: 26px;
	  	cursor: pointer;
	  }
	.exam-controller .ques-list li.done, 
	.exam-controller .ques-list li:HOVER {
		background-color: #FF7B29;
		color: #fff;
		border: 1px solid #FF7B29;
	}
	.affix {
		position: fixed;
		top: 70px;
	}
	@media (min-width: 768px) {
		.affix {
			width: 229.98px;
		}
	}
	@media (min-width: 992px) {
		.affix {
			width: 303.33px;
		}
	}
	@media (min-width: 1200px) {
		.affix {
			width: 370px;
		}
	}
    </style>
    
</head>
<body class="gray-bg body-online-exam">
	<header class="navbar navbar-static-top nav-exam" id="top" style="position: fixed; width: 100%; border-bottom: 1px solid #e7eaec;">
		<div class="container" style="padding: 0;">
			<div class="navbar-brand">${paper.title}</div>
			<div class="navbar-brand pull-right visible-xs">
				<i class="fa fa-clock-o"></i>
				<span class="countdown" style="color: #ed5565;"></span>
			</div>
		</div>
	</header>
	
	<div class="container" style="padding: 0;">
		<div class="row" style="margin-top: 70px;">
			<div class="col-sm-8">
				<div class="card">
					<c:forEach var="question" items="${paper.questions}" varStatus="status">
						<c:set var="seq" value="${status.index + 1}"></c:set>
						<div id="ques-${status.index + 1}" class="exam-ques" data-index="${seq}" data-question-id="${question.id}" 
							data-question-type="${question.type}">
							<c:choose>
								<c:when test="${question.type == 1}">
									<c:set var="type" value="单选题"></c:set>
								</c:when>
								<c:when test="${question.type == 2}">
									<c:set var="type" value="多选题"></c:set>
								</c:when>
								<c:when test="${question.type == 3}">
									<c:set var="type" value="判断题"></c:set>
								</c:when>
							</c:choose>
							<p class="ques-info">
								第 ${seq} 题【共25题】【${type}】【${question.score}分】
							</p>
							<p>${question.title}</p>
							<c:if test="${not empty question.imagePath}">
								<p class="ques-image">
									<img alt="图片" src="${ctx}${question.imagePath}">
								</p>
							</c:if>
							
							<ul class="unstyled ques-options">
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
						<div class="hr-line-solid"></div>
					</c:forEach>
				</div>
			</div>
			
			<div class="col-sm-4 hidden-xs">
				<div class="exam-controller">
					<div class="card">
						<div style="font-size: 20px; text-align: center;">
							<i class="fa fa-clock-o fa-fw fa-lg"></i>剩余时间
							<span class="countdown" style="color: #ed5565; padding-left: 5px;"></span>
						</div>
						<div style="padding: 10px;">
							<button type="button" class="btn btn-primary btn-submit" style="width: 100%;">提交试卷</button>
						</div>
					</div>
					
					<div class="card" style="margin-top: 15px;">
						<label>答题卡</label>
						<div class="col-sm-12" style="padding: 0; margin-top: 10px;">
							<ul class="unstyled ques-list" style="padding: 0;">
								<c:forEach var="question" items="${paper.questions}" varStatus="status">
									<li class="ques-link" data-index="${status.index + 1}">${status.index + 1}</li>
								</c:forEach>
							</ul>
						</div>
						<div class="ques-list-tips text-center" style="margin-top: 10px;">
							<span>已做&nbsp;<i class="fa fa-square tips-done" style="color: #FF7B29; margin-right: 10px;"></i></span>
							<span>未做&nbsp;<i class="fa fa-square-o tips-undone"></i></span>
						</div>
					</div>
					
					<div class="card" style="margin-top: 15px;">
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
		</div>
	</div>
	
	<div class="corner-buttons">
		<div class="corner-container btn-submit visible-xs" data-toggle="tooltip" data-placement="left" data-container="body" title="提交试卷">
			<button type="button" class="btn corner-btn" style="background-color: #43bc60; color: #fff;">交卷</button>
		</div>
	
		<div class="corner-container btn-feedback" data-toggle="tooltip" data-placement="left" data-container="body" title="建议反馈">
			<button type="button" class="btn corner-btn">
				<i class="fa fa-edit fa-lg"></i>
			</button>
		</div>
	
		<div class="corner-container btn-top hide" data-toggle="tooltip" data-placement="left" data-container="body" title="回到顶部">
			<button type="button" class="btn corner-btn">
				<i class="fa fa-chevron-up fa-lg"></i>
			</button>
		</div>
	</div>
	
	<div class="modal" id="modal-submit-dialog" tabindex="-1" role="dialog" aria-hidden="true" data-backdrop="static">
		<div class="modal-dialog modal-center">
			<div class="modal-content animated fadeInDown">
				<div class="modal-header">
					<h4 class="modal-title">确认交卷</h4>
				</div>
				<div class="modal-body">
					<span>您确认现在交卷吗？离考试结束还有<span id="submitRemainingTime"></span>分钟，您不检查一下吗？</span>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary btn-fw" data-dismiss="modal">在检查一下</button>
                    <button type="button" class="btn btn-white btn-fw btn-submit-submit">确认交卷</button>
				</div>
			</div>
		</div>
	</div>
	
	<div class="modal" id="modal-feedback-dialog" tabindex="-1" role="dialog" aria-hidden="true" data-backdrop="static">
		<div class="modal-dialog modal-center">
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
	
	<script type="text/javascript" src="${ctx}/plugins/toastr/toastr.min.js"></script>
	
	<script type="text/javascript">
	
		var paperId = '${paper.id}';
		var studentId = '${student.id}';
		var examId = '${exam.id}';
		
		var $page = $('.body-online-exam');
		var $submitDialog = $page.find('#modal-submit-dialog');
		var $feedbackDialog = $page.find('#modal-feedback-dialog');
		var $controller = $page.find('.exam-controller');
		
		// tooltip
		$page.find('[data-toggle="tooltip"]').tooltip();
		// 回到顶部按钮
		var $top = $page.find('.btn-top');
		$(window).scroll(function() {
			if ($(window).scrollTop() > 800) {
				$top.removeClass('hide');
			} else {
				$top.addClass('hide');
			}
		});
		
		// 右侧固定
		$(window).scroll(function() {
			if ($(window).scrollTop() > 70) {
				$controller.addClass('affix');
			} else {
				$controller.removeClass('affix');
			}
		}); 
		
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
			var offset = $page.find('#ques-' + index).offset().top - 70;
			$('html,body').animate({
				scrollTop: offset
			}, 1000);
		})
		.on('click', '.btn-submit', function() {
			$submitDialog.find('#submitRemainingTime').text(getRemainingMinute());
			$submitDialog.modal('show');
		})
		.on('click', '.btn-submit-submit', function() {
			submitPaper();
		})
		.on('click', '.btn-feedback', function() {
			$feedbackDialog.modal('show');
		})
		.on('click', '.btn-feedback-submit', function() {
			var content = $feedbackDialog.find('.textarea-feedback').val();
			if (!content) {
				$feedbackDialog.find('.textarea-feedback').css('border', '1px solid #f75659');
				return;
			} else {
				$feedbackDialog.find('.textarea-feedback').css('border', '1px solid #e5e6e7');
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
							$feedbackDialog.modal('hide');
							toastr['info']('提交成功！ 谢谢您的建议反馈');
						}
					},
					error: function(err) {}
				});
			}
		})
		.on('hidden.bs.modal', '#modal-feedback-dialog', function() {
			$feedbackDialog.find('.textarea-feedback').val('');
        }) 
		.on('click', '.btn-top', function() {
			$('html, body').animate({scrollTop: 0}, 1000);
		});
		
		// 提交试卷
		function submitPaper() {
			var submitList = [];
			$.each($page.find('.exam-ques'), function(index, elem) {
				var $question = $(elem);
				var questionId = $question.data('questionId');
				var type = $question.data('questionType');
				index = index + 1;
				switch (type) {
				case 1:
				case 3:
					var checked = $question.find('input[name="options-' + index + '"]:checked').val();
					if (!checked) {
						checked = 'N';
					}
					submitList.push(questionId + '-' + checked);
					break;
				case 2:
					var checked = [];
					$question.find('input[name="options-' + index + '"]:checked').each(function() {
						checked.push($(this).val());
					});
					if (checked.length == 0) {
						checked = ['N'];
					}
					submitList.push(questionId + '-' + checked);
					break;
				}
			});
			
			$.ajax({
				url: '${ctx}/api/exam/submit',
				type: 'post',
				data: {
					examId: examId,
					submitList: submitList
				},
				success: function(ret) {
					if (ret.code == 0) {
						window.location.href = '${ctx}/online/complete?eid=' + examId;
					}
				},
				error: function(err) {}
			});
		}
		
		// 倒计时控制器
		var totleSecond = initTimer();	// 剩余秒数
		startTime(totleSecond);
		
		// 获取剩余时间
		function initTimer() {
			var totleSecond = Number('${remainingTime}');
			//var totleSecond = 5400;
			return totleSecond;
		}
		// 开始倒计时
		function startTime(totleSecond) {
			//$page.find('#time').text(formatTime(totleSecond));
			$page.find('.countdown').text(formatTime(totleSecond));
			var timer = setInterval(function() {
				totleSecond -= 1;
				if (totleSecond >= 0) {
					//$page.find('#time').text(formatTime(totleSecond));
					$page.find('.countdown').text(formatTime(totleSecond));
					
					// 距离考试结束提示
					if (totleSecond == 300) {
						toastr['info']('距离考试结束还有5分钟！');
					}
					if (totleSecond == 60) {
						toastr['info']('距离考试结束还有1分钟！');
					}
					if (totleSecond == 5) {
						toastr['info']('考试即将结束，试卷将会自动提交！');
					}
				} else {
					// 强制提交试卷
					submitPaper();
					clearInterval(timer);
				}
			}, 1000);
		}
		// 格式化剩余秒数
		function formatTime(totleSecond) {
			var minute = formatTimeNumber(Math.floor(totleSecond / 60));
			var second = formatTimeNumber(Math.floor(totleSecond % 60));
			return minute + ':' + second;
		}
		// 格式化数字
		function formatTimeNumber(number) {
			return number < 10 ? '0' + number : number
		}
		// 获取剩余分钟数
		function getRemainingMinute() {
			var minute = formatTimeNumber(Math.floor((totleSecond % 3600) /60));
			return minute;
		}
	
	</script>
	
</body>
</html>