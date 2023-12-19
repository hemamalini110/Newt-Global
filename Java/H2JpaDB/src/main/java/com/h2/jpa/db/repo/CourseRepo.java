package com.h2.jpa.db.repo;

import java.util.List;

import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.h2.jpa.db.entity.Course;

import jakarta.persistence.EntityManager;
import jakarta.persistence.Query;
import jakarta.persistence.TypedQuery;
import jakarta.transaction.Transactional;

@Repository
@Transactional
public class CourseRepo 
{
	@Autowired
	EntityManager em;
	
	public org.slf4j.Logger logger = LoggerFactory.getLogger(this.getClass());

	
	public Course findById(int id)
	{
		return em.find(Course.class, id);
			
	}
	
	public Course upsert(Course course)
	{
		if(course.getId() == 0)
		{
			em.persist(course);
		}
		else
		{
			em.merge(course);
		}
		return course;
	}
	
	public void deleteById(int id)
	{
		Course course=findById(id);
		em.remove(course);
	}
	
	public void ManageEM()
	{
		
/*		Course update = new Course(1006,"Spring Boot");
		em.persist(update);
		
		em.flush();
		
		Course insert =new Course(1007,"MySQL");
		em.persist(insert);
		
		em.flush();  //to sync the db
		
		em.detach(insert);  // unsync from the db
		
		em.clear();  //unsync all the ems
		
		insert.setName("PostgreSQL - Updated");
		
		em.flush(); */
		
		//JPQL java persistence query language
		
		TypedQuery<Course> query = em.createQuery("Select c from Course c",Course.class);
		List<Course> result=query.getResultList();
		logger.info("All Courses using createQ -> {}",result);
		
		// Native Query
		
		Query filter_query = em.createNativeQuery("Select * from Course where id=?  ",Course.class);
		filter_query.setParameter(1, 1001);
		List<Course> filter_result=filter_query.getResultList();
		logger.info("Filter 1001 using nativeQ as parameter number  -> {}",filter_result);
	
		// Native Query with named parameter 
		
		Query filter_query1 = em.createNativeQuery("Select * from Course where id = :id ",Course.class);
		filter_query1.setParameter("id",1002);
		List<Course> filter_result1=filter_query1.getResultList();
		logger.info("Filter 1002 using nativeQ as parameter name -> {}",filter_result1);
	}

}
