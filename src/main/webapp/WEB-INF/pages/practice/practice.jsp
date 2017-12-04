<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/include/preload.jsp"%>

<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <title>模拟练习</title>
    
    <link rel="stylesheet" type="text/css" href="${ctx}/plugins/bootstrap/3.3.6/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/plugins/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/plugins/awesome-bootstrap-checkbox/awesome-bootstrap-checkbox.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/plugins/animate/animate.min.css">
    
    <link rel="stylesheet" type="text/css" href="${ctx}/plugins/hplus/style.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/plugins/toastr/toastr.min.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/local/common.css">
    
  <style type="text/css">
    .practice-container {
    	width: 1000px;
    	display: flex;
    	display: -webkit-flex;
    	-webkit-align-items: center;
    	align-items: center;
    	-webkit-justify-content: center;
    	justify-content: center;
    	margin: 0px auto;
    	height: 100%;
    }
    .practice-main {
    	width: 100%;
    	background: #fff;
    	border-radius: 2px;
    	padding: 60px;
    }
    .item-logo {
    	width: 228px;
    	height: 120px;
    	background-color: #fff;
    	padding: 2px;
    	border-radius: 5px;
    	margin: 0 auto;
    }
    .item-logo .fill-color {
    	width: 228px;
    	height: 120px;
    	padding-top: 16px;
    	overflow: hidden;
    	display: inline-block;
    }
    .item-logo .fill-color .lg {
    	width: 88px;
    	height: 88px;
    	margin: 0 auto;
    	overflow: hidden;
    	background-image: url("./img/practice.png");
    	background-repeat: no-repeat;
    }
    .item-text {
    	height: 74px;
    	text-align: center;
    	line-height: 58px;
    }
    .item-text a {
    	color: #8c8c8c;
    }
    </style>
    
</head>
<body class="gray-bg body-practice">
	<div class="practice-container">
		<div class="practice-main">
			<div class="row">
				<div class="col-sm-4 item">
					<div class="item-logo">
						<a class="fill-color" href="${ctx}/practice/order" style="background-color: #fcc056;">
							<div class="lg" style="background-position: -1px -890px;"></div>
						</a>
					</div>
					<div class="item-text">
						<a href="${ctx}/practice/order">顺序练习</a>
					</div>
				</div>
				<div class="col-sm-4 item">
					<div class="item-logo">
						<a class="fill-color" href="${ctx}/practice/random" style="background-color: #fe7e4c;">
							<div class="lg" style="background-position: -89px -890px;"></div>
						</a>
					</div>
					<div class="item-text">
						<a href="#">随机练习</a>
					</div>
				</div>
				<div class="col-sm-4 item">
					<div class="item-logo">
						<a class="fill-color" href="${ctx}/practice/library" style="background-color: #6cceec;">
							<div class="lg" style="background-position: -1px -978px;"></div>
						</a>
					</div>
					<div class="item-text">
						<a href="#">题库练习</a>
					</div>
				</div>
				<div class="col-sm-4 item">
					<div class="item-logo">
						<a class="fill-color" href="${ctx}/practice/type" style="background-color: #fd6467;">
							<div class="lg" style="background-position: -89px -978px;"></div>
						</a>
					</div>
					<div class="item-text">
						<a href="#">题型练习</a>
					</div>
				</div>
				<div class="col-sm-4 item">
					<div class="item-logo">
						<a class="fill-color practice-exam" href="#" style="background-color: #f76f93;">
							<div class="lg" style="background-position: -89px -1066px;"></div>
						</a>
					</div>
					<div class="item-text">
						<a href="#">模拟考试</a>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<script type="text/javascript" src="${ctx}/plugins/jquery/2.1.4/jquery.min.js"></script>
	<script type="text/javascript" src="${ctx}/plugins/bootstrap/3.3.6/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="${ctx}/plugins/hplus/content.min.js"></script>
	<script type="text/javascript" src="${ctx}/local/common.js"></script>
	
	<script type="text/javascript">
	;(function( $ ) {
		
		$('.practice-exam').on('click', function() {
			alert('开发中');
		});
		
	}) ( jQuery );
	</script>
</body>
</html>