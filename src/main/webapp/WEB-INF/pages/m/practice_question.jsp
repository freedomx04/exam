<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/include/preload.jsp"%>

<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0">
    
    <title>${title}</title>
    
    <link rel="stylesheet" type="text/css" href="${ctx}/plugins/weui/weui.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/plugins/weui/example.css">
    
    <style type="text/css">
    .body-practice-question img {	
    	max-width: 100%; 
    }
    .ques-seq {
    	background-color: #36aafd;
    }
    /** 题型 */
	.ques-type {
		font-size: 12px;
		border: 1px solid;
		border-radius: 2px;
		padding: 3px 8px;
		vertical-align: middle;
	}
	.ques-single {
		color: #1ab394;
		border-color: #1ab394;
	}
	.ques-multiple {
		color: #1c84c6;
		border-color: #1c84c6;
	}
	.ques-boolean {
		color: #ec4444;
		border-color: #ec44444;
	}
	.ques-score {
		color: #aeaeae; 
		margin-left: 5px; 
		font-size: 14px;
		float: right;
	}
	.hide {
		display: none;
	}
    </style>
    
</head>
<body class="body-practice-question">
	<div class="weui-cells" style="margin-top: 0;">
		<div class="weui-cell">
			<p>${title}</p>
		</div>
	</div>

	<div class="weui-cells exam-ques">
		<div class="weui-cell">
			<div class="weui-cell__bd">
				<div class="weui-uploader">
					<div class="weui-uploader__hd">
						<p class="weui-uploader__title">
							<span class="weui-badge ques-seq"></span>
							<span class="ques-type" style="margin-left: 5px;"></span>
						</p>
						<div class="weui-uploader__info"><span class="ques-score"></span></div>
					</div>
					
					<div class="weui-uploader__bd">
						<p class="ques-title"></p>
					</div>
					
					<div class="ques-image"></div>
				</div>
			</div>
		</div>
	</div>
	<div class="weui-cells ques-options" style="margin-top: 0;"></div>
	
	<!-- 提示框 -->
	<div class="tips_dialog hide" style="opacity: 1;">
        <div class="weui-mask"></div>
        <div class="weui-dialog">
            <div class="weui-dialog__bd">
            	<div class="weui-msg__icon-area">
            		<i class="weui-icon_msg tips-icon"></i>
            	</div>
            	<div>
            		<h2 class="weui-msg__title tips-title"></h2>
            		<p class="weui-msg__desc tips-analysis"></p>
            	</div>
            </div>
            <div class="weui-dialog__ft">
                <a href="javascript:;" class="weui-dialog__btn weui-dialog__btn_primary btn-tips-cancel">知道了</a>
            </div>
        </div>
    </div>
	
	<!-- <div class="weui-tabbar">
		aa
	</div> -->
	

	<script type="text/javascript" src="${ctx}/plugins/weui/zepto.min.js"></script>
	
	<script type="text/javascript">
	;(function ( $ ) {
		
		var $page = $('.body-practice-question');
		var $tips = $page.find('.tips_dialog');
		
		var idList = '${idList}';
		idList = idList.replace('[', '').replace(']', '');
		var ids = idList.split(',');
		
		var seq = 0;
		var question;
		
		// 试题数目
		$page.find('.ques-count').text(ids.length);
		//getQuestion(ids[0]);
		getQuestion(3);
		//getQuestion(7);
		
		$page
		.on('click', '.btn-tips-cancel', function() {
			$tips.addClass('hide');
		})
		.on('click', 'input[name="single"]', function() {
			var checked = $page.find('input[name="single"]:checked').val();
			if (checked == question.answer) {
				$tips.find('.tips-icon').removeClass('weui-icon-warn').addClass('weui-icon-success');
				$tips.find('.tips-title').text('恭喜你，答对了！');
			} else {
				$tips.find('.tips-icon').removeClass('weui-icon-success').addClass('weui-icon-warn');
				$tips.find('.tips-title').text('答错了！正确答案是：' + question.answer);
			}
			if (!question.analysis) {
				question.analysis = '无';
			}
			$tips.find('.tips-analysis').text('试题解析：' + question.analysis);
			$tips.removeClass('hide');
		})
		.on('click', '.btn-question-submit', function() {
			var checked = [];
			$page.find('input[name="multiple"]:checked').each(function() {
				checked.push($(this).val());
			});
			if (checked == question.answer) {
				$tips.find('.tips-icon').removeClass('weui-icon-warn').addClass('weui-icon-success');
				$tips.find('.tips-title').text('恭喜你，答对了！');
			} else {
				$tips.find('.tips-icon').removeClass('weui-icon-success').addClass('weui-icon-warn');
				$tips.find('.tips-title').text('答错了！正确答案是：' + question.answer);
			}
			if (!question.analysis) {
				question.analysis = '无';
			}
			$tips.find('.tips-analysis').text('试题解析：' + question.analysis);
			$tips.removeClass('hide');
		})
		.on('click', 'input[name="boolean"]', function() {
			var checked = $page.find('input[name="boolean"]:checked').val();
			if (checked == question.answer) {
				$tips.find('.tips-icon').removeClass('weui-icon-warn').addClass('weui-icon-success');
				$tips.find('.tips-title').text('恭喜你，答对了！');
			} else {
				var answer = (question.answer == A) ? '正确' : '错误';
				$tips.find('.tips-icon').removeClass('weui-icon-success').addClass('weui-icon-warn');
				$tips.find('.tips-title').text('答错了！正确答案是：' + answer);
			}
			if (!question.analysis) {
				question.analysis = '无';
			}
			$tips.find('.tips-analysis').text('试题解析：' + question.analysis);
			$tips.removeClass('hide');
		});
		
		// 获取题目
		function getQuestion(id) {
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
						$page.find('.ques-seq').text(seq + 1 + '/' + ids.length);
						// 试题题干
						$page.find('.ques-title').text(question.title);
						// 试题分数
						$page.find('.ques-score').text('(' + question.score + '分)');
						// 题干图片
						if (question.imagePath) {
							$page.find('.ques-image').append('<img src="${ctx}' + question.imagePath + '" style="margin-top: 10px;">');
						} else {
							$page.find('.ques-image').empty();
						}
						// 试题选项
						$page.find('.ques-options').empty();
						$page.find('.ques-options').removeClass('weui-cells_radio weui-cells_checkbox');
						// 单选题
						if (question.type == 1) {
							$page.find('.ques-options').addClass('weui-cells_radio');
							$page.find('.ques-options').append(
								'<label class="weui-cell weui-check__label" for="A">' + 
									'<div class="weui-cell__bd"><p>A：' + question.optionA + '</p></div>' +
									'<div class="weui-cell__ft">' +
										'<input type="radio" class="weui-check" name="single" id="A" value="A">' +
										'<span class="weui-icon-checked"></span>' + 
									'</div>' + 
								'</label>');	
							$page.find('.ques-options').append(
								'<label class="weui-cell weui-check__label" for="B">' + 
									'<div class="weui-cell__bd"><p>B：' + question.optionB + '</p></div>' +
									'<div class="weui-cell__ft">' +
										'<input type="radio" class="weui-check" name="single" id="B" value="B">' +
										'<span class="weui-icon-checked"></span>' + 
									'</div>' + 
								'</label>');	
							if (question.optionC) {
								$page.find('.ques-options').append(
									'<label class="weui-cell weui-check__label" for="C">' + 
										'<div class="weui-cell__bd"><p>C：' + question.optionC + '</p></div>' +
										'<div class="weui-cell__ft">' +
											'<input type="radio" class="weui-check" name="single" id="C" value="C">' +
											'<span class="weui-icon-checked"></span>' + 
										'</div>' + 
									'</label>');
							}
							if (question.optionD) {
								$page.find('.ques-options').append(
									'<label class="weui-cell weui-check__label" for="D">' + 
										'<div class="weui-cell__bd"><p>D：' + question.optionD + '</p></div>' +
										'<div class="weui-cell__ft">' +
											'<input type="radio" class="weui-check" name="single" id="D" value="D">' +
											'<span class="weui-icon-checked"></span>' + 
										'</div>' + 
									'</label>');
							}
							if (question.optionE) {
								$page.find('.ques-options').append(
									'<label class="weui-cell weui-check__label" for="C">' + 
										'<div class="weui-cell__bd"><p>E：' + question.optionE + '</p></div>' +
										'<div class="weui-cell__ft">' +
											'<input type="radio" class="weui-check" name="single" id="E" value="E">' +
											'<span class="weui-icon-checked"></span>' + 
										'</div>' + 
									'</label>');
							}
							if (question.optionF) {
								$page.find('.ques-options').append(
									'<label class="weui-cell weui-check__label" for="F">' + 
										'<div class="weui-cell__bd"><p>F：' + question.optionF + '</p></div>' +
										'<div class="weui-cell__ft">' +
											'<input type="radio" class="weui-check" name="single" id="F" value="F">' +
											'<span class="weui-icon-checked"></span>' + 
										'</div>' + 
									'</label>');
							}
						}
						// 多选题
						else if (question.type == 2) {
							$page.find('.ques-options').addClass('weui-cells_checkbox');
							$page.find('.ques-options').append(
								'<label class="weui-cell weui-check__label" for="A">' + 
									'<div class="weui-cell__bd"><p>A：' + question.optionA + '</p></div>' +
									'<div class="weui-cell__ft">' +
										'<input type="checkbox" class="weui-check" name="multiple" id="A" value="A">' +
										'<span class="weui-icon-checked"></span>' + 
									'</div>' + 
								'</label>');	
							$page.find('.ques-options').append(
								'<label class="weui-cell weui-check__label" for="B">' + 
									'<div class="weui-cell__bd"><p>B：' + question.optionB + '</p></div>' +
									'<div class="weui-cell__ft">' +
										'<input type="checkbox" class="weui-check" name="multiple" id="B" value="B">' +
										'<span class="weui-icon-checked"></span>' + 
									'</div>' + 
								'</label>');
							if (question.optionC) {
								$page.find('.ques-options').append(
									'<label class="weui-cell weui-check__label" for="C">' + 
										'<div class="weui-cell__bd"><p>C：' + question.optionC + '</p></div>' +
										'<div class="weui-cell__ft">' +
											'<input type="checkbox" class="weui-check" name="multiple" id="C" value="C">' +
											'<span class="weui-icon-checked"></span>' + 
										'</div>' + 
									'</label>');
							}
							if (question.optionD) {
								$page.find('.ques-options').append(
									'<label class="weui-cell weui-check__label" for="D">' + 
										'<div class="weui-cell__bd"><p>D：' + question.optionD + '</p></div>' +
										'<div class="weui-cell__ft">' +
											'<input type="checkbox" class="weui-check" name="multiple" id="D" value="D">' +
											'<span class="weui-icon-checked"></span>' + 
										'</div>' + 
									'</label>');
							}
							if (question.optionE) {
								$page.find('.ques-options').append(
									'<label class="weui-cell weui-check__label" for="E">' + 
										'<div class="weui-cell__bd"><p>E：' + question.optionE + '</p></div>' +
										'<div class="weui-cell__ft">' +
											'<input type="checkbox" class="weui-check" name="multiple" id="E" value="E">' +
											'<span class="weui-icon-checked"></span>' + 
										'</div>' + 
									'</label>');								
							}
							if (question.optionF) {
								$page.find('.ques-options').append(
									'<label class="weui-cell weui-check__label" for="F">' + 
										'<div class="weui-cell__bd"><p>F：' + question.optionF + '</p></div>' +
										'<div class="weui-cell__ft">' +
											'<input type="checkbox" class="weui-check" name="multiple" id="F" value="F">' +
											'<span class="weui-icon-checked"></span>' + 
										'</div>' + 
									'</label>');
							}
							$page.find('.ques-options').append(
								'<div class="weui-cell">' +
									'<div class="weui-cell__bd">' + 
										'<a class="weui-btn weui-btn_plain-primary btn-question-submit" href="javascript:;">提交</a>' + 
									'</div>' +
								'</div>');
						}
						// 判断题
						else if (question.type == 3) {
							$page.find('.ques-options').addClass('weui-cells_radio');
							$page.find('.ques-options').append(
								'<label class="weui-cell weui-check__label" for="A">' + 
									'<div class="weui-cell__bd"><p>正确</p></div>' +
									'<div class="weui-cell__ft">' +
										'<input type="radio" class="weui-check" name="boolean" id="A" value="A">' +
										'<span class="weui-icon-checked"></span>' + 
									'</div>' + 
								'</label>');
							$page.find('.ques-options').append(
								'<label class="weui-cell weui-check__label" for="B">' + 
									'<div class="weui-cell__bd"><p>错误</p></div>' +
									'<div class="weui-cell__ft">' +
										'<input type="radio" class="weui-check" name="boolean" id="B" value="B">' +
										'<span class="weui-icon-checked"></span>' + 
									'</div>' + 
								'</label>');
						}
					}
				}
			});
		}
		
		
	})( Zepto )
	</script>

</body>
</html>