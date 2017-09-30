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
public class BaseController {
	
	static Logger log = LoggerFactory.getLogger(BaseController.class);
	
	@Autowired
	PaperService paperService;
	
	@RequestMapping(value = { "/", "/login" })
	String index(ModelMap modelMap) {
		return "login";
	}
	
	@RequestMapping(value = "/home")
	String home() {
		return "home";
	}
	
	@RequestMapping(value = "/init")
	String init() {
		return "init";
	}
	
	@RequestMapping(value = "/video")
	String video() {
		return "pages/video";
	}
	
	@RequestMapping(value = "/online/{paperId}")
	String doexam(ModelMap modelMap, @PathVariable Long paperId) {
		PaperEntity paper = paperService.findOne(paperId);
		modelMap.addAttribute("paper", paper);
		return "pages/online/online_exam";
	}
	
}
