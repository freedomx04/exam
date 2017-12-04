package com.hm.exam.controller;

import java.math.BigInteger;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.hm.exam.common.utils.SessionUtils;
import com.hm.exam.entity.exam.ExamEntity;
import com.hm.exam.entity.exam.ExamEntity.ExamStatus;
import com.hm.exam.entity.exam.PaperEntity;
import com.hm.exam.entity.exam.PaperEntity.PaperStatus;
import com.hm.exam.entity.question.LibraryEntity;
import com.hm.exam.entity.question.TypeEntity;
import com.hm.exam.entity.student.StudentEntity;
import com.hm.exam.service.exam.ExamService;
import com.hm.exam.service.exam.PaperService;
import com.hm.exam.service.question.LibraryService;
import com.hm.exam.service.question.QuestionService;
import com.hm.exam.service.student.StudentService;

@Controller
public class PageController {
	
	static Logger log = LoggerFactory.getLogger(PageController.class);
	
	@Autowired
	PaperService paperService;
	
	@Autowired
	StudentService studentService;
	
	@Autowired
	ExamService examService;
	
	@Autowired
	QuestionService questionService;
	
	@Autowired
	LibraryService libraryService;
	
	@Autowired
	HttpServletRequest request;
	
	public class TipsType {
		public static final int TIPS_UNABLE = 1;	// 考试不可用
		public static final int TIPS_START = 2;		// 考试时间未开始
		public static final int TIPS_END = 3;		// 考试时间已结束
		public static final int TIPS_LOGIN = 4;		// 登录页面
		public static final int TIPS_SUCCESS = 5;	// 登录成功
		public static final int TIPS_CONTINUE = 6;	// 继续考试
		public static final int TIPS_FINISH = 7;	// 考试已结束
		public static final int TIPS_COMPLETE = 8;	// 考试已提交
	}
	
	@RequestMapping(value = "/online/{paperId}")
	String paper(ModelMap modelMap, @PathVariable Long paperId) {
		PaperEntity paper = paperService.findOne(paperId);
		 
		// 判断试卷是否存在
		if (paper == null) {
			return "pages/404";
		}
		
		modelMap.addAttribute("paper", paper);
		
		// 试卷不可用
		if (paper.getStatus() == PaperStatus.STATUS_UNABLE) {
			modelMap.addAttribute("tipsType", TipsType.TIPS_UNABLE);
			return "pages/online/online_tips";
		}
		
		// 判断当前时间是否在试卷考试时间范围内
		Calendar now = Calendar.getInstance();
		now.setTime(new Date());
		Calendar start = Calendar.getInstance();
		start.setTime(paper.getStartTime());
		Calendar end = Calendar.getInstance();
		end.setTime(paper.getEndTime());
		if (now.before(start)) {
			modelMap.addAttribute("tipsType", TipsType.TIPS_START);
			return "pages/online/online_tips";
		}
		if (now.after(end)) {
			modelMap.addAttribute("tipsType", TipsType.TIPS_END);
			return "pages/online/online_tips";
		}
		
		StudentEntity currentStudent = SessionUtils.getStudent();
		// 判断是否登录
		if (currentStudent == null) {
			// 未登录，跳转到登录页面
			modelMap.addAttribute("tipsType", TipsType.TIPS_LOGIN);
			return "pages/online/online_tips";
		} else {
			// 已登录 
			StudentEntity student = studentService.findOne(currentStudent.getId());
			ExamEntity exam = examService.findOne(paper, student);
			// 考试未开始
			if (exam == null) {	
				modelMap.addAttribute("tipsType", TipsType.TIPS_SUCCESS);
			} 
			// 考试中断，继续考试
			else if(exam.getStatus() == ExamStatus.STATUS_EXAMING) {		
				// 获取剩余时间
				Calendar startTime = Calendar.getInstance();
				startTime.setTime(exam.getCreateTime());
				Calendar currentTime = Calendar.getInstance();
				currentTime.setTime(new Date());
				long startSecond = startTime.getTimeInMillis();
				long currentSecond = currentTime.getTimeInMillis();
				long totleSecond = paper.getDuration() * 60;
				long remainingTime = (totleSecond - (currentSecond - startSecond) / 1000);
				
				// 还有剩余时间，继续考试
				if (remainingTime > 0) {
					modelMap.addAttribute("remainingTime", remainingTime);
					modelMap.addAttribute("tipsType", TipsType.TIPS_CONTINUE);
				} 
				// 时间已到，自动提交试卷
				else {
					long finishSecond = totleSecond + (startSecond / 1000);
					Date finishTime = new Date(finishSecond);
					exam.setUpdateTime(finishTime);
					exam.setStatus(ExamStatus.STATUS_EXAM_FINISH);
					modelMap.addAttribute("tipsType", TipsType.TIPS_FINISH);
				}
			} 
			// 考试已结束
			else if (exam.getStatus() == ExamStatus.STATUS_EXAM_FINISH) {
				modelMap.addAttribute("submitTime", exam.getUpdateTime());
				modelMap.addAttribute("tipsType", TipsType.TIPS_FINISH);
			}
			
			return "pages/online/online_tips";
		}
	}
	
