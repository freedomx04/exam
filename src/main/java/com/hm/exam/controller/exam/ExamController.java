package com.hm.exam.controller.exam;

import org.apache.commons.codec.binary.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.hm.exam.common.result.Code;
import com.hm.exam.common.result.Result;
import com.hm.exam.common.utils.CiphersUtils;
import com.hm.exam.entity.exam.PaperEntity;
import com.hm.exam.entity.student.StudentEntity;
import com.hm.exam.service.exam.ExamService;
import com.hm.exam.service.exam.PaperService;
import com.hm.exam.service.student.StudentService;

@RestController
public class ExamController {
	
	static Logger log = LoggerFactory.getLogger(ExamController.class);
	
	@Autowired
	ExamService examService;
	
	@Autowired
	PaperService paperService;
	
	@Autowired
	StudentService studentService;
	
	@RequestMapping(value = "/api/exam/student/login")
	public Result studentLogin(Long paperId, String username, String password) {
		try {
			PaperEntity paper = paperService.findOne(paperId);
			
			StudentEntity student = studentService.findByUsername(username);
			if (student == null) {
				return new Result(Code.NULL.value(), "该考生不存在!");
			}
			
			if (!paper.getStudents().contains(student)) {
				return new Result(Code.STUDENT_NO_CONTAIN.value(), "该考生没有考试资格！");
			}
			
			if (!StringUtils.equals(CiphersUtils.getInstance().MD5Password(password), student.getPassword())) {
				return new Result(Code.STUDENT_PWD_ERROR.value(), "密码错误");
			}
			
			
			return new Result(Code.SUCCESS.value(), "success");
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Result(Code.ERROR.value(), e.getMessage());
		}
	}
	

}