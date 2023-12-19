package com.h2.jpa.db;

import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

import com.h2.jpa.db.entity.Course;
import com.h2.jpa.db.repo.CourseRepo;

import ch.qos.logback.classic.Logger;

@SpringBootApplication
public class H2JpaDbApplication implements CommandLineRunner{
	
	@Autowired
	private CourseRepo repo;
	
	public org.slf4j.Logger logger = LoggerFactory.getLogger(this.getClass());

	public static void main(String[] args) {
		SpringApplication.run(H2JpaDbApplication.class, args);
	}

	@Override
	public void run(String... args) throws Exception 
	{
//		Course course =repo.findById(1001);
//		logger.info("User 1001 -> {}",course);
//		
//		repo.deleteById(1005);
//		logger.info("1005 Deleted");
		
		repo.ManageEM();
		
		
	}

}