	@RequestMapping(value = "/online/exam")
	String exam(ModelMap modelMap) {
		StudentEntity currentStudent = SessionUtils.getStudent();
		if (currentStudent == null) {
			return "redirect:/online";
		}
		
		PaperEntity paper = paperService.findOne(currentStudent.getPaperId());
		StudentEntity student = studentService.findOne(currentStudent.getId());
		
		long remainingTime = 0;
		
		ExamEntity exam = examService.findOne(paper, student);
		// 第一次进入考试
		if (exam == null) {
			Date now = new Date();
			exam = new ExamEntity(paper, student, now, now);
			exam.setStatus(ExamStatus.STATUS_EXAMING);
			examService.save(exam);
			remainingTime = paper.getDuration() * 60;
		} 
		// 考试中断进入
		else if (exam.getStatus() == ExamStatus.STATUS_EXAMING) {
			Calendar startTime = Calendar.getInstance();
			startTime.setTime(exam.getCreateTime());
			Calendar currentTime = Calendar.getInstance();
			currentTime.setTime(new Date());
			long startSecond = startTime.getTimeInMillis();
			long currentSecond = currentTime.getTimeInMillis();
			long totleSecond = paper.getDuration() * 60;
			remainingTime = (totleSecond - (currentSecond - startSecond) / 1000);
		} 
		// 考试已结束
		else if (exam.getStatus() == ExamStatus.STATUS_EXAM_FINISH) {
			modelMap.addAttribute("paper", paper);
			modelMap.addAttribute("submitTime", exam.getUpdateTime());
			modelMap.addAttribute("tipsType", TipsType.TIPS_FINISH);
			return "pages/online/online_tips";
		}
		
		if (remainingTime >= 0) {
			modelMap.addAttribute("remainingTime", remainingTime);
		} else {
			modelMap.addAttribute("remainingTime", 0);
		}
		
		modelMap.addAttribute("paper", paper);
		modelMap.addAttribute("student", student);
		modelMap.addAttribute("exam", exam);
		
		return "pages/online/online_exam";
	}
	
	@RequestMapping(value = "/online/complete")
	String complete(ModelMap modelMap, Long eid) {
		ExamEntity exam = examService.findOne(eid);
		
		PaperEntity paper = paperService.findOne(exam.getPaper().getId());
		modelMap.addAttribute("paper", paper);
		modelMap.addAttribute("submitTime", exam.getUpdateTime());
		
		modelMap.addAttribute("tipsType", TipsType.TIPS_COMPLETE);
		return "pages/online/online_tips";
	}
	
	// 模拟考试
	@RequestMapping(value = "/practice")
	String practice() {
		return "pages/practice/practice";
	}
	
	@RequestMapping(value = "/practice/order")
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
	
	@RequestMapping(value = "practice/random")
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
	
	@RequestMapping(value = "practice/library")
	String practiceLibrary(ModelMap modelMap) {
		List<LibraryEntity> libraryList = libraryService.list();
		for (LibraryEntity library: libraryList) {
			Integer count = questionService.countByLibrary(library);
			library.setCount(count);
		}
		modelMap.addAttribute("libraryList", libraryList);
		return "pages/practice/practice_library";
	}
	
	@RequestMapping(value = "practice/type")
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
	 * 移动端
	 */
	@RequestMapping(value = "m/practice")
	String m_practice() {
		return "pages/m/practice";
	}
	
	@RequestMapping(value = "m/practice/order")
	String m_practice_order(ModelMap modelMap, Long libraryId, Integer type) {
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
		return "pages/m/practice_question";
	}
	
}
