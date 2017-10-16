package com.hm.exam.controller.exam;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RestController;

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
	

}
