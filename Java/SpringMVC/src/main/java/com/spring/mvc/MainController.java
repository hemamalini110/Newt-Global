package com.spring.mvc;

import java.util.Arrays;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.spring.mvc.repo.StudentRepo;

import ch.qos.logback.core.model.Model;


@Controller
public class MainController {
	
	@Autowired
	StudentRepo repo;
	
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
	
	@PostMapping("addstudent")   
	public String addstudent(@ModelAttribute Student student)  // just (Student student) and change in result.jsp also
	{
		repo.save(student);
		return "result";
	}
	
	@SuppressWarnings("deprecation")
	@GetMapping("getstudent")
	public String getstudent(@RequestParam int id,ModelMap m )
	{
		
		m.addAttribute("student",repo.getOne(id));
		return "result";
	}
	
	// Using Query DSL because name is not a primary key
	@GetMapping("getstudentByname")
	public String getstudent(@RequestParam String name,ModelMap m )
	{
		
		//m.addAttribute("student",repo.findByName(name));
		m.addAttribute("student",repo.find(name));

		return "result";
	}
	
	@GetMapping("getstudents")
	public String getstudents(ModelMap m)
	{
		m.addAttribute("student",repo.findAll());
		return "result";
	}
}
