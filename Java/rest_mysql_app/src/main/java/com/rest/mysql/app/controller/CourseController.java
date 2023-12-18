package com.rest.mysql.app.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.rest.mysql.app.entity.Courses;
import com.rest.mysql.app.repo.CourseRepo;
import com.rest.mysql.app.service.CourseService;

import jakarta.persistence.Id;

@RestController
public class CourseController
{
	@Autowired
	private CourseService courseService;
	
	
	@PostMapping("/addcourse")
	public String createCourse(@RequestBody Courses courses) 
	{
		
		courseService.addcourse(courses);
		return "Created";
	}
	
	
	@GetMapping("/getcourses")
	public List<Courses> getallCourses()
	{
		
		return courseService.getallCourses();
	}
	
	@GetMapping("/getcourseById/{id}")
	public Courses getById(@PathVariable int id)
	{
		return courseService.getcourseById(id);
	}
	
	@PutMapping("/updatecourse")
	public String updateCourses(@RequestBody Courses courses)
	{
		courseService.updateCourse(courses);
		return "Updated";
		
	}
	
	@DeleteMapping("/deletecourse/{id}")
	public String deleteCourse(@PathVariable int id)
	{
		courseService.deleteCourses(id);
		return "Deleted";
		
	}
	
	
}
