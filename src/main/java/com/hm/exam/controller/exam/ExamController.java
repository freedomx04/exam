package com.hm.exam.controller.exam;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.hm.exam.common.result.Code;
import com.hm.exam.common.result.Result;
import com.hm.exam.common.result.ResultInfo;
import com.hm.exam.entity.exam.ExamEntity;
import com.hm.exam.entity.exam.PaperEntity;
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
	
	@RequestMapping(value = "/api/exam/create")
	public Result create(Long paperId, Long studentId) {
		try {
			//PaperEntity paper = paperService.findOne(paperId);
			
			return new Result(Code.SUCCESS.value(), "created");
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Result(Code.ERROR.value(), e.getMessage());
		}
	}
	
	@RequestMapping(value = "/api/exam/listByPaper")
	public Result listByPaper(Long paperId) {
		try {
			PaperEntity paper = paperService.findOne(paperId);
			List<ExamEntity> list = examService.listByPaper(paper);
			return new ResultInfo(Code.SUCCESS.value(), "success", list);
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Result(Code.ERROR.value(), e.getMessage());
		}
	}
	
	

}
