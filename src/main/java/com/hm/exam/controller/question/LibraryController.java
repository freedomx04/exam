package com.hm.exam.controller.question;

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
import com.hm.exam.entity.question.LibraryEntity;
import com.hm.exam.entity.question.QuestionEntity;
import com.hm.exam.service.question.LibraryService;
import com.hm.exam.service.question.QuestionService;

@RestController
public class LibraryController {
	
	static Logger log = LoggerFactory.getLogger(LibraryController.class);
	
	@Autowired
	LibraryService libraryService;
	
	@Autowired
	QuestionService questionService;
	
	@RequestMapping(value = "/api/library/create", method = RequestMethod.POST)
	public Result create(String name) {
		try {
			LibraryEntity library = libraryService.findByName(name);
			if (library != null) {
				return new Result(Code.EXISTED.value(), "题库已存在");
			}
			
			Date now = new Date();
			library = new LibraryEntity(name, now, now);
			libraryService.save(library);
			return new Result(Code.SUCCESS.value(), "created");
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Result(Code.ERROR.value(), e.getMessage());
		}
	}
	
	@RequestMapping(value = "/api/library/update", method = RequestMethod.POST)
	public Result update(Long libraryId, String name) {
		try {
			LibraryEntity library = libraryService.findOne(libraryId);
			
			LibraryEntity updateLibrary = libraryService.findByName(name);
			if (updateLibrary == null || library.getId() == updateLibrary.getId()) {
				library.setName(name);
				library.setUpdateTime(new Date());
				libraryService.save(library);
				return new Result(Code.SUCCESS.value(), "updated");
			} else {
				return new Result(Code.EXISTED.value(), "题库已存在");
			}
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Result(Code.ERROR.value(), e.getMessage());
		}
	}
	
	@RequestMapping(value = "/api/library/delete")
	public Result delete(Long libraryId) {
		try {
			LibraryEntity library = libraryService.findOne(libraryId);
			List<QuestionEntity> questionList = questionService.listByLibrary(library);
			for (QuestionEntity question: questionList) {
				LibraryEntity defaultLibrary = libraryService.findByName("默认题库");
				question.setLibrary(defaultLibrary);
				questionService.save(question);
			}
			libraryService.delete(libraryId);
			return new Result(Code.SUCCESS.value(), "deleted");
		} catch (Exception e) {
			if (e.getCause().toString().indexOf("ConstraintViolationException") != -1) {
				return new Result(Code.CONSTRAINT.value(), "该数据存在关联，无法删除！");
			}
			log.error(e.getMessage(), e);
			return new Result(Code.ERROR.value(), e.getMessage());
		}
	}
	
	@RequestMapping(value = "/api/library/batchDelete", method = RequestMethod.POST)
	public Result batchDelete(@RequestParam("libraryIdList[]") List<Long> libraryIdList) {
		try {
			for (Long libraryId: libraryIdList) {
				delete(libraryId);
			}
			return new Result(Code.SUCCESS.value(), "deleted");
		} catch (Exception e) {
			if (e.getCause().toString().indexOf("ConstraintViolationException") != -1) {
				return new Result(Code.CONSTRAINT.value(), "该数据存在关联，无法删除！");
			}
			log.error(e.getMessage(), e);
			return new Result(Code.ERROR.value(), e.getMessage());
		}
	}
	
	@RequestMapping(value = "/api/library/get")
	public Result get(Long libraryId) {
		try {
			LibraryEntity library = libraryService.findOne(libraryId);
			return new ResultInfo(Code.SUCCESS.value(), "ok", library);
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Result(Code.ERROR.value(), e.getMessage());
		}
	}
	
	@RequestMapping(value = "/api/library/list")
	public Result list() {
		try {
			List<LibraryEntity> list = libraryService.list();
			for (LibraryEntity library: list) {
				Integer count = questionService.countByLibrary(library);
				library.setCount(count);
			}
			return new ResultInfo(Code.SUCCESS.value(), "ok", list);
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Result(Code.ERROR.value(), e.getMessage());
		}
	}
	
}
