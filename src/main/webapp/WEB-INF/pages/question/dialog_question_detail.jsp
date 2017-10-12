<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div class="modal" id="modal-question-dialog" tabindex="-1" role="dialog" aria-hidden="true" data-backdrop="static">
    <div class="modal-dialog" style="width: 800px;">
        <div class="modal-content animated fadeInDown">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                <h3 class="modal-title">试题详情</h3>
            </div>
            <div class="modal-body" style="padding: 20px 40px;">
                <form class="form-horizontal" role="form" id="form-area" autocomplete="off">
                    <div class="form-group">
                        <div class="col-sm-12">
                            <span class="ques-type" style="margin-right: 5px;"></span>
                            <span class="ques-title" style="font-size: 14px; line-height: 2em;"></span>
                        </div>
                    </div>
                    
                    <div class="form-group">
                    	<div class="col-sm-6">
                    		<ul class="unstyled ques-options" style="padding-left: 0; line-height: 2em;"></ul>
                    	</div>
                    	<div class="col-sm-6">
                    		<img class="ques-image" src="" style="max-width: 100%; max-height: 100%;">
                    	</div>
                    </div>
                    
                    <div class="form-group">
                    	<div class="col-sm-4">
                    		正确答案: <span class="ques-answer font-bold" style="font-size: 20px;"></span>
                    	</div>
                    </div>
                    
                   	<div class="form-group">
                   		<div class="col-sm-4">
                    		分数: <span class="ques-score"></span>
                    	</div>
                   	</div>
                    
                    <div class="form-group">
                    	<div class="col-sm-12">
                    		试题解析: <span class="ques-analysis"></span>
                    	</div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary btn-fw" data-dismiss="modal">关&nbsp;闭</button>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">

	function showQuestion(question) {
		var $dialog = $('#modal-question-dialog');
		
		// 试题类型
		$dialog.find('.ques-type').removeClass('ques-single ques-multiple ques-boolean');
		switch (question.type) {
		case 1:
			$dialog.find('.ques-type').addClass('ques-single').text('单选题');
			break;
		case 2:
			$dialog.find('.ques-type').addClass('ques-multiple').text('多选题');
			break;
		case 3:
			$dialog.find('.ques-type').addClass('ques-boolean').text('判断题');
			break;
		}
		
		// 试题选项
		$dialog.find('.ques-options').empty();
		if (question.type == 3) {
			var answer = question.answer == 'A' ? '正确' : '错误';
			$dialog.find('.ques-answer').text(answer);
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
			$dialog.find('.ques-answer').text(question.answer);
		}
		$dialog.find('.ques-title').text(question.title);
		if (question.imagePath) {
			$dialog.find('.ques-image').attr('src', '${ctx}' + question.imagePath);
		} else {
			$dialog.find('.ques-image').attr('src', '');
		}
		$dialog.find('.ques-score').text(question.score);
		$dialog.find('.ques-analysis').text(question.analysis);
		$dialog.modal('show');
	}

</script>