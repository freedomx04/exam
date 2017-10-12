<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/include/preload.jsp"%>

<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <title>试卷设置</title>
    
    <link rel="stylesheet" type="text/css" href="${ctx}/plugins/bootstrap/3.3.6/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/plugins/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/plugins/animate/animate.min.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/plugins/sweetalert/sweetalert.css">
    
    <link rel="stylesheet" type="text/css" href="${ctx}/plugins/hplus/style.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/local/common.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/plugins/toastr/toastr.min.css">
    
    <style type="text/css">
    .body-paper-setting .desc {
    	text-align: left!important;
    }
    .body-paper-setting .sub-desc {
    	font-weight: normal;
    }
    </style>
</head>

<body class="gray-bg body-paper-setting">
	<div class="wrapper wrapper-content animated fadeInRight">
		<div class="ibox">
			<div class="ibox-content">
				<div class="page-title">
					<h2>试卷设置<small>${paper.title}</small></h2>
				</div>
				
				<form class="form-horizontal" role="form" autocomplete="off">
					<div class="form-group">
						<label for="" class="desc col-sm-2 col-sm-offset-2 control-label">进行考试</label>
						<div class="col-sm-6">
							<div>
								<label class="control-label sub-desc">考试总时长：</label>
								<input type="number" class="form-control" name="duration" min="0" value="${paper.duration}" style="width: 80px; display: inline-block;">&nbsp;&nbsp;分钟
							</div>
							<!-- <div style="margin-top: 10px;">
								<label class="control-label sub-desc">最短交卷时间, 0表示不限制时间：</label>
								<input type="number" class="form-control" name="duration" min="0" value="0" style="width: 80px; display: inline-block;">&nbsp;&nbsp;分钟
							</div> -->
						</div>
					</div>
					
					<div class="hr-line-solid"></div>
					<div class="form-group btn-operate">
						<div class="col-sm-5 col-sm-offset-2">
							<button type="button" class="btn btn-primary btn-fw btn-paper-save">保&nbsp;存</button>
							<button type="button" class="btn btn-white btn-fw btn-paper-cancel">返&nbsp;回</button>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
		
	<script type="text/javascript" src="${ctx}/plugins/jquery/2.1.4/jquery.min.js"></script>
	<script type="text/javascript" src="${ctx}/plugins/bootstrap/3.3.6/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="${ctx}/plugins/hplus/content.min.js"></script>
	<script type="text/javascript" src="${ctx}/local/common.js"></script>
	
	<script type="text/javascript" src="${ctx}/plugins/sweetalert/sweetalert.min.js"></script>
    <script type="text/javascript" src="${ctx}/plugins/toastr/toastr.min.js"></script>
    
    <script type="text/javascript">
    
	    var $page = $('.body-paper-setting');
		var $form = $page.find('form');
		var paperId = '${paper.id}';
		
		$page
    	.on('click', '.btn-paper-save', function() {
			var formData = new FormData($form[0]);
			
			formData.append('paperId', paperId);
			$.ajax({
				url: '${ctx}/api/paper/setting',
				type: 'post',
				data: formData,
        		processData: false,
                contentType: false,
                cache: false, 
                success: function(ret) {
                	if (ret.code == 0) {
                		swal({
                            title: '',
                            text: '操作成功',
                            type: 'success'
                        }, function() {
                            window.location.href = '${ctx}/paperList';
                        });
                	}
                },
                error: function(err) {}
			});
    	})
    	.on('click', '.btn-paper-cancel', function() {
    		window.location.href = '${ctx}/paperList';
    	});
    
    </script>

</body>
</html>