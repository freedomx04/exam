<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	
	<title>初始化</title>

	<link rel="shortcut icon" href="favicon.ico">
	<link rel="stylesheet" type="text/css" href="${ctx}/plugins/bootstrap/3.3.6/css/bootstrap.min.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/plugins/font-awesome/4.7.0/css/font-awesome.min.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/plugins/animate/animate.min.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/plugins/hplus/style.min.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/local/common.css">

</head>

<body class="gray-bg body-init">
	<div class="animated fadeInRight" style="padding: 60px;">
		<div class="row">
			<div class="col-lg-10 col-lg-offset-1">
				<div class="ibox float-e-margins">
					<div class="ibox-content">
						<form class="form-horizontal" role="form" id="form-init" style="padding: 40px;">
							<div class="form-group">
								<label class="col-sm-4 control-label">管理员角色</label>
								<div class="col-sm-2"><button type="button" class="btn btn-primary" data-type="role">初始化</button></div>
								<label class="col-sm-2 control-label init-result"></label>
							</div>
						
							<div class="form-group">
								<label class="col-sm-4 control-label">管理员账号</label>
								<div class="col-sm-2"><button type="button" class="btn btn-primary" data-type="admin">初始化</button></div>
								<label class="col-sm-2 control-label init-result"></label>
							</div>
							
							<div class="form-group">
								<label class="col-sm-4 control-label">默认题库</label>
								<div class="col-sm-2"><button type="button" class="btn btn-primary" data-type="library">初始化</button></div>
								<label class="col-sm-2 control-label init-result"></label>
							</div>
							
							<div class="form-group">
								<label class="col-sm-4 control-label">默认分组</label>
								<div class="col-sm-2"><button type="button" class="btn btn-primary" data-type="group">初始化</button></div>
								<label class="col-sm-2 control-label init-result"></label>
							</div>
							
							<div class="form-group">
								<label class="col-sm-4 control-label">默认分类</label>
								<div class="col-sm-2"><button type="button" class="btn btn-primary" data-type="classify">初始化</button></div>
								<label class="col-sm-2 control-label init-result"></label>
							</div>
							
						</form>
					</div>
				</div>
			</div>
		</div>
		
	</div>
	
	<script type="text/javascript" src="${ctx}/plugins/jquery/2.1.4/jquery.min.js"></script>
	<script type="text/javascript" src="${ctx}/plugins/bootstrap/3.3.6/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="${ctx}/plugins/jquery/jquery.cookie.js"></script>
	<script type="text/javascript" src="${ctx}/local/common.js"></script>

	<script type="text/javascript">
	;(function( $ ) {
	
		var $page = $('.body-init');
		
		$page.on('click', 'button', function() {
			var $this = $(this);
			var type = $this.data('type');
			var $msg = $this.closest('.form-group').find('.init-result');
			
			$.ajax({
				url: '${ctx}/api/init/' + type,
				success: function(ret) {
					$msg.text(ret.msg);
				},
				error: function(err) {}
			});
		});
		
	})( jQuery );
	</script>
	
</body>
</html>