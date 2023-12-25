package com.h2.jpa.db;

import java.util.List;

import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

import com.h2.jpa.db.entity.Course;
import com.h2.jpa.db.entity.Rating;
import com.h2.jpa.db.entity.Student;
import com.h2.jpa.db.repo.CourseRepo;
import com.h2.jpa.db.repo.StudentRepo;

import ch.qos.logback.classic.Logger;

@SpringBootApplication
public class H2JpaDbApplication implements CommandLineRunner{
	
	@Autowired
	private CourseRepo repo;
	
//	@Autowired
//	private StudentRepo studRepo;
//	
//	@Autowired
//	private PassportRepo passRepo;
//	
//	@Autowired
//	private RatingRepo rateRepo;
	
	public org.slf4j.Logger logger = LoggerFactory.getLogger(this.getClass());

	public static void main(String[] args) {
		SpringApplication.run(H2JpaDbApplication.class, args);
	}

	@Override
	public void run(String... args) throws Exception 
	{
		/*Course course =repo.findById(1001);
		logger.info("User 1001 -> {}",course);
		
		repo.deleteById(1005);
		logger.info("1005 Deleted");
		
		repo.ManageEM();
		
		 *List<Course> course=repo.selectAllCourses();
		logger.info("Select all users -> {}",course);    
		
		studRepo.selectAllStudent();
		
		passRepo.selectAllPassport();
		
		rateRepo.selectAllRatings();
		
		studRepo.savewithpassport(); 
		
		repo.upsert(new Course("SpringBoot"));
		repo.upsert(new Course("JPA"));
		
		
		
		studRepo.saveStudentwithPassport();
		
		studRepo.passportDetailsofstudent(2001);
		
		studRepo.StudentDetailsofPassport(3001);
		
		repo.getratingofCourse(1001);
		
		repo.addratingtoCourse(1004,new Rating("4","Awesomeeee")); 
		
		repo.addratingtoCourse(1003,new Rating("4","Good One")); 
		
		studRepo.getStudentandCourse(2001);
		
		studRepo.insertStudentandCourse(new Student("Jack"), new Course("MVC")); */
		
	//	repo.critical_q();
		
		
	}

}
