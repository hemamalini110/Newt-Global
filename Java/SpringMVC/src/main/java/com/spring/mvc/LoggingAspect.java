package com.spring.mvc;

import org.aspectj.lang.annotation.AfterReturning;
import org.aspectj.lang.annotation.AfterThrowing;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

@Aspect
@Component
public class LoggingAspect 
{
	private static final Logger  LOGGER = LoggerFactory.getLogger(LoggingAspect.class);
	

    @Before("execution(public * com.spring.mvc.MainController.getstudents())")
	public void logBefore()
	{
    	LOGGER.info("getstudents method called from Aspect");
		
	}
    
    //@After() it act as finally block in EH , irrespective of the error
    
    @AfterReturning("execution (public * com.spring.mvc.MainController.getstudents())")
    public void logAfter()
    {
    	LOGGER.info("getstudents method is excecuted and return");
    }
    
    @AfterThrowing("execution (public * com.spring.mvc.MainController.getstudents())")
    public void logDuring()
    {
    	LOGGER.info("getstudents method is excecuted and return");
    }
}
