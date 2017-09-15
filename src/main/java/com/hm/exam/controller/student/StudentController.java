package com.hm.exam.controller.student;

import java.util.Date;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
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
public class StudentController {

	static Logger log = LoggerFactory.getLogger(StudentController.class);

	@Autowired
	GroupService groupService;

	@Autowired
	StudentService studentService;

	@RequestMapping(value = "/api/student/create", method = RequestMethod.POST)
	public Result create(Long groupId, String username, String name, String password) {
		try {
			Date now = new Date();
			GroupEntity group = groupService.findOne(groupId);
			StudentEntity student = new StudentEntity(group, username, name, password, now, now);
			studentService.save(student);
			return new Result(Code.SUCCESS.value(), "created");
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Result(Code.ERROR.value(), e.getMessage());
		}
	}
	
	@RequestMapping(value = "/api/student/update", method = RequestMethod.POST)
	public Result update(Long studentId, Long groupId, String username, String name) {
		try {
			return new Result(Code.SUCCESS.value(), "updated");
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Result(Code.ERROR.value(), e.getMessage());
		}
	}
	
	@RequestMapping(value = "/api/student/delete")
	public Result delete(Long studentId) {
		try {
			studentService.delete(studentId);
			return new Result(Code.SUCCESS.value(), "deleted");
		} catch (Exception e) {
			if (e.getCause().toString().indexOf("ConstraintViolationException") != -1) {
				return new Result(Code.CONSTRAINT.value(), "该数据存在关联，无法删除！");
			}
			log.error(e.getMessage(), e);
			return new Result(Code.ERROR.value(), e.getMessage());
		}
	}

	@RequestMapping(value = "/api/student/batchDelete")
	public Result batchDelete(@RequestParam("studentIdList[]") List<Long> studentIdList) {
		try {
			studentService.delete(studentIdList);
			return new Result(Code.SUCCESS.value(), "deleted");
		} catch (Exception e) {
			if (e.getCause().toString().indexOf("ConstraintViolationException") != -1) {
				return new Result(Code.CONSTRAINT.value(), "该数据存在关联，无法删除！");
			}
			log.error(e.getMessage(), e);
			return new Result(Code.ERROR.value(), e.getMessage());
		}
	}
	
	@RequestMapping(value = "/api/student/get")
	public Result get(Long studentId) {
		try {
			StudentEntity student = studentService.findOne(studentId);
			return new ResultInfo(Code.SUCCESS.value(), "ok", student);
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Result(Code.ERROR.value(), e.getMessage());
		}
	}
	
	@RequestMapping(value = "/api/student/list")
	public Result list() {
		try {
			List<StudentEntity> list = studentService.list();
			return new ResultInfo(Code.SUCCESS.value(), "ok", list);
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Result(Code.ERROR.value(), e.getMessage());
		}
	}

	@RequestMapping(value = "/api/student/listPaging")
	public Result listPaging(int page, int size) {
		try {
			Page<StudentEntity> studentPage = studentService.list(page, size);
			return new ResultInfo(Code.SUCCESS.value(), "ok", studentPage);
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Result(Code.ERROR.value(), e.getMessage());
		}
	}
	
	@RequestMapping(value = "/api/student/listByGroup")
	public Result listByGroup(Long groupId) {
		try {
			GroupEntity group = groupService.findOne(groupId);
			List<StudentEntity> list = studentService.listByGroup(group);
			return new ResultInfo(Code.SUCCESS.value(), "ok", list);
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Result(Code.ERROR.value(), e.getMessage());
		}
	}

}
