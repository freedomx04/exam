package com.hm.exam.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.hm.exam.entity.exam.PaperEntity;
import com.hm.exam.service.exam.PaperService;

@Controller
public class PageController {
	
	static Logger log = LoggerFactory.getLogger(PageController.class);
	
	@Autowired
	PaperService paperService;
	
	@RequestMapping(value = "/online/{paperId}")
	String doexam(ModelMap modelMap, @PathVariable Long paperId) {
		PaperEntity paper = paperService.findOne(paperId);
		 
		// 判断试卷是否存在
		if (paper == null) {
			return "pages/404";
		}
		
		modelMap.addAttribute("paper", paper);
		return "pages/online/online_exam";
	}
	
}
