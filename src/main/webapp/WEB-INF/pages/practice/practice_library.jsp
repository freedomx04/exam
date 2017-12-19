<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/include/preload.jsp"%>

<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1, user-scalable=no">
    
    <title>题库练习</title>
    
    <link rel="stylesheet" type="text/css" href="${ctx}/plugins/bootstrap/3.3.6/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/plugins/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/plugins/animate/animate.min.css">
    
    <link rel="stylesheet" type="text/css" href="${ctx}/local/common.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/local/online.css">
    
</head>
<body class="gray-bg body-practice-library">
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
	
	<div class="container" style="padding: 0;">
		<div class="card">
			<p><i class="fa fa-bars fa-fw"></i>题库列表</p>
			<c:forEach var="library" items="${libraryList}">
				<div class="hr-line-solid" style="margin: 10px 0;"></div>
				<div class="row" data-library-id="${library.id}">
					<div class="col-sm-6" style="height: 30px; line-height: 30px;">
						<span>${library.name}【共${library.count}题】</span>
					</div>
					<div class="col-sm-6">
						<c:if test="${library.count == 0}">
							<button type="button" class="btn btn-sm btn-blue btn-practice-order" disabled>顺序练习</button>
					 		<button type="button" class="btn btn-sm btn-warning btn-practice-random" disabled>随机练习</button>
						</c:if>
						<c:if test="${library.count > 0}">
							<button type="button" class="btn btn-sm btn-blue btn-practice-order">顺序练习</button>
					 		<button type="button" class="btn btn-sm btn-warning btn-practice-random">随机练习</button>
						</c:if>
					</div>
				</div>
			</c:forEach>
		</div>
	</div>
	
	<script type="text/javascript" src="${ctx}/plugins/jquery/2.1.4/jquery.min.js"></script>
    <script type="text/javascript" src="${ctx}/plugins/bootstrap/3.3.6/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="${ctx}/local/common.js"></script>
    
    <script type="text/javascript">
   	;(function( $ ) {
   		
    	var $page = $('.body-practice-library');
    	
    	$page
    	.on('click', '.btn-practice-order', function() {
    		var libraryId = $(this).closest('.row').data('libraryId');
    		window.location.href = '${ctx}/practice/order?libraryId=' + libraryId;
    	})
    	.on('click', '.btn-practice-random', function() {
    		var libraryId = $(this).closest('.row').data('libraryId');
    		window.location.href = '${ctx}/practice/random?libraryId=' + libraryId;
    	});
    
   	}) ( jQuery );
    </script>
    
</body>
</html>