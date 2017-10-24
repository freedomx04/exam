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
					<h3>试卷标题：${paper.title}</h3>
					<h3>开始时间：<fmt:formatDate value="${paper.startTime}" pattern='yyyy年MM月dd日 HH:mm'/></h3>
					<h3>结束时间：<fmt:formatDate value="${paper.endTime}" pattern='yyyy年MM月dd日 HH:mm'/></h3>
					<h3>试卷状态：<span class="tips-error">不可用</span></h3>
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
					<h3>开始时间：<span class="tips-error"><fmt:formatDate value="${paper.startTime}" pattern='yyyy年MM月dd日 HH:mm'/></span></h3>
					<h3>结束时间：<fmt:formatDate value="${paper.endTime}" pattern='yyyy年MM月dd日 HH:mm'/></h3>
					<h3>试卷状态：可用</h3>
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
					<h3>开始时间：<fmt:formatDate value="${paper.startTime}" pattern='yyyy年MM月dd日 HH:mm'/></h3>
					<h3>结束时间：<span class="tips-error"><fmt:formatDate value="${paper.endTime}" pattern='yyyy年MM月dd日 HH:mm'/></span></h3>
					<h3>试卷状态：可用</h3>
					<h3>登录时间：<fmt:formatDate value="${now}" pattern='yyyy年MM月dd日 HH:mm'/></h3>
					<h3 class="tips-info-other">如有疑问，请联系网站管理员</h3>
				</div>
				<div class="hr-line-solid"></div>
			</div>
		</c:when>
		
		<c:when test="${tipsType == 4}">
			<div class="tips-card">
				<h3>考生登录</h3>
				<div class="hr-line-solid"></div>
			</div>
		</c:when>
	</c:choose>

</body>
</html>
