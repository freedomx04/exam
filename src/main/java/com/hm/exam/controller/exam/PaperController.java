package com.hm.exam.controller.exam;

import java.text.SimpleDateFormat;
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
import com.hm.exam.entity.exam.ClassifyEntity;
import com.hm.exam.entity.exam.PaperEntity;
import com.hm.exam.entity.question.QuestionEntity;
import com.hm.exam.entity.student.GroupEntity;
import com.hm.exam.entity.student.StudentEntity;
import com.hm.exam.service.exam.ClassifyService;
import com.hm.exam.service.exam.PaperService;
import com.hm.exam.service.question.QuestionService;
import com.hm.exam.service.student.GroupService;
import com.hm.exam.service.student.StudentService;

@RestController
public class PaperController {

	static Logger log = LoggerFactory.getLogger(PaperController.class);

	@Autowired
	PaperService paperService;

	@Autowired
	ClassifyService classifyService;
	
	@Autowired
	QuestionService questionService;
	
	@Autowired
	StudentService studentService;
	
	@Autowired
	GroupService groupService;

	@RequestMapping(value = "/api/paper/create", method = RequestMethod.POST)
	public Result create(String title, Long classifyId, String description) {
		try {
			ClassifyEntity classify = classifyService.findOne(classifyId);
			Date now = new Date();
			PaperEntity paper = new PaperEntity(title, classify, description, now, now);
			paperService.save(paper);
			return new ResultInfo(Code.SUCCESS.value(), "created", paper);
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Result(Code.ERROR.value(), e.getMessage());
		}
	}

	@RequestMapping(value = "/api/paper/update", method = RequestMethod.POST)
	public Result update(Long paperId, String title, Long classifyId, String description) {
		try {
			PaperEntity paper = paperService.findOne(paperId);
			paper.setTitle(title);
			ClassifyEntity classify = classifyService.findOne(classifyId);
			paper.setClassify(classify);
			paper.setDescription(description);
			paper.setUpdateTime(new Date());
			paperService.save(paper);
			return new Result(Code.SUCCESS.value(), "updated");
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Result(Code.ERROR.value(), e.getMessage());
		}
	}

	@RequestMapping(value = "/api/paper/delete")
	public Result delete(Long paperId) {
		try {
			paperService.delete(paperId);
			return new Result(Code.SUCCESS.value(), "deleted");
		} catch (Exception e) {
			if (e.getCause().toString().indexOf("ConstraintViolationException") != -1) {
				return new Result(Code.CONSTRAINT.value(), "该数据存在关联，无法删除！");
			}
			log.error(e.getMessage(), e);
			return new Result(Code.ERROR.value(), e.getMessage());
		}
	}

	@RequestMapping(value = "/api/papert/get")
	public Result get(Long paperId) {
		try {
			PaperEntity paper = paperService.findOne(paperId);
			return new ResultInfo(Code.SUCCESS.value(), "ok", paper);
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Result(Code.ERROR.value(), e.getMessage());
		}
	}
	
	@RequestMapping(value = "/api/paper/list")
	public Result list() {
		try {
			List<PaperEntity> list = paperService.list();
			return new ResultInfo(Code.SUCCESS.value(), "ok", list);
		} catch (Exception e) {
			log.error(e.getMessage(), e);
            return new Result(Code.ERROR.value(), e.getMessage());
		}
	}
	
	@RequestMapping(value = "/api/paper/move", method = RequestMethod.POST)
	public Result move(@RequestParam("paperIdList[]") List<Long> paperIdList, Long classifyId) {
		try {
			ClassifyEntity classify = classifyService.findOne(classifyId);
			for (Long paperId: paperIdList) {
				PaperEntity paper = paperService.findOne(paperId);
				paper.setClassify(classify);
				paper.setUpdateTime(new Date());
				paperService.save(paper);
			}
			
			return new Result(Code.SUCCESS.value(), "moved");
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Result(Code.ERROR.value(), e.getMessage());
		}
	}
	
	@RequestMapping(value = "/api/paper/setting", method = RequestMethod.POST)
	public Result setting(Long paperId, Integer status, String startTime, String endTime, Integer duration) {
		try {
			PaperEntity paper = paperService.findOne(paperId);
			paper.setStatus(status);
			
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:ss");
			paper.setStartTime(sdf.parse(startTime));
			paper.setEndTime(sdf.parse(endTime));
			
			paper.setDuration(duration);
			paperService.save(paper);
			return new Result(Code.SUCCESS.value(), "success");
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Result(Code.ERROR.value(), e.getMessage());
		}
	}
	
	/**
	 * question
	 */
	@RequestMapping(value = "/api/paper/question/list")
	public Result questionList(Long paperId) {
		try {
			PaperEntity paper = paperService.findOne(paperId);
			return new ResultInfo(Code.SUCCESS.value(), "success", paper.getQuestions());
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Result(Code.ERROR.value(), e.getMessage());
		}
	}
	
