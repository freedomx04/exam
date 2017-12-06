<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/include/preload.jsp"%>

<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <title>题库练习</title>
    
    <link rel="stylesheet" type="text/css" href="${ctx}/plugins/bootstrap/3.3.6/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/plugins/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/plugins/awesome-bootstrap-checkbox/awesome-bootstrap-checkbox.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/plugins/animate/animate.min.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/plugins/sweetalert/sweetalert.css">
    
    <link rel="stylesheet" type="text/css" href="${ctx}/plugins/hplus/style.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/plugins/toastr/toastr.min.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/local/common.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/local/online.css">
    
    <style type="text/css">
    .practice-type a {
    	display: flex;
    	-webkit-box-align: center;
    	align-items: center;
    	padding: 0 20px;
    	height: 40px;
    	overflow: hidden;
    	color: #8590a6;
    }
    .practice-type a:HOVER {
    	background: #f4f8fb;
    	text-decoration: none;
    }
    .practice-type a span {
    	margin: 0 10px;
    }
    </style>
</head>
<body class="gray-bg body-practice-question">
	<div>
		<header role="banner" class="exam-banner fixed">
			<div class="exam-banner-inner">
				<div style="font-size: 18px;">${title}</div>
			</div>
		</header>
		<div class="exam-banner-holder"></div>
	</div>
	
	<main role="main">
		<div class="exam-container">
			<div class="practice-question" style="width: 840px">
				<div class="card exam-ques">
					<div style="line-height: 1.6em;">
						<span class="ques-num">
							<span class="ques-seq"></span>/<span class="ques-count"></span>
						</span>
						<span class="ques-type" style="margin-left: 5px;"></span>
						<span class="ques-title"></span>
						<span class="ques-score"></span>
					</div>
					
					<div>
						<img class="ques-image" style="margin: 10px 20px;"></img>
						<ul class="unstyled ques-options" style="margin-top: 15px; padding-left: 20px;"></ul>
					</div>
					
					<div class="row">
						<div class="col-sm-12">
							<div class="ques-tips alert hide" style="margin-left: 20px; width: fit-content; font-size: 16px;"></div>
							<div class="ques-analysis hide" style="margin-left: 20px;"></div>
						</div>
					</div>
					
					<div class="hr-line-solid"></div>
					<div class="row" style="font-size: 14px;">
						<div class="col-sm-6 ques-control" style="padding-left: 30px;">
							<button type="button" class="btn btn-primary btn-sm btn-fw btn-question-prev">上一题</button>
							<button type="button" class="btn btn-primary btn-sm btn-fw btn-question-next">下一题</button>
						</div>
						<div class="col-sm-6">
							<span>共</span><span class="ques-count" style="padding: 0 5px;"></span>题,&nbsp;
							转到
							<input type="text" class="input-question-jump text-right" style="width: 50px; padding-right: 10px;" onKeyUp="value=value.replace(/[^\d]/g, '1')" value="1">
							题
							<button type="button" class="btn btn-primary btn-sm btn-fw btn-question-jump">确定</button>
						</div>
					</div>
				</div>
			</div>
			
			<div class="exam-controller fixed" style="width: 320px; color: #999;">
				<div class="card">
					<ul class="unstyled practice-type" style="width: 100%; padding: 8px 0;">
						<li>
							<a href="${ctx}/practice/order" target="_blank">
								<i class="fa fa-list-ul"></i>
								<span>顺序练习</span>
							</a>
						</li>
						<li>
							<a href="${ctx}/practice/random" target="_blank">
								<i class="fa fa-random"></i>
								<span>随机练习</span>
							</a>
						</li>
						<li>
							<a href="${ctx}/practice/library" target="_blank">
								<i class="fa fa-tasks"></i>
								<span>题库练习</span>
							</a>
						</li>
						<li>
							<a href="${ctx}/practice/type" target="_blank">
								<i class="fa fa-database"></i>
								<span>题型练习</span>
							</a>
						</li>
						<li>
							<a class="practice-exam" href="#">
								<i class="fa fa-clock-o"></i>
								<span>模拟考试</span>
							</a>
						</li>
					</ul>
				</div>
			</div>
		</div>
	</main>
	
	<script type="text/javascript" src="${ctx}/plugins/jquery/2.1.4/jquery.min.js"></script>
	<script type="text/javascript" src="${ctx}/plugins/bootstrap/3.3.6/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="${ctx}/plugins/hplus/content.min.js"></script>
	<script type="text/javascript" src="${ctx}/local/common.js"></script>
	
	<script type="text/javascript" src="${ctx}/plugins/toastr/toastr.min.js"></script>
	
	<script type="text/javascript">
	
		var $page = $('.body-practice-question');
		var idList = '${idList}';
		idList = idList.replace('[', '').replace(']', '');
		var ids = idList.split(',');
		
		var seq = 0;
		var question;
		
		// 试题数目
		$page.find('.ques-count').text(ids.length);
		// 第一题
		getQuestion(ids[0]);
		enableBtn();
		
		$page
		.on('click', 'input[name="single"]', function() {
			$page.find('input[name="single"]').attr('disabled', 'disabled');
			
			var checked = $page.find('input[name="single"]:checked').val();
			if (checked == question.answer) {
				$page.find('.ques-tips')
					.removeClass('hide alert-success alert-danger')
					.addClass('alert-success')
					.text('恭喜你，答对了！');
			} else {
				$page.find('.ques-tips')
					.removeClass('hide alert-success alert-danger')
					.addClass('alert-danger')
					.text('您答错了！正确答案是：' + question.answer);
			}
			
			if (!question.analysis) {
				question.analysis = '无';
			}
			$page.find('.ques-analysis').removeClass('hide').text('试题解析：' + question.analysis);
		})
		.on('click', '.btn-question-submit', function() {
			$page.find('input[name="multiple"]').attr('disabled', 'disabled');
			
			var checked = [];
			$page.find('input[name="multiple"]:checked').each(function() {
				checked.push($(this).val());
			});
			if (checked == question.answer) {
				$page.find('.ques-tips')
					.removeClass('hide alert-success alert-danger')
					.addClass('alert-success')
					.text('恭喜你，答对了！');
			} else {
				$page.find('.ques-tips')
					.removeClass('hide alert-success alert-danger')
					.addClass('alert-danger')
					.text('您答错了！正确答案是：' + question.answer);
			}
			
			if (!question.analysis) {
				question.analysis = '无';
			}
			$page.find('.ques-analysis').removeClass('hide').text('试题解析：' + question.analysis);
		})
		.on('click', 'input[name="boolean"]', function() {
			$page.find('input[name="boolean"]').attr('disabled', 'disabled');
			
			var checked = $page.find('input[name="boolean"]:checked').val();
			if (checked == question.answer) {
				$page.find('.ques-tips')
					.removeClass('hide alert-success alert-danger')
					.addClass('alert-success')
					.text('恭喜你，答对了！');
			} else {
				var answer = (question.answer == A) ? '正确' : '错误';
				$page.find('.ques-tips')
					.removeClass('hide alert-success alert-danger')
					.addClass('alert-danger')
					.text('您答错了！正确答案是：' + answer);
			}
			
			if (!question.analysis) {
				question.analysis = '无';
			}
			$page.find('.ques-analysis').removeClass('hide').text('试题解析：' + question.analysis);
		})
		.on('click', '.btn-question-prev', function() {
			seq--;
			getQuestion(ids[seq].trim());
			enableBtn();
		})
		.on('click', '.btn-question-next', function() {
			seq++;
			getQuestion(ids[seq].trim());
			enableBtn();
		})
		.on('click', '.btn-question-jump', function() {
			var num = $page.find('.input-question-jump').val();
			if (num <= 0 || num == '') {
				toastr['error']('请输入大于 0 的数字');
			} else if (num > ids.length) {
				toastr['error']('题号必须小于总题数');
			} else {
				seq = Number(num - 1);
				getQuestion(ids[seq]);
				enableBtn();
			}
		})
		.on('click', '.practice-exam', function() {
			alert('开发中');
		});
		
		// 获取题目
		function getQuestion(id) {
			// tips隐藏
			$page.find('.ques-tips').addClass('hide');
			$page.find('.ques-analysis').addClass('hide');
			
			$.ajax({
				url: '${ctx}/api/question/get?questionId=' + id,
				success: function(ret) {
					if (ret.code == 0) {
						question = ret.data;
						
						// 试题类型
						$page.find('.ques-type').removeClass('ques-single ques-multiple ques-boolean');
						switch(question.type){
						case 1:
							$page.find('.ques-type').addClass('ques-single').text('单选题');
							break;
						case 2:
							$page.find('.ques-type').addClass('ques-multiple').text('多选题');
							break;
						case 3:
							$page.find('.ques-type').addClass('ques-boolean').text('判断题');
							break;
						}
						
						// 试题序号
						$page.find('.ques-seq').text(seq + 1);
						// 试题题干
						$page.find('.ques-title').text(question.title);
						// 试题分数
						$page.find('.ques-score').text('(' + question.score + '分)');
						// 题干图片
						if (question.imagePath) {
							$page.find('.ques-image').attr('src', '${ctx}' + question.imagePath);
						} else {
							$page.find('.ques-image').attr('src', '');
						}
						// 试题选项
						$page.find('.ques-options').empty();
						// 单选题
						if (question.type == 1) {
							$page.find('.ques-options').append(
									'<li><div class="radio radio-success radio-inline">' + 
										'<input type="radio" name="single" id="A" value="A">' +
										'<label for="A">A：' + question.optionA + '</label>' +
									'</div></li>');
							$page.find('.ques-options').append(
									'<li><div class="radio radio-success radio-inline">' + 
										'<input type="radio" name="single" id="B" value="B">' +
										'<label for="B">B：' + question.optionB + '</label>' +
									'</div></li>');
							if (question.optionC) {
								$page.find('.ques-options').append(
										'<li><div class="radio radio-success radio-inline">' + 
											'<input type="radio" name="single" id="C" value="C">' +
											'<label for="C">C：' + question.optionC + '</label>' +
										'</div></li>');
							}
							if (question.optionD) {
								$page.find('.ques-options').append(
										'<li><div class="radio radio-success radio-inline">' + 
											'<input type="radio" name="single" id="D" value="D">' +
											'<label for="D">D：' + question.optionD + '</label>' +
										'</div></li>');
							}
							if (question.optionE) {
								$page.find('.ques-options').append(
										'<li><div class="radio radio-success radio-inline">' + 
											'<input type="radio" name="single" id="E" value="E">' +
											'<label for="E">E：' + question.optionE + '</label>' +
										'</div></li>');
							}
							if (question.optionF) {
								$page.find('.ques-options').append(
										'<li><div class="radio radio-success radio-inline">' + 
											'<input type="radio" name="single" id="F" value="F">' +
											'<label for="F">F：' + question.optionF + '</label>' +
										'</div></li>');
							}
						} 
						// 多选题
						else if (question.type == 2) {
							$page.find('.ques-options').append(
									'<li><div class="checkbox checkbox-success checkbox-inline">' + 
										'<input type="checkbox" name="multiple" id="A" value="A">' +
										'<label for="A">A：' + question.optionA + '</label>' +
									'</div></li>');
							$page.find('.ques-options').append(
									'<li><div class="checkbox checkbox-success checkbox-inline">' + 
										'<input type="checkbox" name="multiple" id="B" value="B">' +
										'<label for="B">B：' + question.optionB + '</label>' +
									'</div></li>');
							if (question.optionC) {
								$page.find('.ques-options').append(
										'<li><div class="checkbox checkbox-success checkbox-inline">' + 
											'<input type="checkbox" name="multiple" id="C" value="C">' +
											'<label for="C">C：' + question.optionC + '</label>' +
										'</div></li>');
							}
							if (question.optionD) {
								$page.find('.ques-options').append(
										'<li><div class="checkbox checkbox-success checkbox-inline">' + 
											'<input type="checkbox" name="multiple" id="D" value="D">' +
											'<label for="D">D：' + question.optionD + '</label>' +
										'</div></li>');
							}
							if (question.optionE) {
								$page.find('.ques-options').append(
										'<li><div class="checkbox checkbox-success checkbox-inline">' + 
											'<input type="checkbox" name="multiple" id="E" value="E">' +
											'<label for="E">E：' + question.optionE + '</label>' +
										'</div></li>');
							}
							if (question.optionF) {
								$page.find('.ques-options').append(
										'<li><div class="checkbox checkbox-success checkbox-inline">' + 
											'<input type="checkbox" name="multiple" id="F" value="F">' +
											'<label for="F">F：' + question.optionF + '</label>' +
										'</div></li>');
							}
							$page.find('.ques-options').append('<li><button type="button" class="btn btn-blue btn-fw btn-question-submit">提交</button></li>');
						} 
						// 判断题
						else {
							$page.find('.ques-options').append(
									'<li><div class="radio radio-success radio-inline">' + 
										'<input type="radio" name="boolean" id="A" value="A">' +
										'<label for="A">正确</label>' +
									'</div></li>');
							$page.find('.ques-options').append(
									'<li><div class="radio radio-success radio-inline">' + 
										'<input type="radio" name="boolean" id="B" value="B">' +
										'<label for="B">错误</label>' +
									'</div></li>');
						}
					} else {
						
					}
				},
				error: function(err) {}
			});
		}
		
		// 设置按钮
		function enableBtn() {
			if (seq == 0 && seq == (ids.length - 1)) {
				$page.find('.btn-question-prev').attr('disabled', 'disabled');
				$page.find('.btn-question-next').attr('disabled', 'disabled');
			} else if (seq == 0) {
				$page.find('.btn-question-prev').attr('disabled', 'disabled');
				$page.find('.btn-question-next').removeAttr('disabled');
			} else if (seq == (ids.length - 1)) {
				$page.find('.btn-question-prev').removeAttr('disabled');
				$page.find('.btn-question-next').attr('disabled', 'disabled');
			} else {
				$page.find('.btn-question-prev').removeAttr('disabled');
				$page.find('.btn-question-next').removeAttr('disabled');
			}
		}
		
		
		// 设置右侧控制器的位置
		setController();
		window.onresize = function() {
			setController();
		}
		function setController() {
			var $controller = $page.find('.exam-controller');
			var $corner = $page.find('.corner-buttons');
			var $width = $(document).width();
			var left_val = ($width - 1180) / 2 + 840 + 20;
			$controller.css('left', left_val);
			$corner.css('left', left_val);
		}
	
	</script>
</body>
</html>