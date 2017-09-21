<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/include/preload.jsp"%>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <title>题库列表</title>
    
    <link rel="stylesheet" type="text/css" href="${ctx}/plugins/bootstrap/3.3.6/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/plugins/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/plugins/awesome-bootstrap-checkbox/awesome-bootstrap-checkbox.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/plugins/animate/animate.min.css">
    
    <link rel="stylesheet" type="text/css" href="${ctx}/plugins/hplus/style.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/local/common.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/plugins/toastr/toastr.min.css">
       
   	<style type="text/css">
   	.body-practice-question .ques-options li {
   		height: 36px;
   		font-size: 16px;
   	}
   	.body-practice-question .btn {
   		width: 100px;
   	}
   	</style> 
        
</head>

<body class="gray-bg body-practice-question">
	<div class="wrapper wrapper-content animated fadeInRight">
		<div class="ibox float-e-margins">
			<div class="ibox-content">
				<h2 class="page-title" style="display: inline;">${title}<small style="margin-left: 20px;">${subTitle}</small></h2>
				
				<c:if test="${not empty subTitle}">
					<a href="javascript:;" class="btn-practice-back" style="margin-left: 20px;">重新选择</a>
				</c:if>
				
				<div class="hr-line-dashed"></div>
				<div class="row">
					<div class="col-sm-12">
						<span class="ques-type"></span>
						<span class="ques-seq" style="font-size: 20px; margin-left: 10px;"></span>
						<span class="ques-title" style="font-size: 20px;"></span>
					</div>
				</div>
				
				<div class="row">
					<div class="col-sm-8">
						<ul class="unstyled ques-options" style="padding-left: 70px; padding-top: 15px;"></ul>
					</div>
				</div>
				
				<div class="row">
					<div class="col-sm-8">
						<div class="ques-tips alert hide" style="margin-left: 70px; width: fit-content; font-size: 16px;"></div>
						<div class="ques-analysis hide" style="margin-left: 70px;"></div>
					</div>
				</div>
				
				<div class="hr-line-dashed" style="margin-top: 50px;"></div>
				<div class="row">
					<div class="col-sm-11 ques-control" style="padding-left: 70px;">
						<button type="button" class="btn btn-primary btn-question-prev">上一题</button>
						<button type="button" class="btn btn-primary btn-question-next">下一题</button>
						
						<span style="padding-left: 50px;">共</span><span class="question-size" style="padding: 0 10px;">123</span>题,&nbsp;
						转到
						<input type="text" class="input-question-jump text-right" style="width: 50px; padding-right: 5px;" onKeyUp="value=value.replace(/[^\d]/g, '1')" value="1">
						题
						<button type="button" class="btn btn-primary btn-question-jump" style="width: 60px;">确定</button>
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
	
		var $page = $('.body-practice-question');
		var idList = '${idList}';
		idList = idList.replace('[', '').replace(']', '');
		var ids = idList.split(',');
		
		var seq = 0;
		var question;
		
		// 试题数目
		$page.find('.question-size').text(ids.length);
		// 第一题
		getQuestion(ids[0]);
		enableBtn();
		
		$page
		.on('click', '.btn-practice-back', function() {
			window.history.back();
		})
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
		});
		
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
		
		function getQuestion(id) {
			// tips隐藏
			$page.find('.ques-tips').addClass('hide');
			$page.find('.ques-analysis').addClass('hide')
			
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
						$page.find('.ques-seq').text(seq + 1 + '.');
						// 试题题干
						$page.find('.ques-title').text(question.title);
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
							$page.find('.ques-options').append('<li><button type="button" class="btn btn-blue btn-question-submit">提交</button></li>');
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
	
	</script>

</body>
</html>