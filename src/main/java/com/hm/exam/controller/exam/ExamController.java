package com.hm.exam.controller.exam;

import java.util.Date;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.hm.exam.common.result.Code;
import com.hm.exam.common.result.Result;
import com.hm.exam.common.utils.CiphersUtils;
import com.hm.exam.common.utils.SessionUtils;
import com.hm.exam.entity.exam.ExamEntity;
import com.hm.exam.entity.exam.PaperEntity;
import com.hm.exam.entity.question.QuestionEntity;
import com.hm.exam.entity.student.StudentEntity;
import com.hm.exam.service.exam.ExamService;
import com.hm.exam.service.exam.PaperService;
import com.hm.exam.service.question.QuestionService;
import com.hm.exam.service.student.StudentService;

@RestController
public class ExamController {
	
	static Logger log = LoggerFactory.getLogger(ExamController.class);
	
	@Autowired
	ExamService examService;
	
	@Autowired
	PaperService paperService;
	
	@Autowired
	QuestionService questionService;
	
	@Autowired
	StudentService studentService;
	
	@RequestMapping(value = "/api/exam/login", method = RequestMethod.POST)
	public Result examLogin(Long paperId, String username, String password) {
		try {
			PaperEntity paper = paperService.findOne(paperId);
			
			StudentEntity student = studentService.findByUsername(username);
			if (student == null) {
				return new Result(Code.NULL.value(), "该考生不存在!");
			}
			
			if (!paper.getStudents().contains(student)) {
				return new Result(Code.STUDENT_NO_CONTAIN.value(), "您不在该场考试的考生范围内！");
			}
			
			if (!StringUtils.equals(CiphersUtils.getInstance().MD5Password(password), student.getPassword())) {
				return new Result(Code.STUDENT_PWD_ERROR.value(), "您输入密码错误！");
			}
			
			// 存入session
			student.setPaperId(paper.getId());
			SessionUtils.getSession().setAttribute("cur_student", student);
			
			return new Result(Code.SUCCESS.value(), "success");
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Result(Code.ERROR.value(), e.getMessage());
		}
	}
	
	@RequestMapping(value = "/api/exam/submit", method = RequestMethod.POST)
	public Result examSubmit(Long examId, @RequestParam("submitList[]") List<String> submitList) {
		try {
			ExamEntity exam = examService.findOne(examId);
			PaperEntity paper = exam.getPaper();
			
			Integer score = 0;	// 得分
			Integer correctNum = 0;	// 答对题数
			Integer totalNum = paper.getQuestions().size();	// 题数
			
			for (String submit: submitList) { // 1-A
				Long questionId = Long.parseLong(StringUtils.split(submit, "-")[0]);
				String answer = StringUtils.split(submit, "-")[1];
				
				QuestionEntity question = questionService.findOne(questionId);
				// 判断是否答对
				if (StringUtils.equals(answer, question.getAnswer())) {
					correctNum++;
					score += question.getScore();
				}
			}
			
			// 保存考试结果
			exam.setCorrectNum(correctNum);
			exam.setTotalNum(totalNum);
			exam.setScore(score);
			exam.setUpdateTime(new Date());
			examService.save(exam);
			
			return new Result(Code.SUCCESS.value(), "success");
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Result(Code.ERROR.value(), e.getMessage());
		}
	}
	
	

}
