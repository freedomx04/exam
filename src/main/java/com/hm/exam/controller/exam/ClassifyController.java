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
public class ClassifyController {

	static Logger log = LoggerFactory.getLogger(ClassifyController.class);

	@Autowired
	ClassifyService classifyService;
	
	@Autowired
	PaperService paperService;

	@RequestMapping(value = "/api/classify/create", method = RequestMethod.POST)
	public Result create(String name) {
		try {
			ClassifyEntity classify = classifyService.findByName(name);
			if (classify != null) {
				return new Result(Code.EXISTED.value(), "试题分类已存在");
			}

			Date now = new Date();
			classify = new ClassifyEntity(name, now, now);
			classifyService.save(classify);
			return new Result(Code.SUCCESS.value(), "created");
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Result(Code.ERROR.value(), e.getMessage());
		}
	}

	@RequestMapping(value = "/api/classify/update", method = RequestMethod.POST)
	public Result update(Long classifyId, String name) {
		try {
			ClassifyEntity classify = classifyService.findOne(classifyId);

			ClassifyEntity updateClassify = classifyService.findByName(name);
			if (updateClassify == null || classify.getId() == updateClassify.getId()) {
				classify.setName(name);
				classify.setUpdateTime(new Date());
				classifyService.save(classify);
				return new Result(Code.SUCCESS.value(), "updated");
			} else {
				return new Result(Code.EXISTED.value(), "试题分类已存在");
			}
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Result(Code.ERROR.value(), e.getMessage());
		}
	}

	@RequestMapping(value = "/api/classify/delete")
	public Result delete(Long classifyId) {
		try {
			ClassifyEntity classify = classifyService.findOne(classifyId);
			List<PaperEntity> paperList = paperService.listByClassify(classify);
			for (PaperEntity paper: paperList) {
				ClassifyEntity defaultClassify = classifyService.findByName("默认分类");
				paper.setClassify(defaultClassify);
				paperService.save(paper);
			}
			classifyService.delete(classifyId);
			return new Result(Code.SUCCESS.value(), "deleted");
		} catch (Exception e) {
			if (e.getCause().toString().indexOf("ConstraintViolationException") != -1) {
				return new Result(Code.CONSTRAINT.value(), "该数据存在关联，无法删除！");
			}
			log.error(e.getMessage(), e);
			return new Result(Code.ERROR.value(), e.getMessage());
		}
	}

	@RequestMapping(value = "/api/classify/batchDelete", method = RequestMethod.POST)
	public Result batchDelete(@RequestParam("classifyIdList[]") List<Long> classifyIdList) {
		try {
			for (Long classifyId: classifyIdList) {
				delete(classifyId);
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

	@RequestMapping(value = "/api/classify/get")
	public Result get(Long classifyId) {
		try {
			ClassifyEntity classify = classifyService.findOne(classifyId);
			return new ResultInfo(Code.SUCCESS.value(), "ok", classify);
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Result(Code.ERROR.value(), e.getMessage());
		}
	}

	@RequestMapping(value = "/api/classify/list")
	public Result list() {
		try {
			List<ClassifyEntity> list = classifyService.list();
			for (ClassifyEntity classify: list) {
				Integer count = paperService.countByClassify(classify);
				classify.setCount(count);
			}
			return new ResultInfo(Code.SUCCESS.value(), "ok", list);
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Result(Code.ERROR.value(), e.getMessage());
		}
	}

}
