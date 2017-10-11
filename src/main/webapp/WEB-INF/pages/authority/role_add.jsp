<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/include/preload.jsp"%>

<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	
	<title>${title}</title>
	
	<link rel="stylesheet" type="text/css" href="${ctx}/plugins/bootstrap/3.3.6/css/bootstrap.min.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/plugins/font-awesome/4.7.0/css/font-awesome.min.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/plugins/bootstrap-table/bootstrap-table.min.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/plugins/sweetalert/sweetalert.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/plugins/iCheck/custom.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/plugins/bootstrapValidator/css/bootstrapValidator.min.css">
	
	<link rel="stylesheet" type="text/css" href="${ctx}/plugins/hplus/style.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/local/common.css">
	
	<style type="text/css">
	.body-role-add .authority-classify {
		width: 140px;
	}
	</style>
	
</head>

<body class="gray-bg body-role-add">
	<div class="wrapper wrapper-content animated fadeInRight">
		<div class="ibox float-e-margins">
			<div class="ibox-title">
				<h5>${title}</h5>
			</div>
			
			<div class="ibox-content">
				<form class="form-horizontal" role="form" autocomplete="off" id="form-role">
					<div class="form-group">
						<label for="name" class="col-sm-2 control-label"><i class="form-required">*</i>角色名称</label>
						<div class="col-sm-7">
                            <input type="text" class="form-control" name="name" value="${role.name}" required>
                        </div>
					</div>
					
					<div class="form-group">
                        <label for="description" class="col-sm-2 control-label">角色描述</label>
                        <div class="col-sm-7">
                            <textarea class="form-control" name="description" style="resize:none; height: 150px;">${role.description}</textarea>
                        </div>
                    </div>
                    
					<div class="form-group">
						<label class="col-sm-2 control-label">系统管理</label>
						<div class="col-sm-9">
							<label class="checkbox-inline i-checks authority-classify" data-authority="authority-role">
								<input type="checkbox"> 角色管理
							</label>
							<label class="checkbox-inline i-checks authority-classify-function disabled" data-authority="authority-role-add">
								<input type="checkbox"> 新增
							</label>
							<label class="checkbox-inline i-checks authority-classify-function disabled" data-authority="authority-role-delete-batch">
								<input type="checkbox"> 批量删除
							</label>
							<label class="checkbox-inline i-checks authority-classify-function disabled" data-authority="authority-role-edit">
								<input type="checkbox"> 编辑
							</label>
							<label class="checkbox-inline i-checks authority-classify-function disabled" data-authority="authority-role-delete">
								<input type="checkbox"> 删除
							</label>						
						</div>
					</div>
					
					<div class="form-group">
						<label class="col-sm-2 control-label"></label>
						<div class="col-sm-9">
							<label class="checkbox-inline i-checks authority-classify" data-authority="authority-user">
								<input type="checkbox"> 用户管理
							</label>
							<label class="checkbox-inline i-checks authority-classify-function disabled" data-authority="authority-user-add">
								<input type="checkbox"> 新增
							</label>
							<label class="checkbox-inline i-checks authority-classify-function disabled" data-authority="authority-user-edit">
								<input type="checkbox"> 编辑
							</label>
							<label class="checkbox-inline i-checks authority-classify-function disabled" data-authority="authority-user-password">
								<input type="checkbox"> 修改密码
							</label>
							<label class="checkbox-inline i-checks authority-classify-function disabled" data-authority="authority-user-status">
								<input type="checkbox"> 禁用/启用
							</label>
						</div>
					</div>
					
					<div class="form-group">
						<label class="col-sm-2 control-label"></label>
						<div class="col-sm-9">
							<label class="checkbox-inline i-checks authority-classify" data-authority="authority-enterprise">
								<input type="checkbox"> 企业管理
							</label>
							<label class="checkbox-inline i-checks authority-classify-function disabled" data-authority="authority-enterprise-add">
								<input type="checkbox"> 新增
							</label>
							<label class="checkbox-inline i-checks authority-classify-function disabled" data-authority="authority-enterprise-edit">
								<input type="checkbox"> 编辑
							</label>
						</div>
					</div>
					
					<div class="form-group">
						<label class="col-sm-2 control-label"></label>
						<div class="col-sm-9">
							<label class="checkbox-inline i-checks authority-classify" data-authority="authority-department">
								<input type="checkbox"> 部门管理
							</label>
							<label class="checkbox-inline i-checks authority-classify-function disabled" data-authority="authority-department-add">
								<input type="checkbox"> 新增
							</label>
							<label class="checkbox-inline i-checks authority-classify-function disabled" data-authority="authority-department-delete-batch">
								<input type="checkbox"> 批量删除
							</label>
							<label class="checkbox-inline i-checks authority-classify-function disabled" data-authority="authority-department-edit">
								<input type="checkbox"> 编辑
							</label>
							<label class="checkbox-inline i-checks authority-classify-function disabled" data-authority="authority-department-delete">
								<input type="checkbox"> 删除
							</label>
						</div>
					</div>
					
					<div class="form-group">
						<label class="col-sm-2 control-label"></label>
						<div class="col-sm-9">
							<label class="checkbox-inline i-checks authority-classify" data-authority="authority-version">
								<input type="checkbox"> 版本管理
							</label>
							<label class="checkbox-inline i-checks authority-classify-function disabled" data-authority="authority-version-add">
								<input type="checkbox"> 新增
							</label>
							<label class="checkbox-inline i-checks authority-classify-function disabled" data-authority="authority-version-delete-batch">
								<input type="checkbox"> 批量删除
							</label>
							<label class="checkbox-inline i-checks authority-classify-function disabled" data-authority="authority-version-edit">
								<input type="checkbox"> 编辑
							</label>
							<label class="checkbox-inline i-checks authority-classify-function disabled" data-authority="authority-version-delete">
								<input type="checkbox"> 删除
							</label>
						</div>
					</div>
					
					<div class="form-group">
						<label class="col-sm-2 control-label">基础数据</label>
						<div class="col-sm-9">
							<label class="checkbox-inline i-checks authority-classify" data-authority="authority-area">
								<input type="checkbox"> 园区管理
							</label>
							<label class="checkbox-inline i-checks authority-classify-function disabled" data-authority="authority-area-add">
								<input type="checkbox"> 新增
							</label>
							<label class="checkbox-inline i-checks authority-classify-function disabled" data-authority="authority-area-delete-batch">
								<input type="checkbox"> 批量删除
							</label>
							<label class="checkbox-inline i-checks authority-classify-function disabled" data-authority="authority-area-edit">
								<input type="checkbox"> 编辑
							</label>
							<label class="checkbox-inline i-checks authority-classify-function disabled" data-authority="authority-area-delete">
								<input type="checkbox"> 删除
							</label>
						</div>
					</div>
					
					<div class="form-group">
						<label class="col-sm-2 control-label"></label>
						<div class="col-sm-9">
							<label class="checkbox-inline i-checks authority-classify" data-authority="authority-industry">
								<input type="checkbox"> 行业管理
							</label>
							<label class="checkbox-inline i-checks authority-classify-function disabled" data-authority="authority-industry-add">
								<input type="checkbox"> 新增
							</label>
							<label class="checkbox-inline i-checks authority-classify-function disabled" data-authority="authority-industry-delete-batch">
								<input type="checkbox"> 批量删除
							</label>
							<label class="checkbox-inline i-checks authority-classify-function disabled" data-authority="authority-industry-edit">
								<input type="checkbox"> 编辑
							</label>
							<label class="checkbox-inline i-checks authority-classify-function disabled" data-authority="authority-industry-delete">
								<input type="checkbox"> 删除
							</label>
						</div>
					</div>
					
					<div class="form-group">
						<label class="col-sm-2 control-label"></label>
						<div class="col-sm-9">
							<label class="checkbox-inline i-checks authority-classify" data-authority="authority-appealType">
								<input type="checkbox"> 诉求类别管理
							</label>
							<label class="checkbox-inline i-checks authority-classify-function disabled" data-authority="authority-appealType-add">
								<input type="checkbox"> 新增
							</label>
							<label class="checkbox-inline i-checks authority-classify-function disabled" data-authority="authority-appealType-delete-batch">
								<input type="checkbox"> 批量删除
							</label>
							<label class="checkbox-inline i-checks authority-classify-function disabled" data-authority="authority-appealType-edit">
								<input type="checkbox"> 编辑
							</label>
							<label class="checkbox-inline i-checks authority-classify-function disabled" data-authority="authority-appealType-delete">
								<input type="checkbox"> 删除
							</label>
						</div>
					</div>
					
					<div class="form-group">
						<label class="col-sm-2 control-label">新闻发布</label>
						<div class="col-sm-9">
							<label class="checkbox-inline i-checks authority-classify" data-authority="authority-photonews">
								<input type="checkbox"> 图片新闻
							</label>
							<label class="checkbox-inline i-checks authority-classify-function disabled" data-authority="authority-photonews-add">
								<input type="checkbox"> 新增
							</label>
							<label class="checkbox-inline i-checks authority-classify-function disabled" data-authority="authority-photonews-delete-batch">
								<input type="checkbox"> 批量删除
							</label>
							<label class="checkbox-inline i-checks authority-classify-function disabled" data-authority="authority-photonews-edit">
								<input type="checkbox"> 编辑
							</label>
							<label class="checkbox-inline i-checks authority-classify-function disabled" data-authority="authority-photonews-delete">
								<input type="checkbox"> 删除
							</label>
						</div>
					</div>
					
					<div class="form-group">
						<label class="col-sm-2 control-label"></label>
						<div class="col-sm-9">
							<label class="checkbox-inline i-checks authority-classify" data-authority="authority-announce">
								<input type="checkbox"> 公示公告
							</label>
							<label class="checkbox-inline i-checks authority-classify-function" data-authority="authority-announce-add">
								<input type="checkbox"> 新增
							</label>
							<label class="checkbox-inline i-checks authority-classify-function" data-authority="authority-announce-delete-batch">
								<input type="checkbox"> 批量删除
							</label>
							<label class="checkbox-inline i-checks authority-classify-function" data-authority="authority-announce-edit">
								<input type="checkbox"> 编辑
							</label>
							<label class="checkbox-inline i-checks authority-classify-function" data-authority="authority-announce-delete">
								<input type="checkbox"> 删除
							</label>
						</div>
					</div>
					
					<div class="form-group">
						<label class="col-sm-2 control-label"></label>
						<div class="col-sm-9">
							<label class="checkbox-inline i-checks authority-classify" data-authority="authority-policy">
								<input type="checkbox"> 政策法规
							</label>
							<label class="checkbox-inline i-checks authority-classify-function" data-authority="authority-policy-add">
								<input type="checkbox"> 新增
							</label>
							<label class="checkbox-inline i-checks authority-classify-function" data-authority="authority-policy-delete-batch">
								<input type="checkbox"> 批量删除
							</label>
							<label class="checkbox-inline i-checks authority-classify-function" data-authority="authority-policy-edit">
								<input type="checkbox"> 编辑
							</label>
							<label class="checkbox-inline i-checks authority-classify-function" data-authority="authority-policy-delete">
								<input type="checkbox"> 删除
							</label>
						</div>
					</div>
					
					<div class="form-group">
						<label class="col-sm-2 control-label"></label>
						<div class="col-sm-9">
							<label class="checkbox-inline i-checks authority-classify" data-authority="authority-overview">
								<input type="checkbox"> 工业信息
							</label>
							<label class="checkbox-inline i-checks authority-classify-function" data-authority="authority-overview-add">
								<input type="checkbox"> 新增
							</label>
							<label class="checkbox-inline i-checks authority-classify-function" data-authority="authority-overview-delete-batch">
								<input type="checkbox"> 批量删除
							</label>
							<label class="checkbox-inline i-checks authority-classify-function" data-authority="authority-overview-edit">
								<input type="checkbox"> 编辑
							</label>
							<label class="checkbox-inline i-checks authority-classify-function" data-authority="authority-overview-delete">
								<input type="checkbox"> 删除
							</label>
						</div>
					</div>
					
					<div class="form-group">
						<label class="col-sm-2 control-label">监测平台</label>
						<div class="col-sm-9">
							<label class="checkbox-inline i-checks authority-classify" data-authority="authority-target-report">
								<input type="checkbox"> 主要指标上报
							</label>
							<label class="checkbox-inline i-checks authority-classify-function" data-authority="authority-target-report-add">
								<input type="checkbox"> 新增
							</label>
							<label class="checkbox-inline i-checks authority-classify-function" data-authority="authority-target-report-export">
								<input type="checkbox"> 导出到excel
							</label>
							<label class="checkbox-inline i-checks authority-classify-function" data-authority="authority-target-report-import">
								<input type="checkbox"> 导入excel
							</label>
							<label class="checkbox-inline i-checks authority-classify-function" data-authority="authority-target-report-template">
								<input type="checkbox"> 下载模板
							</label>
							<label class="checkbox-inline i-checks authority-classify-function" data-authority="authority-target-report-edit">
								<input type="checkbox"> 编辑
							</label>
							<label class="checkbox-inline i-checks authority-classify-function" data-authority="authority-target-report-delete">
								<input type="checkbox"> 删除
							</label>
						</div>
					</div>
					
					<div class="form-group">
						<label class="col-sm-2 control-label"></label>
						<div class="col-sm-9">
							<label class="checkbox-inline i-checks authority-classify" data-authority="authority-target-enterprise">
								<input type="checkbox"> 企业主要指标
							</label>
						</div>
					</div>
					
					<div class="form-group">
						<label class="col-sm-2 control-label"></label>
						<div class="col-sm-9">
							<label class="checkbox-inline i-checks authority-classify" data-authority="authority-target-industry">
								<input type="checkbox"> 行业主要指标
							</label>
						</div>
					</div>
					
					<div class="form-group">
						<label class="col-sm-2 control-label"></label>
						<div class="col-sm-9">
							<label class="checkbox-inline i-checks authority-classify" data-authority="authority-target-area">
								<input type="checkbox"> 园区主要指标
							</label>
						</div>
					</div>
					
					<div class="form-group">
						<label class="col-sm-2 control-label"></label>
						<div class="col-sm-9">
							<label class="checkbox-inline i-checks authority-classify" data-authority="authority-target-point-enterprise">
								<input type="checkbox"> 重点企业主要指标
							</label>
						</div>
					</div>
					
					<div class="form-group">
						<label class="col-sm-2 control-label"></label>
						<div class="col-sm-9">
							<label class="checkbox-inline i-checks authority-classify" data-authority="authority-target-ep">
								<input type="checkbox"> 主要指标(企业)
							</label>
						</div>
					</div>
					
					<div class="form-group">
						<label class="col-sm-2 control-label">帮扶平台</label>
						<div class="col-sm-9">
							<label class="checkbox-inline i-checks" data-authority="authority-appeal-center">
								<input type="checkbox"> 诉求中心
							</label>
						</div>
					</div>
					
					<div class="form-group">
						<label class="col-sm-2 control-label"></label>
						<div class="col-sm-9">
							<label class="checkbox-inline i-checks" data-authority="authority-appeal-enterprise">
								<input type="checkbox"> 诉求中心(企业)
							</label>
						</div>
					</div>
					
					<div class="form-group">
						<label class="col-sm-2 control-label"></label>
						<div class="col-sm-9">
							<label class="checkbox-inline i-checks" data-authority="authority-appeal-department">
								<input type="checkbox"> 诉求中心(部门)
							</label>
						</div>
					</div>
					
					<div class="form-group">
						<label class="col-sm-2 control-label"></label>
						<div class="col-sm-9">
							<label class="checkbox-inline i-checks" data-authority="authority-appeal-dispatcher">
								<input type="checkbox"> 诉求中心(派单)
							</label>
						</div>
					</div>
					
					<div class="form-group">
						<label class="col-sm-2 control-label">服务平台</label>
						<div class="col-sm-9">
							<label class="checkbox-inline i-checks" data-authority="authority-declare">
								<input type="checkbox"> 网上申报
							</label>
						</div>
					</div>
					
					<div class="form-group">
						<label class="col-sm-2 control-label"></label>
						<div class="col-sm-9">
							<label class="checkbox-inline i-checks" data-authority="authority-apply">
								<input type="checkbox"> 网上申报(企业)
							</label>
						</div>
					</div>
					
					<div class="hr-line-dashed"></div>
                    
                    <div class="form-group">
                        <div class="col-sm-4 col-sm-offset-2">
                            <c:if test="${method == 'add'}">
                            <button type="button" class="btn btn-primary btn-role-add">
                                <i class="fa fa-check fa-fw"></i>确定
                            </button>
                            </c:if>
                            <c:if test="${method == 'edit'}">
                            <button type="button" class="btn btn-primary btn-role-edit">
                                <i class="fa fa-check fa-fw"></i>确定
                            </button>
                            </c:if>
                            <button type="button" class="btn btn-white btn-role-cancel">
                                <i class="fa fa-close fa-fw"></i>取消
                            </button>
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
    <script type="text/javascript" src="${ctx}/plugins/bootstrapValidator/js/bootstrapValidator.min.js"></script>
    <script type="text/javascript" src="${ctx}/plugins/bootstrapValidator/js/language/zh_CN.js"></script>
    <script type="text/javascript" src="${ctx}/plugins/iCheck/icheck.min.js"></script>

	<script type="text/javascript">
	;(function( $ ) {
		
		var $page = $('.body-role-add');
		var $form = $page.find('#form-role');
		var method = '${method}';
		
		$k.util.bsValidator($form);
		
		$page.find(".i-checks").iCheck({
        	checkboxClass: "icheckbox_square-green", 
        	radioClass: "iradio_square-green"
        });
		
		if (method == 'detail') {
			var resource = '${role.resource}';
			var arr = resource.split(',');
			$.each(arr, function(k, val) {
				if (val != '') {
					var $label = $page.find('.i-checks[data-authority=' + val + ']');
					$label.iCheck('check');
				}
			});
			
			$page.find('.form-required').remove();
			$page.find('input').addClass('disabled');
			$page.find('textarea').addClass('disabled');
			$page.find('.i-checks').addClass('disabled');
		} else if (method == 'edit') {
			var resource = '${role.resource}';
			var arr = resource.split(',');
			$.each(arr, function(k, val) {
				if (val != '') {
					var $label = $page.find('.i-checks[data-authority=' + val + ']');
					$label.iCheck('check');
					if ($label.hasClass('authority-classify')) {
						$label.closest('div').find('.authority-classify-function').removeClass('disabled');
					}
				}
			});
		}
		
		$page.find('.authority-classify')
		.on('ifChecked', function(e) {
			var $this = $(this);
			$this.closest('div').find('.authority-classify-function').removeClass('disabled').iCheck('check');
		})
		.on('ifUnchecked', function(e) {
			var $this = $(this);
			$this.closest('div').find('.authority-classify-function').addClass('disabled').iCheck('uncheck');
		});
		
		$page
		.on('click', '.btn-role-add', function() {
			var validator = $form.data('bootstrapValidator');
			validator.validate();
			
			if (validator.isValid()) {
				var arr = [];
				$page.find('.i-checks input').each(function() {
					if (true == $(this).is(':checked')) {
						var authority = $(this).closest('label').data('authority');
						arr.push(authority);
					}
				});
				
				$.ajax({
					url: '${ctx}/api/role/create',
					type: 'post',
					data: {
						name: $form.find('input[name="name"]').val(),
						description: $form.find('textarea[name="description"]').val(),
						resource: arr.join(',')
					},
                    success: function(ret) {
                        if (ret.code == 0) {
                            swal({
                                title: '',
                                text: '操作成功',
                                type: 'success'
                            }, function() {
                                window.location.href = './roleList';
                            });
                        } else {
                            swal('', ret.msg, 'error');
                        }
                    },
                    error: function(err) {}
				});
			}
		})
		.on('click', '.btn-role-edit', function() {
			var validator = $form.data('bootstrapValidator');
			validator.validate();
			
			if (validator.isValid()) {
				var arr = [];
				$page.find('.i-checks input').each(function() {
					if (true == $(this).is(':checked')) {
						var authority = $(this).closest('label').data('authority');
						arr.push(authority);
					}
				});
				
				$.ajax({
					url: '${ctx}/api/role/update',
					type: 'post',
					data: {
						roleId: '${role.id}',
						name: $form.find('input[name="name"]').val(),
						description: $form.find('textarea[name="description"]').val(),
						resource: arr.join(',')
					},
					success: function(ret) {
                        if (ret.code == 0) {
                            swal({
                                title: '',
                                text: '操作成功',
                                type: 'success'
                            }, function() {
                                window.location.href = './roleList';
                            });
                        } else {
                            swal('', ret.msg, 'error');
                        }
                    },
                    error: function(err) {}
				});
			}
		})
		.on('click', '.btn-role-cancel', function() {
			window.location.href = './roleList';
		});
		
	})( jQuery );
	</script>
	
</body>

</html>