<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/include/preload.jsp"%>

<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1, user-scalable=no">
    
    <title>${title}</title>
    
    <link rel="stylesheet" type="text/css" href="${ctx}/plugins/bootstrap/3.3.6/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/plugins/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/plugins/awesome-bootstrap-checkbox/awesome-bootstrap-checkbox.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/plugins/animate/animate.min.css">
    
    <link rel="stylesheet" type="text/css" href="${ctx}/local/common.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/local/online.css">
    
</head>
<body class="gray-bg body-practice-question">
	<header class="navbar navbar-static-top nav-exam" id="top">
		<div class="container">
			<div class="navbar-header">
				<button class="navbar-toggle collapsed" type="button" data-toggle="collapse" data-target="#bs-navbar" 
					aria-controls="bs-navbar" aria-expanded="false">
					<span class="sr-only">Toggle navigation</span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
        			<span class="icon-bar"></span>
				</button>
				<a href="${ctx}/practice" class="navbar-brand">模拟练习</a>
			</div>
			<nav id="bs-navbar" class="navbar-collapse collapse">
				<ul class="nav navbar-nav">
					<li>
						<a href="${ctx}/practice/order">顺序练习</a>
					</li>
					<li>
						<a href="${ctx}/practice/random">随机练习</a>
					</li>
					<li>
						<a href="${ctx}/practice/library">题库练习</a>
					</li>
					<li>
						<a href="${ctx}/practice/type">题型练习</a>
					</li>
				</ul>
			</nav>
		</div>
	</header>
	
	<div class="container animated fadeInRight" style="padding: 0;">
		<div class="card">
			<p class="ques-info"></p>
			<p class="ques-title"></p>
			<p class="ques-image"></p>
			<ul class="unstyled ques-options"></ul>
			
			<div class="ques-tips hide">
				<p class="ques-answer"></p>
				<p class="ques-analysis"></p>
			</div>
			
			<div class="hr-line-solid"></div>
			<div>
				<button type="button" class="btn btn-primary btn-sm btn-fw btn-question-prev">上一题</button>
				<button type="button" class="btn btn-primary btn-sm btn-fw btn-question-next">下一题</button>
			</div>
		</div>
	</div>

	<script type="text/javascript" src="${ctx}/plugins/jquery/2.1.4/jquery.min.js"></script>
	<script type="text/javascript" src="${ctx}/plugins/bootstrap/3.3.6/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="${ctx}/local/common.js"></script>
	
	<script type="text/javascript">
	;(function ( $ ) {
		
		var $page = $('.body-practice-question');
		var idList = '${idList}';
		idList = idList.replace('[', '').replace(']', '');
		var ids = idList.split(',');
		
		var seq = 0;
		var question;
		
		getQuestion(ids[0]);
		enableBtn();
		
		$page
		.on('click', 'input[name="single"]', function() {
			$page.find('input[name="single"]').attr('disabled', 'disabled');
			var checked = $page.find('input[name="single"]:checked').val();
			if (checked == question.answer) {
				$page.find('.ques-answer')
					.removeClass('color-success color-danger')
					.addClass('color-success').text('【答案】恭喜你，答对了！');
			} else {
				$page.find('.ques-answer')
					.removeClass('color-success color-danger')
					.addClass('color-danger').text('【答案】答错了，正确答案是：' + question.answer);
			}
			if (!question.analysis) {
				question.analysis = '无';
			}
			$page.find('.ques-analysis').text('【解析】' + question.analysis);
			$page.find('.ques-tips').removeClass('hide');
		})
		.on('click', '.btn-question-submit', function() {
			$page.find('input[name="multiple"]').attr('disabled', 'disabled');
			$page.find('.btn-question-submit').attr('disabled', 'disabled');
			var checked = [];
			$page.find('input[name="multiple"]:checked').each(function() {
				checked.push($(this).val());
			});
			if (checked == question.answer) {
				$page.find('.ques-answer')
					.removeClass('color-success color-danger')
					.addClass('color-success').text('【答案】恭喜你，答对了！');
			} else {
				$page.find('.ques-answer')
					.removeClass('color-success color-danger')
					.addClass('color-danger').text('【答案】答错了，正确答案是：' + question.answer);
			}
			if (!question.analysis) {
				question.analysis = '无';
			}
			$page.find('.ques-analysis').text('【解析】' + question.analysis);
			$page.find('.ques-tips').removeClass('hide');
		})
		.on('click', 'input[name="boolean"]', function() {
			$page.find('input[name="boolean"]').attr('disabled', 'disabled');
			var checked = $page.find('input[name="boolean"]:checked').val();
			if (checked == question.answer) {
				$page.find('.ques-answer')
					.removeClass('color-success color-danger')
					.addClass('color-success').text('【答案】恭喜你，答对了！');
			} else {
				var answer = (question.answer == A) ? '正确' : '错误';
				$page.find('.ques-answer')
					.removeClass('color-success color-danger')
					.addClass('color-danger').text('【答案】答错了，正确答案是：' + answer);
			}
			if (!question.analysis) {
				question.analysis = '无';
			}
			$page.find('.ques-analysis').text('【解析】' + question.analysis);
			$page.find('.ques-tips').removeClass('hide');
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
		});
		
		// 获取题目
		function getQuestion(id) {
			// tips隐藏
			$page.find('.ques-tips').addClass('hide');
			
			$.ajax({
				url: '${ctx}/api/question/get?questionId=' + id,
				success: function(ret) {
					if (ret.code == 0) {
						question = ret.data;
						
						// 试题信息
						var quesType;
						switch (question.type) {
						case 1:		quesType = '单选题';	break;
						case 2:		quesType = '多选题';	break;
						case 3:		quesType = '判断题';	break;
						}
						$page.find('.ques-info').text('第 ' + (seq + 1) + ' 题【共' + ids.length + '题】【' + quesType + '】【' + question.score + '分】');
						// 试题题干
						$page.find('.ques-title').text(question.title);
						// 试题图片
						$page.find('.ques-image').empty();
						if (question.imagePath) {
							$page.find('.ques-image').append('<img src="${ctx}' + question.imagePath + '">');
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
							$page.find('.ques-options').append('<li><button type="button" class="btn btn-blue btn-sm btn-fw btn-question-submit">提交</button></li>');
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
					}
				}
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
		
	}) (jQuery);
	</script>
	
</body>
</html>