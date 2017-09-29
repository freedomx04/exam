package com.hm.exam.controller;

import java.math.BigInteger;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import com.hm.exam.entity.exam.ClassifyEntity;
import com.hm.exam.entity.exam.PaperEntity;
import com.hm.exam.entity.question.LibraryEntity;
import com.hm.exam.entity.question.QuestionEntity;
import com.hm.exam.entity.question.TypeEntity;
import com.hm.exam.entity.student.GroupEntity;
import com.hm.exam.entity.student.StudentEntity;
import com.hm.exam.service.exam.ClassifyService;
import com.hm.exam.service.exam.PaperService;
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
	
	@Autowired
	ClassifyService classifyService;
	
	@Autowired
	PaperService paperService;
	
	/**
	 * 题库管理
	 */
	@RequestMapping(value = "/libraryList")
	String libraryList() {
		return "pages/question/library_list";
	}
	
	@RequestMapping(value = "/questionList")
	String questionList(ModelMap modelMap) {
		List<LibraryEntity> libraryList = libraryService.list();
		modelMap.addAttribute("libraryList", libraryList);
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
	 * 考生管理
	 */
	@RequestMapping(value = "/groupList")
	String groupList() {
		return "pages/student/group_list";
	}
	
	@RequestMapping(value = "studentList") 
	String studentList(ModelMap modelMap) {
		List<GroupEntity> groupList = groupService.list();
		modelMap.addAttribute("groupList", groupList);
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
	
	// 模拟考试
	@RequestMapping(value = "practiceOrder")
	String practiceOrder(ModelMap modelMap, Long libraryId, Integer type) {
		modelMap.addAttribute("title", "顺序练习");
		
		List<BigInteger> idList = new ArrayList<BigInteger>();
		if (libraryId != null) {
			idList = questionService.listIdByLibraryId(libraryId);
			LibraryEntity library = libraryService.findOne(libraryId);
			modelMap.addAttribute("subTitle", "题库：" + library.getName());
		} else if (type != null) {
			idList = questionService.listIdByType(type);
			String subTitle = questionService.getTitle(type);
			modelMap.addAttribute("subTitle", "题型：" + subTitle);
		} else {	
			idList = questionService.listId();
		}
		modelMap.addAttribute("idList", idList);
		return "pages/practice/practice_question";
	}
	
	@RequestMapping(value = "practiceRandom")
	String practiceRandom(ModelMap modelMap, Long libraryId, Integer type) {
		modelMap.addAttribute("title", "随机练习");
		
		List<BigInteger> idList = new ArrayList<>();
		if (libraryId != null) {
			idList = questionService.listIdByLibraryId(libraryId);
			LibraryEntity library = libraryService.findOne(libraryId);
			modelMap.addAttribute("subTitle", "题库：" + library.getName());
		} else if (type != null) {
			idList = questionService.listIdByType(type);
			String subTitle = questionService.getTitle(type);
			modelMap.addAttribute("subTitle", "题型：" + subTitle);
		} else {
			idList = questionService.listId();
		}
		Collections.shuffle(idList);
		modelMap.addAttribute("idList", idList);
		return "pages/practice/practice_question";
	}
	
	@RequestMapping(value = "practiceLibrary")
	String practiceLibrary(ModelMap modelMap) {
		List<LibraryEntity> libraryList = libraryService.list();
		for (LibraryEntity library: libraryList) {
			Integer count = questionService.countByLibrary(library);
			library.setCount(count);
		}
		modelMap.addAttribute("libraryList", libraryList);
		return "pages/practice/practice_library";
	}
	
	@RequestMapping(value = "practiceType")
	String practiceType(ModelMap modelMap) {
		Integer[] types = new Integer[] {1, 2, 3};
		List<TypeEntity> typeList = new ArrayList<>();
		for (Integer type: types) {
			Integer count = questionService.countByType(type);
			String name = questionService.getTitle(type);
			TypeEntity typeObj = new TypeEntity(type, name, count);
			typeList.add(typeObj);
		}
		modelMap.addAttribute("typeList", typeList);
		return "pages/practice/practice_type";
	}
	
	/**
	 * 考试管理
	 */
	@RequestMapping(value = "/classifyList")
	String classifyList() {
		return "pages/exam/classify_list";
	}
	
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
		
		return "pages/exam/paper_edit";
	}
	
	@RequestMapping(value = "/paperQuestion")
	String paperQuestion(ModelMap modelMap, Long paperId) {
		PaperEntity paper = paperService.findOne(paperId);
		modelMap.addAttribute("paper", paper);
		
		List<LibraryEntity> libraryList = libraryService.list();
		for (LibraryEntity library: libraryList) {
			Integer count = questionService.countByLibrary(library);
			library.setCount(count);
		}
		modelMap.addAttribute("libraryList", libraryList);
		return "pages/exam/paper_question";
	}
	
	@RequestMapping(value = "/paperSetting")
	String paperSetting(ModelMap modelMap, Long paperId) {
		PaperEntity paper = paperService.findOne(paperId);
		modelMap.addAttribute("paper", paper);
		return "pages/exam/paper_setting";
	}
	
}