	@RequestMapping(value = "/api/paper/question/randomAdd", method = RequestMethod.POST)
	public Result questionRandomAdd(Long paperId, @RequestParam("randomList[]") List<String> randomList) {
		try {
			PaperEntity paper = paperService.findOne(paperId);
			for (String random: randomList) {
				Long libraryId = Long.parseLong(random.split("-")[0]);
				Integer count = Integer.parseInt(random.split("-")[1]);
				
				List<QuestionEntity> questionList = questionService.listByLibraryIdOrderByRand(libraryId, count);
				for (QuestionEntity question: questionList) {
					if (!paper.getQuestions().contains(question)) {
						paper.getQuestions().add(question);
					}
				}
			}
			paperService.save(paper);
			
			return new Result(Code.SUCCESS.value(), "success");
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Result(Code.ERROR.value(), e.getMessage());
		}
	}
	
	@RequestMapping(value = "/api/paper/question/manualAdd")
	public Result questionManualAdd(Long paperId, Long questionId) {
		try {
			PaperEntity paper = paperService.findOne(paperId);
			QuestionEntity question = questionService.findOne(questionId);
			if (!paper.getQuestions().contains(question)) {
				paper.getQuestions().add(question);
			}
			paperService.save(paper);
			return new Result(Code.SUCCESS.value(), "added");
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Result(Code.ERROR.value(), e.getMessage());
		}
	}
	
	@RequestMapping(value = "/api/paper/question/delete")
	public Result questionDelete(Long paperId, Long questionId) {
		try {
			PaperEntity paper = paperService.findOne(paperId);
			QuestionEntity question = questionService.findOne(questionId);
			paper.getQuestions().remove(question);
			paperService.save(paper);
			return new Result(Code.SUCCESS.value(), "deleted");
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Result(Code.ERROR.value(), e.getMessage());
		}
	}
	
	@RequestMapping(value = "/api/paper/question/batchDelete", method = RequestMethod.POST)
	public Result questionBatchDelete(Long paperId, @RequestParam("questionIdList[]") List<Long> questionIdList) {
		try {
			PaperEntity paper = paperService.findOne(paperId);
			for(Long questionId: questionIdList) {
				QuestionEntity question = questionService.findOne(questionId);
				paper.getQuestions().remove(question);
			}
			paperService.save(paper);
			return new Result(Code.SUCCESS.value(), "deleted");
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Result(Code.ERROR.value(), e.getMessage());
		}
	}
	
	/**
	 * student
	 */
	@RequestMapping(value = "/api/paper/student/list")
	public Result studentList(Long paperId) {
		try {
			PaperEntity paper = paperService.findOne(paperId);
			return new ResultInfo(Code.SUCCESS.value(), "success", paper.getStudents());
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Result(Code.ERROR.value(), e.getMessage());
		}
	}
	
	@RequestMapping(value = "/api/paper/student/groupAdd")
	public Result groupAdd(Long paperId, Long groupId) {
		try {
			GroupEntity group = groupService.findOne(groupId);
			List<StudentEntity> studentList = studentService.listByGroup(group);
			
			PaperEntity paper = paperService.findOne(paperId);
			for (StudentEntity student: studentList) {
				if (!paper.getStudents().contains(student)) {
					paper.getStudents().add(student);
				}
			}
			paperService.save(paper);
			return new Result(Code.SUCCESS.value(), "added");
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Result(Code.ERROR.value(), e.getMessage());
		}
	}
	
	@RequestMapping(value = "/api/paper/student/manualAdd")
	public Result studentManualAdd(Long paperId, Long studentId) {
		try {
			PaperEntity paper = paperService.findOne(paperId);
			StudentEntity student = studentService.findOne(studentId);
			if (!paper.getStudents().contains(student)) {
				paper.getStudents().add(student);
			}
			paperService.save(paper);
			return new Result(Code.SUCCESS.value(), "added");
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Result(Code.ERROR.value(), e.getMessage());
		}
	}
	
	@RequestMapping(value = "/api/paper/student/delete")
	public Result studentDelete(Long paperId, Long studentId) {
		try {
			PaperEntity paper = paperService.findOne(paperId);
			StudentEntity student = studentService.findOne(studentId);
			paper.getStudents().remove(student);
			paperService.save(paper);
			return new Result(Code.SUCCESS.value(), "deleted");
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Result(Code.ERROR.value(), e.getMessage());
		}
	}
	
	@RequestMapping(value = "/api/paper/student/batchDelete")
	public Result studentBatchDelete(Long paperId, @RequestParam("studentIdList[]") List<Long> studentIdList) {
		try {
			PaperEntity paper = paperService.findOne(paperId);
			for (Long studentId: studentIdList) {
				StudentEntity student = studentService.findOne(studentId);
				paper.getStudents().remove(student);
			}
			paperService.save(paper);
			return new Result(Code.SUCCESS.value(), "deleted");
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Result(Code.ERROR.value(), e.getMessage());
		}
	}
}
