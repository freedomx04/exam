<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/include/preload.jsp"%>

<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <title>试卷编辑</title>
    
    <link rel="stylesheet" type="text/css" href="${ctx}/plugins/bootstrap/3.3.6/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/plugins/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/plugins/animate/animate.min.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/plugins/sweetalert/sweetalert.css">
    
    <link rel="stylesheet" type="text/css" href="${ctx}/plugins/hplus/style.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/local/common.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/plugins/toastr/toastr.min.css">
    
</head>

<body class="gray-bg body-paper-edit">
	<div class="wrapper wrapper-content animated fadeInRight">
		<div class="ibox">
			<div class="ibox-content">
				<div class="page-title">
					<h2>试卷编辑<small>${paper.title}</small></h2>
				</div>
				
				<form class="form-horizontal" role="form" autocomplete="off">
					<div class="form-group">
						<div class="col-sm-5 col-sm-offset-3">
							<h3 class="help-block">请填写试卷基本信息</h3>
						</div>
					</div>
					
					<div class="form-group">
						<label for="title" class="col-sm-3 control-label"><i class="form-required">*</i>试卷标题</label>
						<div class="col-sm-5">
							<input type="text" class="form-control" name="title" value="${paper.title}">
						</div>
					</div>
					
					<div class="form-group">
						<label for="classifyId" class="col-sm-3 control-label"><i class="form-required">*</i>试卷分类</label>
						<div class="col-sm-5">
							<select class="form-control" name="classifyId">
								<c:forEach var="classify" items="${classifyList}">
									<option value="${classify.id}">${classify.name}</option>
								</c:forEach>
							</select>
						</div>
					</div>
					
					<div class="form-group">
						<label for="description" class="col-sm-3 control-label">试卷描述</label>
						<div class="col-sm-5">
							<textarea class="form-control" name="description" style="resize:none; height: 150px;">${paper.description}</textarea>
						</div>
					</div>
					
					<div class="hr-line-solid"></div>
					<div class="form-group btn-operate">
						<div class="col-sm-5 col-sm-offset-3">
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
    	
    	var $page = $('.body-paper-edit');
    	var $form = $page.find('form');
    	var paperId = '${paper.id}';
    	$page.find('select[name="classifyId"]').val(${paper.classify.id});
    	
    	$page
    	.on('click', '.btn-paper-save', function() {
    		var title = $form.find('input[name="title"]').val();
			if (title == '') {
				toastr['error']('请填写试卷标题！');
				return;
			}
    		
    		var formData = new FormData($form[0]);
    		formData.append('paperId', paperId);
    		$.ajax({
    			url: '${ctx}/api/paper/update',
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