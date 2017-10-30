package com.hm.exam.controller.student;

import java.util.Date;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.hm.exam.common.result.Code;
import com.hm.exam.common.result.Result;
import com.hm.exam.common.result.ResultInfo;
import com.hm.exam.entity.student.GroupEntity;
import com.hm.exam.entity.student.StudentEntity;
import com.hm.exam.service.student.GroupService;
import com.hm.exam.service.student.StudentService;

@RestController
public class GroupController {
	
	static Logger log = LoggerFactory.getLogger(GroupController.class);
	
	@Autowired
	GroupService groupService;
	
	@Autowired
	StudentService studentService;
	
	@RequestMapping(value = "/api/group/create", method = RequestMethod.POST)
	public Result create(String name) {
		try {
			GroupEntity group = groupService.findByName(name);
			if (group != null) {
				return new Result(Code.EXISTED.value(), "分组已存在");
			}
			
			Date now = new Date();
			group = new GroupEntity(name, now, now);
			groupService.save(group);
			return new Result(Code.SUCCESS.value(), "created");
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Result(Code.ERROR.value(), e.getMessage());
		}
	}
	
	@RequestMapping(value = "/api/group/update", method = RequestMethod.POST)
	public Result update(Long groupId, String name) {
		try {
			GroupEntity group = groupService.findOne(groupId);
			
			GroupEntity updateGroup = groupService.findByName(name);
			if (updateGroup == null || group.getId() == updateGroup.getId()) {
				group.setName(name);
				group.setUpdateTime(new Date());
				groupService.save(group);
				return new Result(Code.SUCCESS.value(), "updated");
			} else {
				return new Result(Code.EXISTED.value(), "分组已存在");
			}
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Result(Code.ERROR.value(), e.getMessage());
		}
	}
	
	@RequestMapping(value = "/api/group/delete")
	public Result delete(Long groupId) {
		try {
			GroupEntity group = groupService.findOne(groupId);
			List<StudentEntity> studentList = studentService.listByGroup(group);
			for (StudentEntity student: studentList) {
				GroupEntity defaultGroup = groupService.findByName("默认分组");
				student.setGroup(defaultGroup);
				studentService.save(student);
			}
			groupService.delete(groupId);
			return new Result(Code.SUCCESS.value(), "deleted");
		} catch (Exception e) {
			if (e.getCause().toString().indexOf("ConstraintViolationException") != -1) {
				return new Result(Code.CONSTRAINT.value(), "该数据存在关联，无法删除！");
			}
			log.error(e.getMessage(), e);
			return new Result(Code.ERROR.value(), e.getMessage());
		}
	}
	
	@RequestMapping(value = "/api/group/batchDelete", method = RequestMethod.POST)
	public Result batchDelete(@RequestParam("groupIdList[]") List<Long> groupIdList) {
		try {
			for (Long groupId: groupIdList) {
				delete(groupId);
			}
			return new Result(Code.SUCCESS.value(), "deleted");
		} catch (Exception e) {
			if (e.getCause().toString().indexOf("ConstraintViolationException") != -1) {
				return new Result(Code.CONSTRAINT.value(), "该数据存在关联，无法删除！");
			}
			log.error(e.getMessage(), e);
			return new Result(Code.ERROR.value(), e.getMessage());
		}
	}
	
	@RequestMapping(value = "/api/group/get")
	public Result get(Long groupId) {
		try {
			GroupEntity group = groupService.findOne(groupId);
			return new ResultInfo(Code.SUCCESS.value(), "ok", group);
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Result(Code.ERROR.value(), e.getMessage());
		}
	}
	
	@RequestMapping(value = "/api/group/list")
	public Result list() {
		try {
			List<GroupEntity> list = groupService.list();
			for (GroupEntity group: list) {
				Integer count = studentService.countByGroup(group);
				group.setCount(count);
			}
			return new ResultInfo(Code.SUCCESS.value(), "ok", list);
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Result(Code.ERROR.value(), e.getMessage());
		}
	}
	
}
