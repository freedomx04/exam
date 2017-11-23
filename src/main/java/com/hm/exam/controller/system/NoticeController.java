package com.hm.exam.controller.system;

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
import com.hm.exam.entity.authority.UserEntity;
import com.hm.exam.entity.system.NoticeEntity;
import com.hm.exam.service.authority.UserService;
import com.hm.exam.service.system.NoticeService;

@RestController
public class NoticeController {
	
	static Logger log = LoggerFactory.getLogger(NoticeController.class);
	
	@Autowired
	NoticeService noticeService;
	
	@Autowired
	UserService userService;
	
	@RequestMapping(value = "/api/notice/create", method = RequestMethod.POST)
	public Result create(String title, String content, Long userId) {
		try {
			UserEntity user = userService.findOne(userId);
			Date now = new Date();
			NoticeEntity notice = new NoticeEntity(title, content, user, now, now);
			noticeService.save(notice);
			return new Result(Code.SUCCESS.value(), "添加成功");
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Result(Code.ERROR.value(), e.getMessage());
		}
	}
	
	@RequestMapping(value = "/api/notice/update", method = RequestMethod.POST)
	public Result update(Long noticeId, String title, String content, Long userId) {
		try {
			UserEntity user = userService.findOne(userId);
			NoticeEntity notice = noticeService.findOne(noticeId);
			notice.setTitle(title);
			notice.setContent(content);
			notice.setUser(user);
			notice.setUpdateTime(new Date());
			noticeService.save(notice);
			return new Result(Code.SUCCESS.value(), "编辑成功");
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Result(Code.ERROR.value(), e.getMessage());
		}
	}
	
	@RequestMapping(value = "/api/notice/delete")
	public Result delete(Long noticeId) {
		try {
			noticeService.delete(noticeId);
			return new Result(Code.SUCCESS.value(), "删除成功");
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Result(Code.ERROR.value(), e.getMessage());
		}
	}
	
	@RequestMapping(value = "/api/notice/batchDelete", method = RequestMethod.POST)
	public Result batchDelete(@RequestParam("noticeIdList[]") List<Long> noticeIdList) {
		try {
			noticeService.delete(noticeIdList);
			return new Result(Code.SUCCESS.value(), "删除成功");
		} catch (Exception e) {
			if (e.getCause().toString().indexOf("ConstraintViolationException") != -1) {
				return new Result(Code.CONSTRAINT.value(), "该数据存在关联，无法删除！");
			}
			log.error(e.getMessage(), e);
			return new Result(Code.ERROR.value(), e.getMessage());
		}
	}
	
	@RequestMapping(value = "/api/notice/get")
	public Result get(Long noticeId) {
		try {
			NoticeEntity notice = noticeService.findOne(noticeId);
			return new ResultInfo(Code.SUCCESS.value(), "ok", notice);
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Result(Code.ERROR.value(), e.getMessage());
		}
	}
	
	@RequestMapping(value = "/api/notice/list")
	public Result list() {
		try {
			List<NoticeEntity> list = noticeService.list();
			return new ResultInfo(Code.SUCCESS.value(), "ok", list);
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Result(Code.ERROR.value(), e.getMessage());
		}
	}
	
	@RequestMapping(value = "/api/notice/top")
	public Result top(Long noticeId) {
		try {
			NoticeEntity notice = noticeService.findOne(noticeId);
			notice.setUpdateTime(new Date());
			noticeService.save(notice);
			return new Result(Code.SUCCESS.value(), "置顶成功");
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new Result(Code.ERROR.value(), e.getMessage());
		}
	}

}
