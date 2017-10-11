<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/include/preload.jsp"%>

<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	
	<title>角色管理</title>
	
	<link rel="stylesheet" type="text/css" href="${ctx}/plugins/bootstrap/3.3.6/css/bootstrap.min.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/plugins/font-awesome/4.7.0/css/font-awesome.min.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/plugins/animate/animate.min.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/plugins/bootstrap-table/bootstrap-table.min.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/plugins/sweetalert/sweetalert.css">
	
	<link rel="stylesheet" type="text/css" href="${ctx}/plugins/hplus/style.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/local/common.css">
	
</head>

<body class="gray-bg body-role-list">
	<div class="wrapper wrapper-content animated fadeInRight">
		<div class="ibox float-e-margins">
			<div class="ibox-content">
				<h2 class="page-title">角色管理</h2>
			
				<div class="btn-group" id="role-list-table-toolbar" role="group">
                    <button type="button" class="btn btn-primary btn-role-add">
                        <i class="fa fa-plus fa-fw"></i>新增
                    </button>
                    <button type="button" class="btn btn-white btn-role-delete-batch" disabled='disabled'>
                        <i class="fa fa-trash-o fa-fw"></i>批量删除
                    </button>
                </div>
                <table id="role-list-table" class="table-hm" data-mobile-responsive="true"> </table>
			</div>
		</div>
	</div>
	
	<script type="text/javascript" src="${ctx}/plugins/jquery/2.1.4/jquery.min.js"></script>
	<script type="text/javascript" src="${ctx}/plugins/bootstrap/3.3.6/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="${ctx}/plugins/hplus/content.min.js"></script>
	<script type="text/javascript" src="${ctx}/local/common.js"></script>
	
	<script type="text/javascript" src="${ctx}/plugins/sweetalert/sweetalert.min.js"></script>
	<script type="text/javascript" src="${ctx}/plugins/bootstrap-table/bootstrap-table.min.js"></script>
	<script type="text/javascript" src="${ctx}/plugins/bootstrap-table/locale/bootstrap-table-zh-CN.min.js"></script>

	<script type="text/javascript">
	;(function( $ ) {
		
		var $page = $('.body-role-list');
		
		var $table = $k.util.bsTable($page.find('#role-list-table'), {
			url: '${ctx}/api/role/list',
			toolbar: '#role-list-table-toolbar',
			idField: 'id',
			showExport: true, 
			responseHandler: function(res) {
                return res.data;
            },
            columns: [{
            	field: 'state',
            	checkbox: true
            }, {
            	field: 'name',
            	title: '角色名称',
            	align: 'center'
            }, {
            	field: 'description',
            	title: '角色描述',
            	align: 'center'
            }, {
            	title: '操作',
            	align: 'center',
            	formatter: function(value, row, index) {
            		var $edit = '<a class="btn-role-edit a-operate">编辑</a>';
            		var $delete = '<a class="btn-role-delete a-operate">删除</a>';
            		return $edit + $delete;
            	},
            	events: window.operateEvents = {
            		'click .btn-role-edit': function(e, value, row, index) {
            			e.stopPropagation();
            			window.location.href = './roleAdd?method=edit&roleId=' + row.id;
            		},
            		'click .btn-role-delete': function(e, value, row, index) {
            			e.stopPropagation();
            			swal({
            				title: '',
            				text: '确定删除选中记录?',
            				type: 'warning',
            				showCancelButton: true,
                            cancelButtonText: '取消',
                            confirmButtonColor: '#DD6B55',
                            confirmButtonText: '确定',
                            closeOnConfirm: false
            			}, function() {
            				$.ajax({
            					url: '${ctx}/api/role/delete',
            					data: {
            						roleId: row.id
            					},
            					success: function(ret) {
            						if (ret.code == 0) {
            							swal('', '删除成功!', 'success');
            						} else {
            							swal('', ret.msg, 'error');
            						}
            						$table.bootstrapTable('refresh'); 
            					},
            					error: function(err) {}
            				});
            			});
            		},
            	}
            }]
		});
		
		$table.on('all.bs.table', function(e, row) {
            var selNum = $table.bootstrapTable('getSelections').length;
            selNum > 0 ? $page.find('.btn-role-delete-batch').removeAttr('disabled') : $page.find('.btn-role-delete-batch').attr('disabled', 'disabled');
        });
		
		$page
		.on('click', '.btn-role-add', function() {
			window.location.href = './roleAdd?method=add';
		})
		.on('click', '.btn-role-delete-batch', function() {
            swal({
                title: '',
                text: '确定批量删除选中记录',
                type: 'warning',
                showCancelButton: true,
                cancelButtonText: '取消',
                confirmButtonColor: '#DD6B55',
                confirmButtonText: '确定',
                closeOnConfirm: false
            }, function() {
                var rows = $table.bootstrapTable('getSelections');
                
                $.ajax({
                    url: '${ctx}/api/role/batchDelete',
                    data: { 
                        roleIdList: $k.util.getIdList(rows) 
                    },
                    success: function(ret) {
                        if (ret.code == 0) {
                            swal('', '删除成功!', 'success');
						} else {
                            swal('', ret.msg, 'error');
                        }
                        $table.bootstrapTable('refresh'); 
                    },
                    error: function(err) {}
                });
            });
        });
		
	})( jQuery );
	</script>
	
</body>
</html>