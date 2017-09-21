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
    .body-practice-library .btn {
    	width: 100px;
    }
    </style>
</head>

<body class="gray-bg body-practice-library">
	<div class="wrapper wrapper-content animated fadeInRight">
		<div class="ibox float-e-margins">
			<div class="ibox-content">
				<h2 class="page-title">题库练习</h2>
				
				 <div class="hr-line-dashed"></div>
				 <c:forEach var="library" items="${libraryList}">
				 <div class="row" style="margin-top: 5px;" data-library-id="${library.id}">
				 	<div class="col-sm-6 col-sm-offset-1" style="height: 39px; line-height: 39px;">
				 		<span style="font-size: 18px;">${library.name}<span style="padding-left: 10px;">( ${library.count} 题 )</span></span>
				 	</div>
				 	<div class="col-sm-4">
				 		<c:if test="${library.count == 0}">
				 			<button type="button" class="btn btn-blue btn-practice-order" disabled>顺序练习</button>
				 			<button type="button" class="btn btn-warning btn-practice-random" disabled>随机练习</button>
				 		</c:if>
				 		<c:if test="${library.count > 0}">
				 			<button type="button" class="btn btn-blue btn-practice-order">顺序练习</button>
				 			<button type="button" class="btn btn-warning btn-practice-random">随机练习</button>
				 		</c:if>
				 	</div>
				 </div>
				 </c:forEach>
			</div>
		</div>
	</div>
	
	<script type="text/javascript" src="${ctx}/plugins/jquery/2.1.4/jquery.min.js"></script>
    <script type="text/javascript" src="${ctx}/plugins/bootstrap/3.3.6/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="${ctx}/plugins/hplus/content.min.js"></script>
    <script type="text/javascript" src="${ctx}/local/common.js"></script>
    
    <script type="text/javascript" src="${ctx}/plugins/toastr/toastr.min.js"></script>
    
    <script type="text/javascript">
    	
    	var $page = $('.body-practice-library');
    	
    	$page
    	.on('click', '.btn-practice-order', function() {
    		var libraryId = $(this).closest('.row').data('libraryId');
    		window.location.href = '${ctx}/practiceOrder?libraryId=' + libraryId;
    	})
    	.on('click', '.btn-practice-random', function() {
    		var libraryId = $(this).closest('.row').data('libraryId');
    		window.location.href = '${ctx}/practiceRandom?libraryId=' + libraryId;
    	});
    
    </script>

</body>
</html>