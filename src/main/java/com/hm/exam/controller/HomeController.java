package com.hm.exam.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import com.hm.exam.entity.question.LibraryEntity;
import com.hm.exam.entity.question.QuestionEntity;
import com.hm.exam.entity.student.GroupEntity;
import com.hm.exam.entity.student.StudentEntity;
import com.hm.exam.service.question.LibraryService;
import com.hm.exam.service.question.QuestionService;
import com.hm.exam.service.student.GroupService;
import com.hm.exam.service.student.StudentService;

@Controller
public class HomeController {
	
	@Autowired
	LibraryService libraryService;
	
	@Autowired
	QuestionService questionService;
	
	@Autowired
	GroupService groupService;
	
	@Autowired
	StudentService studentService;
	
	/**
	 * 题库管理
	 */
	@RequestMapping(value = "/libraryList")
	String libraryList() {
		return "pages/question/library_list";
	}
	
	@RequestMapping(value = "/questionList")
	String questionList() {
		return "pages/question/question_list";
	}
	
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
	
	/**
	 * 考试管理
	 */
	@RequestMapping(value = "/groupList")
	String groupList() {
		return "pages/student/group_list";
	}
	
	@RequestMapping(value = "studentList") 
	String studentList() {
		return "pages/student/student_list";
	}
	
	@RequestMapping(value = "studentAdd")
	String studentAdd(ModelMap modelMap, String method, Long studentId) {
		modelMap.addAttribute("method", method);
		String title = method.equals("add") ? "考生新增" : "考生编辑";
		modelMap.addAttribute("title", title);
		
		List<GroupEntity> groupList = groupService.list();
		modelMap.addAttribute("groupList", groupList);
		
		if (studentId != null) {
			StudentEntity student = studentService.findOne(studentId);
			modelMap.addAttribute("student", student);
		}
		
		return "pages/student/student_add";
	}
	
}
