<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/include/preload.jsp"%>

<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0">
    
    <title>${title}</title>
    
    <link rel="stylesheet" type="text/css" href="${ctx}/plugins/weui/weui.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/plugins/weui/example.css">
    
</head>
<body>
	<div class="weui-cells">
		<div class="weui-cell">
			<div class="weui-cell__bd">
				<p>动画2中有几种违法行为？</p>
			</div>
		</div>
	</div>
	<div class="weui-cells weui-cells_radio">
		<label class="weui-cell weui-check__label" for="A">
			<div class="weui-cell__bd">
				<p>A：一种违法行为</p>
			</div>
			<div class="weui-cell__ft">
				<input type="radio" class="weui-check" name="radio1" id="A"/>
				<span class="weui-icon-checked"></span>
			</div>
		</label>
		<label class="weui-cell weui-check__label" for="B">
			<div class="weui-cell__bd">
				<p>B：两种违法行为</p>
			</div>
			<div class="weui-cell__ft">
				<input type="radio" class="weui-check" name="radio1" id="B"/>
				<span class="weui-icon-checked"></span>
			</div>
		</label>
		<label class="weui-cell weui-check__label" for="C">
			<div class="weui-cell__bd">
				<p>C：三种违法行为</p>
			</div>
			<div class="weui-cell__ft">
				<input type="radio" class="weui-check" name="radio1" id="C"/>
				<span class="weui-icon-checked"></span>
			</div>
		</label>
		<label class="weui-cell weui-check__label" for="D">
			<div class="weui-cell__bd">
				<p>D：四种违法行为</p>
			</div>
			<div class="weui-cell__ft">
				<input type="radio" class="weui-check" name="radio1" id="D"/>
				<span class="weui-icon-checked"></span>
			</div>
		</label>
	</div>
	

	<script type="text/javascript" src="${ctx}/plugins/weui/zepto.min.js"></script>
	
	<script type="text/javascript">
	;(function ( $ ) {
		
		var $page = $('.body-practice-question');
		var idList = '${idList}';
		idList = idList.replace('[', '').replace(']', '');
		var ids = idList.split(',');
		
		var seq = 0;
		var question;
		
		
	})( Zepto )
	</script>

</body>
</html>