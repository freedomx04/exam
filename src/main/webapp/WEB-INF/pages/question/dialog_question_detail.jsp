<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<link rel="stylesheet" type="text/css" href="${ctx}/local/online.css">

<div class="modal" id="modal-question-dialog" tabindex="-1" role="dialog" aria-hidden="true" data-backdrop="static">
    <div class="modal-dialog modal-center">
        <div class="modal-content animated fadeInDown">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                <h4 class="modal-title">试题详情</h4>
            </div>
            <div class="modal-body" style="padding: 15px 30px;">
            	<p class="ques-info"></p>
            	<p class="ques-title"></p>
				<p class="ques-image"></p>
				<ul class="unstyled ques-options"></ul> 
				
				<div class="ques-tips">
					<p class="ques-answer color-success"></p>
					<p class="ques-analysis"></p>
				</div>                 
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary btn-fw" data-dismiss="modal">取消</button>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">

	function showQuestion(question) {
		var $dialog = $('#modal-question-dialog');
		
		// 试题信息
		var quesType;
		switch (question.type) {
		case 1:		quesType = '单选题';	break;
		case 2:		quesType = '多选题';	break;
		case 3:		quesType = '判断题';	break;
		}
		$dialog.find('.ques-info').text('【' + quesType + '】【' + question.score + '分】');
		
		// 试题题干
		$dialog.find('.ques-title').text(question.title);
		// 试题图片
		$dialog.find('.ques-image').empty();
		if (question.imagePath) {
			$dialog.find('.ques-image').append('<img src="${ctx}' + question.imagePath + '">');
		}
		
		// 试题选项
		$dialog.find('.ques-options').empty();
		if (question.type == 3) {
			var answer = question.answer == 'A' ? '正确' : '错误';
			$dialog.find('.ques-answer').text('【答案】' + answer);
		} else {
			$dialog.find('.ques-options').append('<li>A：' + question.optionA + '</li>');
			$dialog.find('.ques-options').append('<li>B：' + question.optionB + '</li>');
			if (question.optionC) {
				$dialog.find('.ques-options').append('<li>C：' + question.optionC + '</li>');
			}
			if (question.optionD) {
				$dialog.find('.ques-options').append('<li>D：' + question.optionD + '</li>');
			}
			if (question.optionE) {
				$dialog.find('.ques-options').append('<li>E：' + question.optionE + '</li>');
			}
			if (question.optionF) {
				$dialog.find('.ques-options').append('<li>F：' + question.optionF + '</li>');
			}
			$dialog.find('.ques-answer').text('【答案】' + question.answer);
		}
		// 试题解析
		if (!question.analysis) {
			question.analysis = '无';
		}
		$dialog.find('.ques-analysis').text('【解析】' + question.analysis);
		$dialog.modal('show');
	}

</script>