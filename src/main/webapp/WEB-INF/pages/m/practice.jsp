<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/include/preload.jsp"%>

<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0">
    
    <title>模拟练习</title>
    
    <link rel="stylesheet" type="text/css" href="${ctx}/plugins/weui/weui.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/plugins/weui/example.css">
    
</head>
<body>
	<div class="weui-cells__title">请选择模拟练习类型</div>
	<div class="weui-cells">
		<a class="weui-cell weui-cell_access" href="${ctx}/m/practice/order">
			<div class="weui-cell__bd">
				<p>顺序练习</p>
			</div>
			<div class="weui-cell__ft"></div>
		</a>
		
		<a class="weui-cell weui-cell_access" href="#">
			<div class="weui-cell__bd">
				<p>随机练习</p>
			</div>
			<div class="weui-cell__ft"></div>
		</a>
		
		<a class="weui-cell weui-cell_access" href="#">
			<div class="weui-cell__bd">
				<p>题库练习</p>
			</div>
			<div class="weui-cell__ft"></div>
		</a>
		
		<a class="weui-cell weui-cell_access" href="#">
			<div class="weui-cell__bd">
				<p>题型练习</p>
			</div>
			<div class="weui-cell__ft"></div>
		</a>
	</div>
	
	<script type="text/javascript" src="${ctx}/plugins/weui/zepto.min.js"></script>
	
	<script type="text/javascript">
	;(function ( $ ) {
		
		
	})( Zepto )
	</script>

</body>
</html>