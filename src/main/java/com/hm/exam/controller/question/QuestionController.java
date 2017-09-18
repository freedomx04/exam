package com.hm.exam.controller.question;

import java.io.File;
import java.io.FileInputStream;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.InputStreamResource;
import org.springframework.data.domain.Page;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
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
public class QuestionController {

	static Logger log = LoggerFactory.getLogger(QuestionController.class);

	@Autowired
	QuestionService questionService;

	@Autowired
	LibraryService libraryService;

	@RequestMapping(value = "/api/question/create", method = RequestMethod.POST)
	public Result create(Long libraryId, Integer type, String title, String optionA, String optionB, String optionC,
			String optionD, String optionE, String optionF, String answer, String analysis, Integer score) {
		try {
			Date now = new Date();
			LibraryEntity library = libraryService.findOne(libraryId);
			QuestionEntity question = new QuestionEntity(library, type, title, optionA, optionB, optionC, optionD,
					optionE, optionF, answer, analysis, score, now, now);
			questionService.save(question);
			return new Result(Code.SUCCESS.value(), "created");
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Result(Code.ERROR.value(), e.getMessage());
		}
	}

	@RequestMapping(value = "/api/question/update", method = RequestMethod.POST)
	public Result update(Long questionId, Long libraryId, String title, String optionA, String optionB, String optionC,
			String optionD, String optionE, String optionF, String answer, String analysis, Integer score) {
		try {
			LibraryEntity library = libraryService.findOne(libraryId);
			QuestionEntity question = questionService.findOne(questionId);
			question.setLibrary(library);
			question.setTitle(title);
			question.setOptionA(optionA);
			question.setOptionB(optionB);
			question.setOptionC(optionC);
			question.setOptionD(optionD);
			question.setOptionE(optionE);
			question.setOptionF(optionF);
			question.setAnswer(answer);
			question.setAnalysis(analysis);
			question.setScore(score);
			question.setUpdateTime(new Date());
			questionService.save(question);
			return new Result(Code.SUCCESS.value(), "updated");
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Result(Code.ERROR.value(), e.getMessage());
		}
	}

	@RequestMapping(value = "/api/question/delete")
	public Result delete(Long questionId) {
		try {
			questionService.delete(questionId);
			return new Result(Code.SUCCESS.value(), "deleted");
		} catch (Exception e) {
			if (e.getCause().toString().indexOf("ConstraintViolationException") != -1) {
				return new Result(Code.CONSTRAINT.value(), "该数据存在关联，无法删除！");
			}
			log.error(e.getMessage(), e);
			return new Result(Code.ERROR.value(), e.getMessage());
		}
	}

	@RequestMapping(value = "/api/question/batchDelete")
	public Result batchDelete(@RequestParam("questionIdList[]") List<Long> questionIdList) {
		try {
			questionService.delete(questionIdList);
			return new Result(Code.SUCCESS.value(), "deleted");
		} catch (Exception e) {
			if (e.getCause().toString().indexOf("ConstraintViolationException") != -1) {
				return new Result(Code.CONSTRAINT.value(), "该数据存在关联，无法删除！");
			}
			log.error(e.getMessage(), e);
			return new Result(Code.ERROR.value(), e.getMessage());
		}
	}

	@RequestMapping(value = "/api/question/get")
	public Result get(Long questionId) {
		try {
			QuestionEntity question = questionService.findOne(questionId);
			return new ResultInfo(Code.SUCCESS.value(), "ok", question);
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Result(Code.ERROR.value(), e.getMessage());
		}
	}

	@RequestMapping(value = "/api/question/list")
	public Result list(Long libraryId, Integer type) {
		try {
			List<QuestionEntity> list = new ArrayList<>();
			if (libraryId != 0 && type != 0) {
				LibraryEntity library = libraryService.findOne(libraryId);
				list = questionService.listByLibraryAndType(library, type);
			} else if (libraryId != 0) {
				LibraryEntity library = libraryService.findOne(libraryId);
				list = questionService.listByLibrary(library);
			} else if (type != 0) {
				list = questionService.listByType(type);
			} else {
				list = questionService.list();
			}
			
			return new ResultInfo(Code.SUCCESS.value(), "ok", list);
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Result(Code.ERROR.value(), e.getMessage());
		}
	}

	@RequestMapping(value = "/api/question/listPaging")
	public Result listPaging(int page, int size) {
		try {
			Page<QuestionEntity> questionPage = questionService.list(page, size);
			return new ResultInfo(Code.SUCCESS.value(), "ok", questionPage);
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Result(Code.ERROR.value(), e.getMessage());
		}
	}
	
	@RequestMapping(value = "/api/question/listByLibrary")
	public Result listByLibrary(Long libraryId) {
		try {
			LibraryEntity library = libraryService.findOne(libraryId);
			List<QuestionEntity> list = questionService.listByLibrary(library);
			return new ResultInfo(Code.SUCCESS.value(), "ok", list);
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Result(Code.ERROR.value(), e.getMessage());
		}
	}
	
	@Autowired
	HttpServletRequest request;
	
	@RequestMapping(value = "/api/question/template")
	public ResponseEntity<InputStreamResource> template() {
		try {
			String root = request.getSession().getServletContext().getRealPath("/");
			File file = new File(root + "/resource/question-template.xlsx");
			String fileName = "试题导入模板.xlsx";
			
			HttpHeaders headers = new HttpHeaders();
			headers.add("Cache-Control", "no-cache, no-store, must-revalidate");
            headers.add("Content-Disposition",
                            String.format("attachment; filename=\"%s\"", new String(fileName.getBytes("UTF-8"), "ISO8859-1")));
            headers.add("Pragma", "no-cache");
            headers.add("Expires", "0");
            
            return ResponseEntity.ok().headers(headers).contentLength(file.length())
                            .contentType(MediaType.parseMediaType("application/octet-stream"))
                            .body(new InputStreamResource(new FileInputStream(file)));
		} catch (Exception e) {
            log.error(e.getMessage(), e);
            return null;
        }
	}

}
