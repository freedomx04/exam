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
    <link rel="stylesheet" type="text/css" href="${ctx}/plugins/animate/animate.min.css">
    
    <link rel="stylesheet" type="text/css" href="${ctx}/plugins/hplus/style.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/local/common.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/plugins/toastr/toastr.min.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/local/online.css">
   
</head>
<body class="gray-bg body-online-tips" style="min-width: 1000px; overflow: auto;">
	<div>
		<header role="banner" class="exam-banner fixed">
			<div class="exam-banner-inner">
				<div style="font-size: 18px;">${paper.title}</div>
			</div>
		</header>
		<div class="exam-banner-holder"></div>
	</div>
	
	<c:set var="now" value="<%=new java.util.Date()%>"/>
	<c:choose>
		<c:when test="${tipsType == 1}">
			<div class="tips-card">
				<h3>考生登录通知</h3>
				<div class="hr-line-solid"></div>
				<div class="tips-info">
					<h3 class="tips-info-header tips-error">你当前登录的试卷不可用</h3>
					<h3>试卷状态：<span class="tips-error">不可用</span></h3>
					<h3>试卷标题：${paper.title}</h3>
					<h3>开始时间：<fmt:formatDate value="${paper.startTime}" pattern='yyyy年MM月dd日 HH:mm'/></h3>
					<h3>结束时间：<fmt:formatDate value="${paper.endTime}" pattern='yyyy年MM月dd日 HH:mm'/></h3>
					<h3>登录时间：<fmt:formatDate value="${now}" pattern='yyyy年MM月dd日 HH:mm'/></h3>
					<h3 class="tips-info-other">如有疑问，请联系网站管理员</h3>
				</div>
				<div class="hr-line-solid"></div>
			</div>
		</c:when>
		
		<c:when test="${tipsType == 2}">
			<div class="tips-card">
				<h3>考生登录通知</h3>
				<div class="hr-line-solid"></div>
				<div class="tips-info">
					<h3 class="tips-info-header tips-error">当前时间不在允许考试的时间范围内</h3>
					<h3>试卷标题：${paper.title}</h3>
					<h3>试卷状态：可用</h3>
					<h3>开始时间：<span class="tips-error"><fmt:formatDate value="${paper.startTime}" pattern='yyyy年MM月dd日 HH:mm'/></span></h3>
					<h3>结束时间：<fmt:formatDate value="${paper.endTime}" pattern='yyyy年MM月dd日 HH:mm'/></h3>
					<h3>登录时间：<fmt:formatDate value="${now}" pattern='yyyy年MM月dd日 HH:mm'/></h3>
					<h3 class="tips-info-other">如有疑问，请联系网站管理员</h3>
				</div>
				<div class="hr-line-solid"></div>
			</div>
		</c:when>
		
		<c:when test="${tipsType == 3}">
			<div class="tips-card">
				<h3>考生登录通知</h3>
				<div class="hr-line-solid"></div>
				<div class="tips-info">
					<h3 class="tips-info-header tips-error">当前时间不在允许考试的时间范围内</h3>
					<h3>试卷标题：${paper.title}</h3>
					<h3>试卷状态：可用</h3>
					<h3>开始时间：<fmt:formatDate value="${paper.startTime}" pattern='yyyy年MM月dd日 HH:mm'/></h3>
					<h3>结束时间：<span class="tips-error"><fmt:formatDate value="${paper.endTime}" pattern='yyyy年MM月dd日 HH:mm'/></span></h3>
					<h3>登录时间：<fmt:formatDate value="${now}" pattern='yyyy年MM月dd日 HH:mm'/></h3>
					<h3 class="tips-info-other">如有疑问，请联系网站管理员</h3>
				</div>
				<div class="hr-line-solid"></div>
			</div>
		</c:when>
		
		<c:when test="${tipsType == 4}">
			<div class="tips-card">
				<div id="toast-container" class="toast-top-center hide" role="alert" style="position: absolute; top: -60px;">
					<div class="toast toast-error">
						<div class="toast-message"></div>
					</div>
				</div>
				
				<h3>考生登录</h3>
				<div class="hr-line-solid"></div>
				<form class="form-login form-horizontal" role="form" autocomplete="off" style="padding: 20px 40px;">
					<div class="form-group">
						<div class="col-sm-12">
							<div class="input-group">
								<span class="input-group-addon"><i class="fa fa-user fa-fw fa-lg"></i></span>
								<input type="text" class="form-control" name="username" placeholder="请输入考生考号">
							</div>
						</div>
					</div>
					
					<div class="form-group">
						<div class="col-sm-12">
							<div class="input-group">
								<span class="input-group-addon"><i class="fa fa-lock fa-fw fa-lg"></i></span>
								<input type="password" class="form-control" name="password" placeholder="请输入登录密码">
							</div>
						</div>
					</div>
					
					<div class="form-group">
						<div class="col-sm-12">
							<div class="input-group">
								<span class="input-group-addon"><i class="fa fa-shield fa-fw fa-lg"></i></span>
								<input type="text" class="form-control" name="kaptcha" placeholder="请输入验证码" data-fv-field="validCode">
								<a class="input-group-addon padding-0 reload-vify" href="javascript:;">
	                                <img id="kaptcha-img" src="${ctx}/api/kaptcha/captcha.jpg" height="40" title="点击更换"/>
	                            </a>
							</div>
						</div>
					</div>
					
					<div class="form-group" style="margin-top: 40px;">
						<div class="col-sm-12">
							<button type="submit" class="btn btn-primary btn-block">登&nbsp;&nbsp;录</button>
						</div>
					</div>
				</form>
			</div>
		</c:when>
		
		<c:when test="${tipsType == 5}">
			<div class="tips-card">
				<h3>登录成功</h3>
				<div class="hr-line-solid"></div>
				<div class="tips-info">
					<h3>试卷标题：${paper.title}</h3>
					<h3>试卷状态：可用</h3>
					<h3>开始时间：<fmt:formatDate value="${paper.startTime}" pattern='yyyy年MM月dd日 HH:mm'/></h3>
					<h3>结束时间：<fmt:formatDate value="${paper.endTime}" pattern='yyyy年MM月dd日 HH:mm'/></h3>
					<h3>考试时间：${paper.duration}分钟</h3>
					<h3>登录时间：<fmt:formatDate value="${now}" pattern='yyyy年MM月dd日 HH:mm'/></h3>
					<h3 class="tips-info-other">如果考试异常中断，请退出并及时按同样步骤进入，继续考试</h3>
				</div>
				<div class="hr-line-solid"></div>
				<div class="tips-button">
					<button type="button" class="btn btn-primary btn-block btn-exam-start">开始考试</button>
				</div>
			</div>
		</c:when>
		
		<c:when test="${tipsType == 6}">
			<div class="tips-card">
				<h3>提交成功</h3>
				<div class="hr-line-solid"></div>
				<div class="tips-info">
					<h3>试卷标题：${paper.title}</h3>
					<h3>试卷状态：可用</h3>
					<h3>开始时间：<fmt:formatDate value="${paper.startTime}" pattern='yyyy年MM月dd日 HH:mm'/></h3>
					<h3>结束时间：<fmt:formatDate value="${paper.endTime}" pattern='yyyy年MM月dd日 HH:mm'/></h3>
					<h3>考试时间：${paper.duration}分钟</h3>
					<h3>提交时间：<fmt:formatDate value="${submitTime}" pattern='yyyy年MM月dd日 HH:mm'/></h3>
					<h3 class="tips-info-other">您的试卷已提交，请耐心等待老师批阅。</h3>
				</div>
			</div>
		</c:when>
	</c:choose>
	
	<script type="text/javascript" src="${ctx}/plugins/jquery/2.1.4/jquery.min.js"></script>
	<script type="text/javascript" src="${ctx}/plugins/bootstrap/3.3.6/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="${ctx}/plugins/hplus/content.min.js"></script>
	<script type="text/javascript" src="${ctx}/local/common.js"></script>
	
	<script type="text/javascript">
	;(function( $ ) {
		
		var paperId = '${paper.id}';
		var $page = $('.body-online-tips');
		var $form = $page.find('.form-login');
		var $kaptcha = $form.find('input[name="kaptcha"]');
		var $kaptcha_img = $form.find('#kaptcha-img');
		
		var $toast = $page.find('#toast-container');
		var $toastmsg = $toast.find('.toast-message');
		
		// 获取焦点
		$form.find('input[name="username"]').focus();
		
		//点击更换图形验证码
		$kaptcha_img.click(function() {
			$(this).attr("src", "${ctx}/api/kaptcha/captcha.jpg?t=" + Math.random()); 
		});
		
		$form.submit(function(e) {
			var username = $form.find('input[name="username"]').val();
			var password = $form.find('input[name="password"]').val();
			var captcha = $kaptcha.val();
			
			if (username == '' && password == '') {
				$toastmsg.text('请输入考生考号和登录密码！');
				$toast.removeClass('hide');
				return false;
			}
			if (username == '') {
				$toastmsg.text('请输入考生考号！');
				$toast.removeClass('hide');
				return false;
			}
			if (password == '') {
				$toastmsg.text('请输入登录密码！');
				$toast.removeClass('hide');
				return false;
			}
			if (captcha == '') {
				$toastmsg.text('请输入验证码！');
				$toast.removeClass('hide');
				return false;
			}
			
			$.ajax({
				url: '${ctx}/api/kaptcha/check',
				type: 'post',
				data: {
					kaptcha: captcha
				},
				success: function(data) {
					if (data.code == 0) {
						$.ajax({
							url: '${ctx}/api/exam/login',
							type: 'post',
							data: {
								paperId: paperId,
								username: username,
								password: password
							},
							success: function(ret) {
								if (ret.code == 0) {
									window.location.reload();
								} else {
									$toastmsg.text(ret.msg);
									$toast.removeClass('hide');
									$kaptcha_img.attr("src","${ctx}/api/kaptcha/captcha.jpg?t=" + Math.random()); 
									$kaptcha.val("");
								}
							},
							error: function(err) {}
						});
					} else {
						$toastmsg.text('验证码错误，请重新输入！');
						$toast.removeClass('hide');
						$kaptcha_img.attr("src","${ctx}/api/kaptcha/captcha.jpg?t=" + Math.random()); 
						$kaptcha.val("");
					}
				},
				error: function(err) {}
			});
			
			return false;
		});
		
		$page
		.on('click', '.btn-exam-start', function() {
			window.location.href = '${ctx}/online/exam';
		});
		
	})( jQuery );
	</script>
	

</body>
</html>
