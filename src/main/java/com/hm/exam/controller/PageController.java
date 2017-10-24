package com.hm.exam.controller;

import java.util.Calendar;
import java.util.Date;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.hm.exam.entity.exam.PaperEntity;
import com.hm.exam.entity.exam.PaperEntity.PaperStatus;
import com.hm.exam.service.exam.PaperService;

@Controller
public class PageController {
	
	static Logger log = LoggerFactory.getLogger(PageController.class);
	
	@Autowired
	PaperService paperService;
	
	public class TipsType {
		public static final int TIPS_UNABLE = 1;
		public static final int TIPS_START = 2;
		public static final int TIPS_END = 3;
		public static final int TIPS_LOGIN = 4;
	}
	
	@RequestMapping(value = "/online/{paperId}")
	String doexam(ModelMap modelMap, @PathVariable Long paperId) {
		PaperEntity paper = paperService.findOne(paperId);
		 
		// 判断试卷是否存在
		if (paper == null) {
			return "pages/404";
		}
		
		modelMap.addAttribute("paper", paper);
		
		// 试卷不可用
		if (paper.getStatus() == PaperStatus.STATUS_UNABLE) {
			modelMap.addAttribute("tipsType", TipsType.TIPS_UNABLE);
			return "pages/online/online_tips";
		}
		
		// 判断当前时间是否在试卷考试时间范围内
		Calendar now = Calendar.getInstance();
		now.setTime(new Date());
		Calendar start = Calendar.getInstance();
		start.setTime(paper.getStartTime());
		Calendar end = Calendar.getInstance();
		end.setTime(paper.getEndTime());
		if (now.before(start)) {
			modelMap.addAttribute("tipsType", TipsType.TIPS_START);
			return "pages/online/online_tips";
		}
		if (now.after(end)) {
			modelMap.addAttribute("tipsType", TipsType.TIPS_END);
			return "pages/online/online_tips";
		}
		
		// 判断是否登录
		modelMap.addAttribute("tipsType", TipsType.TIPS_LOGIN);
		return "pages/online/online_tips";
		
		//modelMap.addAttribute("paper", paper);
		//return "pages/online/online_exam";
	}
	
}
