package com.spring.mvc;

import java.util.Arrays;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelExtensionsKt;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import ch.qos.logback.core.model.Model;



@Controller
public class MainController {
	

	@RequestMapping("/")
	public String home()
	{
		return "index";
	}
	
	@RequestMapping("add")
	public ModelAndView add(@RequestParam("n1") int n1, @RequestParam("n2") int n2)
	{
		ModelAndView mv = new ModelAndView();
		mv.setViewName("result");
		
		int add=n1+n2;
		mv.addObject("add", add);
		
		return mv;
	}
	
	@PostMapping(value="addstudent")   
	public String addstudent(@ModelAttribute("s") Student student)  // just (Student student) and change in result.jsp also
	{
		return "result";
	}
	
	@GetMapping("getstudents")
	public String getstudents(ModelMap m)
	{
		List<Student> students= Arrays.asList(new Student(101,"Hema"), new Student(102, "Dev"));
		m.addAttribute("students",students);
		return "result";
	}
}
