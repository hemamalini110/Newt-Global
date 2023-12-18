package com.rest.mysql.app.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Service;

import com.rest.mysql.app.entity.Courses;

import com.rest.mysql.app.repo.CourseRepo;

@Service
public class CourseService 
{
	@Autowired
	private CourseRepo courseRepo;
	
	
	public Courses addcourse(Courses courses)
	{
		
		return courseRepo.save(courses);
	}
	
	public List<Courses> getallCourses()
	{
		return courseRepo.findAll();
		
	}
	
	public Courses getcourseById(int id)
	{
		return courseRepo.findById(id).orElse(null);
		
	}

	public Courses updateCourse(Courses courses)
	{
		Courses updateCourses = courseRepo.findById(courses.getCourse_id()).orElse(null);
		if(updateCourses!=null)
		{
			updateCourses.setCourse_name(courses.getCourse_name());
			updateCourses.setPrice(courses.getPrice());
			courseRepo.save(updateCourses);
			return updateCourses;
		}
		return null;
		
	}
	
	public Courses deleteCourses(int id)
	{
		Courses course=courseRepo.findById(id).orElse(null);
		if(course!=null)
		{
			courseRepo.deleteById(id);
		}
		
		return null;
		
	}
	

	
}
