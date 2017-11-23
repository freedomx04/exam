<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/include/preload.jsp"%>

<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	
	<title>视频</title>
	
	<link rel="stylesheet" type="text/css" href="${ctx}/plugins/bootstrap/3.3.6/css/bootstrap.min.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/plugins/font-awesome/4.7.0/css/font-awesome.min.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/plugins/animate/animate.min.css">
	
	<script type="text/javascript" src="${ctx}/plugins/jquery/2.1.4/jquery.min.js"></script>
	<script type="text/javascript" src="${ctx}/plugins/jquery/jquery.cookie.js"></script>
	<script type="text/javascript" src="${ctx}/plugins/jwplayer/jwplayer.js"></script>
	<script type="text/javascript" src="${ctx}/plugins/jwplayer/jwplayer.controls.js"></script>
	<script>jwplayer.key="1XjAHokrtWKykp8f4kSZSg4wQI0BgQlvblMGKA==";</script>  
	
</head>

<body class="gray-bg" onbeforeunload="return rectime()">

	<div id="myplayer"></div>

	<script type="text/javascript">
		var jwplayerInit = jwplayer('myplayer');
	
		jwplayerInit.setup({
			flashplayer: './jwplayer/jwplayer.flash.swf',
			file: '${ctx}/video/xLNc8cP0-1753142.mp4',
			width: '640',
			height: '640'
		});
	
		var cookieName = "playTime";
		var playTime = 0;
		function rectime(){
			playTime = jwplayer().getPosition();
			$.cookie(cookieName, playTime);
		}


		if ($.cookie(cookieName)) {
			playTime = $.cookie(cookieName);
		}
		//alert(playTime);


		jwplayer().on('firstFrame', function() { 
			jwplayer().seek(playTime);
		});
	</script>
</body>
</html>