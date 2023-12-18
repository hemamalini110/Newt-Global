package com.rest.mysql.app.aspect;

import java.util.logging.Logger;

import org.aspectj.lang.annotation.AfterReturning;
import org.aspectj.lang.annotation.AfterThrowing;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

@Aspect
@Component
public class LoggingAspect 
{
	private static final org.slf4j.Logger LOGGER = LoggerFactory.getLogger("LoggingAspect.class");
	
	@Before("execution(public * com.rest.mysql.app.controller.CourseController.getallCourses())")
	public void beforelog()
	{
		LOGGER.info("getstudents method is called");
	}
	
	@AfterReturning("execution(public * com.rest.mysql.app.controller.CourseController.getallCourses())")
	public void afterreturn()
	{
		LOGGER.info("getstudents method is executed and retured");
	}
	
	@AfterThrowing("execution(public * com.rest.mysql.app.controller.CourseController.getallCourses())")
	public void issue()
	{
		LOGGER.info("getstudents method is issue");
	}
	
    //@After() it act as finally block in EH , irrespective of the error

}
