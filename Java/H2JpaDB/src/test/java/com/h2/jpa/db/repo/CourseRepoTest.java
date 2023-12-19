package com.h2.jpa.db.repo;

import static org.junit.Assert.assertNull;
import static org.junit.jupiter.api.Assertions.assertEquals;

import org.junit.jupiter.api.Test;
import org.junit.runner.RunWith;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.annotation.DirtiesContext;
import org.springframework.test.context.junit4.SpringRunner;

import com.h2.jpa.db.H2JpaDbApplication;
import com.h2.jpa.db.entity.Course;

@RunWith(SpringRunner.class)
@SpringBootTest(classes=H2JpaDbApplication.class)
class CourseRepoTest {
	
	public org.slf4j.Logger logger= LoggerFactory.getLogger(this.getClass());
	
	@Autowired
	CourseRepo repo;

	@Test
	void test_findById() {
		Course course =repo.findById(1001);
		assertEquals("AI", course.getName());
		
	}
	@Test
	@DirtiesContext
	void test_deleteById() {
		repo.deleteById(1001);;
		assertNull(repo.findById(1001));
		
	}
	
	@Test
	@DirtiesContext
	void test_upsert() {
		Course course =repo.findById(1001);
		assertEquals("AI", course.getName());
		
		course.setName("AI Learning");
		repo.upsert(course);
		
		Course course1 = repo.findById(1001);
		assertEquals("AI Learning", course1.getName());
		
	}
	
	

}
