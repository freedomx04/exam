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
import com.hm.exam.entity.exam.ClassifyEntity;
import com.hm.exam.entity.exam.PaperEntity;
import com.hm.exam.service.exam.ClassifyService;
import com.hm.exam.service.exam.PaperService;

@RestController
public class PaperController {

	static Logger log = LoggerFactory.getLogger(PaperController.class);

	@Autowired
	PaperService paperService;

	@Autowired
	ClassifyService classifyService;

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
	public Result update(Long paper) {
		try {
			return new Result(Code.SUCCESS.value(), "updated");
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Result(Code.ERROR.value(), e.getMessage());
		}
	}

	@RequestMapping(value = "/api/paper/delete")
	public Result delete(Long paperId) {
		try {
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
			return new ResultInfo(Code.SUCCESS.value(), "ok", "");
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
	
	@RequestMapping(value = "/api/paper/listQuestion")
	public Result listQuestion(Long paperId) {
		try {
			PaperEntity paper = paperService.findOne(paperId);
			return new ResultInfo(Code.SUCCESS.value(), "moved", paper.getQuestions());
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Result(Code.ERROR.value(), e.getMessage());
		}
	}

}
