package com.hm.exam.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import com.hm.exam.common.utils.CurrentUserUtils;
import com.hm.exam.entity.authority.RoleEntity;
import com.hm.exam.entity.authority.UserEntity;
import com.hm.exam.entity.exam.ClassifyEntity;
import com.hm.exam.entity.exam.PaperEntity;
import com.hm.exam.entity.question.LibraryEntity;
import com.hm.exam.entity.question.QuestionEntity;
import com.hm.exam.entity.student.GroupEntity;
import com.hm.exam.service.authority.RoleService;
import com.hm.exam.service.authority.UserService;
import com.hm.exam.service.exam.ClassifyService;
import com.hm.exam.service.exam.PaperService;
import com.hm.exam.service.question.LibraryService;
import com.hm.exam.service.question.QuestionService;
import com.hm.exam.service.student.GroupService;
import com.hm.exam.service.student.StudentService;

@Controller
public class HomeController {
	
	@Autowired
	RoleService roleService;
	
	@Autowired
	UserService userService;
	
	@Autowired
	LibraryService libraryService;
	
	@Autowired
	QuestionService questionService;
	
	@Autowired
	GroupService groupService;
	
	@Autowired
	StudentService studentService;
	
	@Autowired
	ClassifyService classifyService;
	
	@Autowired
	PaperService paperService;
	
	/**
	 * 控制中心
	 */
	@RequestMapping(value = "/overview")
	String overview() {
		return "pages/overview";
	}
	
	/**
	 * 用户管理
	 */
	@RequestMapping(value = "/userList")
	String userList(ModelMap modelMap) {
		List<RoleEntity> roleList = roleService.list();
		modelMap.addAttribute("roleList", roleList);
		return "pages/authority/user_list";
	}
	
	/**
	 * 题库管理
	 */
	@RequestMapping(value = "/questionAdd")
	String questionAdd(ModelMap modelMap, Integer type, String method, Long questionId) {
		modelMap.addAttribute("method", method);
		String title = method.equals("add") ? "试题新增" : "试题编辑";
		modelMap.addAttribute("title", title);
		
		List<LibraryEntity> libraryList = libraryService.list();
		modelMap.addAttribute("libraryList", libraryList);
		
		if (questionId != null) {
			QuestionEntity question = questionService.findOne(questionId);
			modelMap.addAttribute("question", question);
			type = question.getType();
		}
		
		switch (type) {
		case 1:
			modelMap.addAttribute("typeTitle", "单选题");
			return "pages/question/question_single_choice";
		case 2:
			modelMap.addAttribute("typeTitle", "多选题");
			return "pages/question/question_multiple_choice";
		case 3:
			modelMap.addAttribute("typeTitle", "判断题");
			return "pages/question/question_true_false";
		default:
			return "pages/404";
		}
	}
	
	@RequestMapping(value = "/questionList")
	String questionList2(ModelMap modelMap) {
		List<LibraryEntity> libraryList = libraryService.list();
		modelMap.addAttribute("libraryList", libraryList);
		return "pages/question/question_list";
	}
	
	/**
	 * 考生管理
	 */
	@RequestMapping(value = "studentList")
	String studentList2(ModelMap modelMap) {
		List<GroupEntity> groupList = groupService.list();
		modelMap.addAttribute("groupList", groupList);
		return "pages/student/student_list";
	}
	
	/**
	 * 考试管理
	 */
	@RequestMapping(value = "/paperList")
	String paperList(ModelMap modelMap) {
		List<ClassifyEntity> classifyList = classifyService.list();
		modelMap.addAttribute("classifyList", classifyList);
		return "pages/exam/paper_list";
	}
	
	@RequestMapping(value = "/paperAdd")
	String paperAdd(ModelMap modelMap) {
		List<ClassifyEntity> classifyList = classifyService.list();
		modelMap.addAttribute("classifyList", classifyList);
		
		List<LibraryEntity> libraryList = libraryService.list();
		for (LibraryEntity library: libraryList) {
			Integer count = questionService.countByLibrary(library);
			library.setCount(count);
		}
		modelMap.addAttribute("libraryList", libraryList);
		
		List<GroupEntity> groupList = groupService.list();
		for (GroupEntity group: groupList) {
			Integer count = studentService.countByGroup(group);
			group.setCount(count);
		}
		modelMap.addAttribute("groupList", groupList);
		
		List<QuestionEntity> questionList = questionService.list();
		modelMap.addAttribute("questionList", questionList);
		
		return "pages/exam/paper_add";
	}
	
	@RequestMapping(value = "/paperEdit")
	String paperEdit(ModelMap modelMap, Long paperId) {
		PaperEntity paper = paperService.findOne(paperId);
		modelMap.addAttribute("paper", paper);
		
		List<ClassifyEntity> classifyList = classifyService.list();
		modelMap.addAttribute("classifyList", classifyList);
		
		List<LibraryEntity> libraryList = libraryService.list();
		for (LibraryEntity library: libraryList) {
			Integer count = questionService.countByLibrary(library);
			library.setCount(count);
		}
		modelMap.addAttribute("libraryList", libraryList);
		
		List<GroupEntity> groupList = groupService.list();
		for (GroupEntity group: groupList) {
			Integer count = studentService.countByGroup(group);
			group.setCount(count);
		}
		modelMap.addAttribute("groupList", groupList);
		
		return "pages/exam/paper_edit";
	}
	
	
	@RequestMapping(value = "/feedback")
	String feedbackList(ModelMap modelMap, Long paperId) {
		PaperEntity paper = paperService.findOne(paperId);
		modelMap.addAttribute("title", paper.getTitle());
		modelMap.addAttribute("paperId", paperId);
		return "pages/exam/feedback";
	}
	
	@RequestMapping(value = "/system/notice")
	String system_notice() {
		return "pages/system/notice";
	}
	
	/**
	 * 个人中心
	 */
	@RequestMapping(value = "/modifyPassword")
	String modifyPassword(ModelMap modelMap) {
		UserEntity user = CurrentUserUtils.getInstance().getUser();
		modelMap.addAttribute("user", user);
		return "pages/personal/modify_password";
	}
	
}
