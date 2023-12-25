package com.h2.jpa.db;


import java.util.List;


import org.junit.jupiter.api.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.test.context.junit4.SpringRunner;

import com.h2.jpa.db.entity.Course;
import com.h2.jpa.db.repo.CourseJpaRepo;
import com.jayway.jsonpath.internal.function.sequence.First;

@RunWith(SpringRunner.class)
@SpringBootTest(classes=H2JpaDbApplication.class)
class CourseJpaRepoTest {
	
	@Autowired
	CourseJpaRepo repo;
	
	private Logger logger=LoggerFactory.getLogger(this.getClass());

	@Test
	public void findById() {
		Course course=new Course("Excel");
		repo.save(course);
		//Sort sort=new Sort(Sort.Direction.DESC,"name").add("id");
		List<Course> list_course=repo.findAll();   //sort
		logger.info("insert Excel -> {}",list_course );
	}
	
	@Test
	public void pagging()
	{
		PageRequest pagerequest = PageRequest.of(0,2);
		Page<Course> firstpage=repo.findAll(pagerequest);
		logger.info("First page -> {}",firstpage.getContent());
		
	    Pageable secondPageable = firstpage.nextPageable();
	    Page<Course> secondpage=repo.findAll(secondPageable);
	    logger.info("Second Page -> {}",secondpage.getContent());
		
	}

}
