package com.hm.exam.controller.exam;

import java.util.Date;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.hm.exam.common.result.Code;
import com.hm.exam.common.result.Result;
import com.hm.exam.common.result.ResultInfo;
import com.hm.exam.entity.exam.FeedbackEntity;
import com.hm.exam.entity.student.StudentEntity;
import com.hm.exam.service.exam.FeedbackService;
import com.hm.exam.service.exam.PaperService;
import com.hm.exam.service.student.StudentService;

@RestController
public class FeedbackController {

	static Logger log = LoggerFactory.getLogger(FeedbackController.class);

	@Autowired
	PaperService paperService;

	@Autowired
	StudentService studentService;

	@Autowired
	FeedbackService feedbackService;

	@RequestMapping(value = "/api/feedback/create", method = RequestMethod.POST)
	public Result create(Long paperId, Long studentId, String content) {
		try {
			StudentEntity student = studentService.findOne(studentId);
			Date now = new Date();
			FeedbackEntity feedback = new FeedbackEntity(paperId, student, content, now, now);
			feedbackService.save(feedback);
			return new Result(Code.SUCCESS.value(), "添加成功");
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Result(Code.ERROR.value(), e.getMessage());
		}
	}
	
	@RequestMapping(value = "/api/feedback/delete")
	public Result delete(Long feedbackId) {
		try {
			feedbackService.delete(feedbackId);
			return new Result(Code.SUCCESS.value(), "删除成功");
		} catch (Exception e) {
			if (e.getCause().toString().indexOf("ConstraintViolationException") != -1) {
				return new Result(Code.CONSTRAINT.value(), "该数据存在关联，无法删除！");
			}
			log.error(e.getMessage(), e);
			return new Result(Code.ERROR.value(), e.getMessage());
		}
	}
	
	@RequestMapping(value = "/api/feedback/batchDelete")
	public Result batchDelete(@RequestParam("feedbackIdList[]") List<Long> feedbackIdList) {
		try {
			feedbackService.delete(feedbackIdList);
			return new Result(Code.SUCCESS.value(), "删除成功");
		} catch (Exception e) {
			if (e.getCause().toString().indexOf("ConstraintViolationException") != -1) {
				return new Result(Code.CONSTRAINT.value(), "该数据存在关联，无法删除！");
			}
			log.error(e.getMessage(), e);
			return new Result(Code.ERROR.value(), e.getMessage());
		}
	}
	
	@RequestMapping(value = "/api/feedback/get")
	public Result get(Long feedbackId) {
		try {
			FeedbackEntity feedback = feedbackService.findOne(feedbackId);
			return new ResultInfo(Code.SUCCESS.value(), "ok", feedback);
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Result(Code.ERROR.value(), e.getMessage());
		}
	}
	
	@RequestMapping(value = "/api/feedback/list")
	public Result list() {
		try {
			List<FeedbackEntity> list = feedbackService.list();
			return new ResultInfo(Code.SUCCESS.value(), "ok", list);
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Result(Code.ERROR.value(), e.getMessage());
		}
	}
	
	@RequestMapping(value = "/api/feedback/listByPaperId")
	public Result listByPaperId(Long paperId) {
		try {
			List<FeedbackEntity> list = feedbackService.listByPaperId(paperId);
			return new ResultInfo(Code.SUCCESS.value(), "ok", list);
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Result(Code.ERROR.value(), e.getMessage());
		}
	}

}
