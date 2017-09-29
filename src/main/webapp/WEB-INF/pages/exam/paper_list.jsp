<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/include/preload.jsp"%>

<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	
	<title>试卷管理</title>
	
	<link rel="stylesheet" type="text/css" href="${ctx}/plugins/bootstrap/3.3.6/css/bootstrap.min.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/plugins/font-awesome/4.7.0/css/font-awesome.min.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/plugins/awesome-bootstrap-checkbox/awesome-bootstrap-checkbox.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/plugins/animate/animate.min.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/plugins/bootstrap-table/bootstrap-table.min.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/plugins/sweetalert/sweetalert.css">
	
	<link rel="stylesheet" type="text/css" href="${ctx}/plugins/hplus/style.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/local/common.css">
	
</head>

<body class="gray-bg body-paper-list">
	<div class="wrapper wrapper-content animated fadeInRight">
		<div class="ibox float-e-margins">
			<div class="ibox-content">
				<h2 class="page-title">试卷管理</h2>
				
				<div id="paper-list-table-toolbar" role="group">
 					<button type="button" class="btn btn-primary btn-paper-add">
 						<i class="fa fa-plus fa-fw"></i>新增试卷
 					</button>
 					<button type="button" class="btn btn-white btn-paper-move" disabled="disabled">
	 					移动到分类
	 				</button>
 				</div>
 				<table id="paper-list-table" class="table-hm" data-mobile-responsive="true"></table>
			</div>
		</div>
	</div>
	
	<div class="modal" id="modal-paper-move-dialog" tabindex="-1" role="dialog" aria-hidden="true" data-backdrop="static">
		<div class="modal-dialog">
			<div class="modal-content animated fadeInDown">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
					<h3 class="modal-title">请选择题库</h3>
				</div>
				<div class="modal-body" style="max-height: 400px; overflow: auto;">
					 <div class="alert alert-success alert-question-move hide">请先选择一项</div>
					 <ul class="unstyled">
					 	<c:forEach var="classify" items="${classifyList}">
					 		<li style="height: 30px;">
					 			<div class="radio radio-success radio-inline">
					 				<input type="radio" name="classify" id="${classify.id}" value="${classify.id}">
					 				<label for="${classify.id}">${classify.name}</label>
					 			</div>
					 		</li>
					 	</c:forEach>
					 </ul>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-white" data-dismiss="modal" style="width: 100px;">关闭</button>
                    <button type="button" class="btn btn-primary btn-paper-move-confirm" style="width: 100px;">确定</button>
				</div>
			</div>
		</div>
	</div>
	
	<div class="modal" id="modal-paper-detail-dialog" tabindex="-1" role="dialog" aria-hidden="true" data-backdrop="static">
		<div class="modal-dialog">
			<div class="modal-content animated fadeInDown">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
					<h3 class="modal-title">试卷详情</h3>
				</div>
				<div class="modal-body">
					<h2>复制下面的连接并分享给您的考生</h2>
					<div>
						<pre class="url-share"></pre>
						<button type="button" class="btn btn-primary btn-copy" data-clipboard-text="aa">
							<i class="fa fa-copy fa-fw"></i>点击复制
						</button>
					</div>
				</div>
				<div class="modal-footer">
                    <button type="button" class="btn btn-primary" data-dismiss="modal">
                        <i class="fa fa-close fa-fw"></i>关闭
                    </button>
                </div>
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
	<script type="text/javascript" src="${ctx}/plugins/clipboard/clipboard.min.js"></script>
	
	<script type="text/javascript">
		
		var $page = $('.body-paper-list');
		var $moveDialog = $page.find('#modal-paper-move-dialog');
		var $detailDialog = $page.find('#modal-paper-detail-dialog');
		
		var clipboard = new Clipboard('.btn-copy');
		
		var $table = $k.util.bsTable($page.find('#paper-list-table'), {
			url: '${ctx}/api/paper/list',
			toolbar: '#paper-list-table-toolbar',
			idField: 'id',
			responseHandler: function(res) {
				return res.data;
			},
			columns: [{
				field: 'state',
				checkbox: true
			}, {
				title: '#',
				width: '20',
				formatter: function(value, row, index) {
					return index + 1;
				}
			}, {
				field: 'title',
				title: '试卷标题',
				formatter: function(value, row, index) {
					return '<a class="paper-detail">' + value + '</a>';
				},
				events: window.operateEvents = {
					'click .paper-detail': function(e, value, row, index) {
						e.stopPropagation();
						var shareUrl = 'http://' + window.location.host + '${ctx}/online/' + row.id;
						$detailDialog.find('.url-share').text(shareUrl);
						$detailDialog.find('.btn-copy').attr('data-clipboard-text', shareUrl);
						$detailDialog.modal('show');
					}
				}
			}, {
				field: 'classify',
				title: '试卷分类',
				align: 'center',
				formatter: function(value, row, index) {
					return value.name;
				}
			}, {
				field: 'updateTime',
				title: '时间',
				align: 'center',
				width: 150,
				formatter: formatDate2
			}, {
				title: '操作',
				align: 'center',
				width: '200',
				formatter: function(value, row, index) {
					var $edit = '<a class="btn-paper-edit a-operate">编辑</a>';
					var $question = '<a class="btn-paper-question a-operate">试题管理</a>';
					var $setting = '<a class="btn-paper-setting a-operate">设置</a>';
					var $delete = '<a class="btn-paper-delete a-operate">删除</a>';
					return $edit + $question + $setting + $delete;
				},
				events: window.operateEvents = {
					'click .btn-paper-edit': function(e, value, row, index) {
						e.stopPropagation();
						window.location.href = '${ctx}/paperEdit?paperId=' + row.id;
					},
					'click .btn-paper-question': function(e, value, row, index) {
						e.stopPropagation();
						window.location.href = '${ctx}/paperQuestion?paperId=' + row.id;
					},
					'click .btn-paper-setting': function(e, value, row, index) {
						e.stopPropagation();
						window.location.href = '${ctx}/paperSetting?paperId=' + row.id;
					},
					'click .btn-paper-delete': function(e, value, row, index) {
						e.stopPropagation();
						var text = '您确定要删除所选择的试卷吗?';
						swal({
            				title: '',
            				text: text,
            				type: 'warning',
            				showCancelButton: true,
                            cancelButtonText: '取消',
                            confirmButtonColor: '#DD6B55',
                            confirmButtonText: '确定',
                            closeOnConfirm: false
            			}, function() {
            				$.ajax({
            					url: '${ctx}/api/paper/delete',
            					data: {
            						paperId: row.id
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
					}
				}
			}]
		});
		
		$table.on('all.bs.table', function(e, row) {
            var selNum = $table.bootstrapTable('getSelections').length;
            selNum > 0 ? $page.find('.btn-paper-move').removeAttr('disabled') : $page.find('.btn-paper-move').attr('disabled', 'disabled');
        });
	
		$page
		.on('click', '.btn-paper-add', function() {
			window.location.href = '${ctx}/paperAdd';
		})
		.on('click', '.btn-paper-move', function() {
			$moveDialog.find('.alert-paper-move').addClass('hide');
			$moveDialog.find('input[name="classify"]').removeAttr('checked');
			$moveDialog.modal('show');
		})
		.on('click', '.btn-paper-move-confirm', function() {
			var classifyId = $moveDialog.find('input[name="classify"]:checked').val();
			if (!classifyId) {
                $moveDialog.find('.alert-paper-move').removeClass('hide');
                return;
        	}
			
			var rows = $table.bootstrapTable('getSelections');
			$.ajax({
				url: '${ctx}/api/paper/move',
				type: 'post',
				data: {
					paperIdList: $k.util.getIdList(rows),
					classifyId: classifyId
				},
				success: function(ret) {
					$moveDialog.modal('hide');
					if (ret.code == 0) {
						swal('', '移动成功!', 'success');
					} else {
						swal('', ret.msg, 'error');
					}
					$table.bootstrapTable('refresh');
				},
				error: function(err) {}
			});
		});
		
	</script>
	
</body>
</html>