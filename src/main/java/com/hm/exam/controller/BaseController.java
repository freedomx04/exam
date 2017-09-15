package com.hm.exam.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class BaseController {
	
	static Logger log = LoggerFactory.getLogger(BaseController.class);
	
	@RequestMapping(value = { "/", "/index" })
	String index(ModelMap modelMap) {
		return "index";
	}
	
	@RequestMapping(value = "/home")
	String home() {
		return "home";
	}
	
}
