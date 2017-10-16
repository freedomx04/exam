<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/include/preload.jsp"%>

<div class="modal" id="modal-paper-student-dialog" tabindex="-1" role="dialog" aria-hidden="true" data-backdrop="true">
	<div class="modal-dialog" style="width: 850px;">
		<div class="modal-content animated fadeInDown">
			<div class="modal-body" style="max-height: 700px; overflow: auto;">
				<div class="tabs-container">
					<ul class="nav nav-tabs nav-tabs-line">
						<li class="active">
							<a data-toggle="tab" href="#paper-student-group" aria-expanded="true">从分组选择考生</a>
						</li>
						<li>
							<a data-toggle="tab" href="#paper-student-manual" aria-expanded="true">手动选择考生</a>
						</li>
						<!-- <li>
							<a data-toggle="tab" href="#paper-student-add" aria-expanded="true">
								<i class="fa fa-plus fa-fw"></i>新增考生
							</a>
						</li>
						<li>
							<a data-toggle="tab" href="#paper-student-import" aria-expanded="true">
								<i class="fa fa-upload fa-fw"></i>导入考生
							</a>
						</li> -->
					</ul>
					<div class="tab-content">
						<div id="paper-student-group" class="tab-pane active">
							<div class="panel-body">
								<ul class="unstyled">
									<c:forEach var="group" items="${groupList}">
										<li data-group-id="${group.id}" style="height: 40px; line-height: 40px;">
											<div class="row">
												<div class="col-sm-6">
													<span>${group.name}&nbsp;<i style="font-style: normal; color: #bbb">(共&nbsp;${group.count}&nbsp;个考生)</i></span>
												</div>
												<div class="col-sm-6">
													<c:if test="${group.count > 0}">
														<button class="btn btn-primary btn-sm btn-fw btn-student-group-add">加入试卷</button>
													</c:if>
													<c:if test="${group.count == 0}">
														<button class="btn btn-primary btn-sm btn-fw" disabled>加入试卷</button>
													</c:if>
												</div>
											</div>
										</li>
									</c:forEach>
								</ul>
							</div>
						</div>
						<div id="paper-student-manual" class="tab-pane">
							<div class="panel-body">
								<div id="student-list-table-toolbar" role="group">
									<select class="form-control" id="student-group">
										<option value="0">所有分组</option>
										<c:forEach var="group" items="${groupList}">
											<option value="${group.id}">${group.name}</option>
										</c:forEach>
									</select>
								</div>
								<table id="student-list-table" class="table-hm" data-mobile-responsive="true"></table>
							</div>
						</div>
						<!-- <div id="paper-student-add" class="tab-pane">
							<div class="panel-body">
								c
							</div>
						</div>
						<div id="paper-student-import" class="tab-pane">
							<div class="panel-body">
								d
							</div>
						</div> -->
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">
	
	var $studentDialog = $('#modal-paper-student-dialog');
	
	var $studentTable;
	var groupId = 0;
	
	initStudentTable(0);
	
	function initStudentTable(groupId) {
		$studentDialog.find('#student-list-table').bootstrapTable('destroy');
		
		$studentTable = $k.util.bsTable($studentDialog.find('#student-list-table'), {
			url: '${ctx}/api/student/list?groupId=' + groupId,
			toolbar: '#student-list-table-toolbar',
			idField: 'id',
			pageSize: 10,
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
				field: 'username',
				title: '考号',
			}, {
				field: 'name',
				title: '姓名',
			}, {
				field: 'group',
				title: '分组',
				formatter: function(value, row, index) {
					return value.name;
				}
			}, {
				title: '操作',
				align: 'center',
				width: '100',
				formatter: function(value, row, index) {
					var $add = '<a class="btn-student-manual-add a-operate">加入试卷</a>';
					return $add;
				},
				events: window.operateEvents = {
					'click .btn-student-manual-add': function(e, value, row, index) {
						e.stopPropagation();
						var $this = $(this);
						$.ajax({
							url: '${ctx}/api/paper/student/manualAdd',
							data: {
								paperId: paper.id,
								studentId: row.id
							},
							success: function(ret) {
								if (ret.code == 0) {
									$this.text('已加入').addClass('disabled');
									$table.bootstrapTable('refresh');
								}
							},
							error: function(err) {}
						});
					}
				}
			}]
		});
	}
	
	$studentDialog
	// 从分组选择考生
	.on('click', '.btn-student-group-add', function() {
		var $this = $(this);
		var groupId = $(this).closest('li').data('groupId');
		$.ajax({
			url: '${ctx}/api/paper/student/groupAdd',
			data: {
				paperId: paper.id,
				groupId: groupId
			},
			success: function(ret) {
				if (ret.code == 0) {
					$this.text('已加入').addClass('disabled');
					$table.bootstrapTable('refresh');
				}
			},
			error: function(err) {}
		});
	})
	// 手动选择考生
	.on('change', '#student-group', function() {
		groupId = $(this).val();
		initStudentTable(groupId);
	});
	
</script>