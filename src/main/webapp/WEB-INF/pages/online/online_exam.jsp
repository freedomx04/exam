<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/include/preload.jsp"%>

<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <title>试卷编辑</title>
    
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
    .exam_banner {
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
    .exam_banner_inner {
    	position: relative;
    	display: flex;
    	width: 1000px;
    	height: 52px;
    	padding: 0 16px;
    	margin: 0 auto;
    	-webkit-box-align: center;
    	align-items: center;
    }
    .exam_banner_holder {
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
    .exam_container {
    	display: -webkit-box;
    	display: flex;
    	-webkit-box-align: start;
    	align-items: flex-start;
    	position: relative;
    	width: 1000px;
    	margin: 10px auto;
    }
    .exam_question {
    	position: relative;
    	padding: 16px 20px;
    }
    .exam_question ul li {
    	height: 30px;
    }
    </style>
    
</head>
<body class="gray-bg body-online-exam" style="min-width: 1000px; overflow: auto;">
	<div>
		<header role="banner" class="exam_banner fixed">
			<div class="exam_banner_inner">
				<div style="font-size: 18px;">${paper.title}</div>
				<div style="flex: 1; justify-content: flex-end; display: flex; align-items: center;">孙明明</div>
			</div>
		</header>
		<div class="exam_banner_holder"></div>
	</div>
	
	<main role="main" class="exam_main">
		<div class="exam_container">
			<div class="exam_question_list" style="margin-right: 10px; width: 694px;">
				<c:forEach var="question" items="${paper.questions}" varStatus="status">
					<div class="card exam_question" data-question-id="${question.id}">
						<div style="line-height: 1.6em;">
							<span>${status.index + 1}</span>
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
						</div>
						<div>
							<ul class="unstyled" style="margin-top: 15px;">
								<c:if test="${question.type == 1}">
									<li>
										<div class="radio radio-success radio-inline">
											<input type="radio" name="${question.id}-single" id="${question.id}-A" value="${question.id}-A">
											<label for="${question.id}-A">A：${question.optionA}</label>
										</div>
									</li>
									<li>
										<div class="radio radio-success radio-inline">
											<input type="radio" name="${question.id}-single" id="${question.id}-B" value="${question.id}-B">
											<label for="${question.id}-B">B：${question.optionB}</label>
										</div>
									</li>
									<c:if test="${not empty quetion.title}">
										<li>
											<div class="radio radio-success radio-inline">
												<input type="radio" name="${question.id}-single" id="${question.id}-C" value="${question.id}-C">
												<label for="${question.id}-C">C:${question.optionC}</label>
											</div>
										</li>
									</c:if>
									<%-- <c:if test="${not empty quetion.optionD}">
										<li>
											<div class="radio radio-success radio-inline">
												<input type="radio" name="single" id="D" value="D">
												<label for="D">D:${question.optionD}</label>
											</div>
										</li>
									</c:if>
									<c:if test="${not empty quetion.optionE}">
										<li>
											<div class="radio radio-success radio-inline">
												<input type="radio" name="single" id="E" value="E">
												<label for="E">E:${question.optionE}</label>
											</div>
										</li>
									</c:if>
									<c:if test="${not empty quetion.optionF}">
										<li>
											<div class="radio radio-success radio-inline">
												<input type="radio" name="single" id="F" value="F">
												<label for="F">F:${question.optionF}</label>
											</div>
										</li>
									</c:if>  --%>
								</c:if>
								
								<c:if test="${question.type == 2}">
								
								</c:if>
								
								<c:if test="${question.type == 3}">
									<li>
										<div class="radio radio-success radio-inline">
											<input type="radio" name="${question.id}-boolean" id="${question.id}-A" value="${question.id}-A">
											<label for="${question.id}-A">正确</label>
										</div>
									</li>
									<li>
										<div class="radio radio-success radio-inline">
											<input type="radio" name="${question.id}-boolean" id="${question.id}-B" value="${question.id}-B">
											<label for="${question.id}-B">错误</label>
										</div>
									</li>
								</c:if>
							</ul>
						</div>
					</div>
				</c:forEach> 
			</div>
			
			<div class="exam_controller fixed" style="width: 296px;">
				<div class="card">
					aa
				</div>
				
				<div class="card">
					bb
				</div>
			</div> 
		</div>
	</main>
	
	<script type="text/javascript" src="${ctx}/plugins/jquery/2.1.4/jquery.min.js"></script>
	<script type="text/javascript" src="${ctx}/plugins/bootstrap/3.3.6/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="${ctx}/plugins/hplus/content.min.js"></script>
	<script type="text/javascript" src="${ctx}/local/common.js"></script>
	
	<script type="text/javascript">
	
		var $page = $('.body-online-exam');
		setController();
		
		window.onresize = function() {
			setController();
		}
		
		function setController() {
			var $controller = $page.find('.exam_controller');
			var $width = $(document).width();
			var left_val = ($width - 1000) / 2 + 694 + 10;
			$controller.css('left', left_val);
		}
	
	</script>
	
</body>
</html>