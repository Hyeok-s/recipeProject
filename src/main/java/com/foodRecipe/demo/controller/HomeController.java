package com.foodRecipe.demo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class HomeController {

	
	@GetMapping("/usr/home/main")
	@ResponseBody
	public String showMain() {
		return "안녕12";
	}
}
