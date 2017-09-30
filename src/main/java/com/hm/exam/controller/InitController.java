package com.hm.exam.controller;

import java.util.Date;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.hm.exam.common.result.Code;
import com.hm.exam.common.result.Result;
import com.hm.exam.common.utils.CiphersUtils;
import com.hm.exam.entity.BaseEntity.Editable;
import com.hm.exam.entity.authority.UserEntity;
import com.hm.exam.entity.exam.ClassifyEntity;
import com.hm.exam.entity.question.LibraryEntity;
import com.hm.exam.entity.student.GroupEntity;
import com.hm.exam.service.authority.UserService;
import com.hm.exam.service.exam.ClassifyService;
import com.hm.exam.service.question.LibraryService;
import com.hm.exam.service.student.GroupService;

@RestController
public class InitController {
	
	static Logger log = LoggerFactory.getLogger(InitController.class);
	
	@Autowired
	UserService userService;
	
	@Autowired
	LibraryService libraryService;
	
	@Autowired
	GroupService groupService;
	
	@Autowired
	ClassifyService classifyService;
	
	@RequestMapping(value = "/api/init/admin")
	public Result admin() {
		try {
			UserEntity user = userService.findByUsername("admin");
			if (user == null) {
				Date now = new Date();
				user = new UserEntity("admin", CiphersUtils.getInstance().MD5Password("admin123456"), "管理员", now, now);
				userService.save(user);
			}
			return new Result(Code.SUCCESS.value(), "成功");
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Result(Code.ERROR.value(), e.getMessage());
		}
	}
	
	@RequestMapping(value = "/api/init/library")
	public Result library() {
		try {
			LibraryEntity library = libraryService.findByName("默认题库");
			if (library == null) {
				Date now = new Date();
				library = new LibraryEntity("默认题库", now, now);
				library.setEditable(Editable.UNABLE);
				libraryService.save(library);
			}
			return new Result(Code.SUCCESS.value(), "成功");
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Result(Code.ERROR.value(), e.getMessage());
		}
	}
	
	@RequestMapping(value = "/api/init/group")
	public Result group() {
		try {
			GroupEntity group = groupService.findByName("默认分组");
			if (group == null) {
				Date now = new Date();
				group = new GroupEntity("默认分组", now, now);
				group.setEditable(Editable.UNABLE);
				groupService.save(group);
			}
			return new Result(Code.SUCCESS.value(), "成功");
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Result(Code.ERROR.value(), e.getMessage());
		}
	}
	
	@RequestMapping(value = "/api/init/classify")
	public Result classify() {
		try {
			ClassifyEntity classify = classifyService.findByName("默认分类");
			if (classify == null) {
				Date now = new Date();
				classify = new ClassifyEntity("默认题库", now, now);
				classify.setEditable(Editable.UNABLE);
				classifyService.save(classify);
			}
			return new Result(Code.SUCCESS.value(), "成功");
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Result(Code.ERROR.value(), e.getMessage());
		}
	}

}
