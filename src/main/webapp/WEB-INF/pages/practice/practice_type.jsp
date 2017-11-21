<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/include/preload.jsp"%>

<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <title>题型练习</title>
    
    <link rel="stylesheet" type="text/css" href="${ctx}/plugins/bootstrap/3.3.6/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/plugins/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/plugins/animate/animate.min.css">
    
    <link rel="stylesheet" type="text/css" href="${ctx}/plugins/hplus/style.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/local/common.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/local/online.css">
    
</head>
<body class="gray-bg body-practice-type">
	<div>
		<header role="banner" class="exam-banner fixed">
			<div class="exam-banner-inner">
				<div style="font-size: 18px;">题型列表</div>
			</div>
		</header>
		<div class="exam-banner-holder"></div>
	</div>
	
	<main role="main">
		<div class="exam-container">
			<div class="card exam-ques" style="width: 1180px;">
				<c:forEach var="type" items="${typeList}">
					<div class="row" data-type="${type.type}">
						<div class="col-sm-6 col-sm-offset-1" style="height: 39px; line-height: 39px;">
					 		<span>${type.name}&nbsp;( ${type.count} )</span>
					 	</div>
					 	<div class="col-sm-4">
					 		<c:if test="${type.count == 0}">
					 			<button type="button" class="btn btn-sm1 btn-blue btn-practice-order" disabled>顺序练习</button>
					 			<button type="button" class="btn btn-sm1 btn-warning btn-practice-random" disabled>随机练习</button>
					 		</c:if>
					 		<c:if test="${type.count > 0}">
					 			<button type="button" class="btn btn-sm1 btn-blue btn-practice-order">顺序练习</button>
					 			<button type="button" class="btn btn-sm1 btn-warning btn-practice-random">随机练习</button>
					 		</c:if>
					 	</div>
					</div>
				</c:forEach>
			</div>
		</div>
	</main>
	
	<script type="text/javascript" src="${ctx}/plugins/jquery/2.1.4/jquery.min.js"></script>
    <script type="text/javascript" src="${ctx}/plugins/bootstrap/3.3.6/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="${ctx}/plugins/hplus/content.min.js"></script>
    <script type="text/javascript" src="${ctx}/local/common.js"></script>
    
    <script type="text/javascript">
    ;(function( $ ) {
    	
		var $page = $('.body-practice-type');
    	
    	$page
    	.on('click', '.btn-practice-order', function() {
    		var type = $(this).closest('.row').data('type');
    		window.location.href = '${ctx}/practice/order?type=' + type;
    	})
    	.on('click', '.btn-practice-random', function() {
    		var type = $(this).closest('.row').data('type');
    		window.location.href = '${ctx}/practice/random?type=' + type;
    	});
    
    }) ( jQuery );
    </script>
</body>
</html>