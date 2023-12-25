package com.h2.jpa.db.repo;

import java.util.List;

import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.h2.jpa.db.entity.Course;
import com.h2.jpa.db.entity.Rating;
import com.h2.jpa.db.entity.Student;

import jakarta.persistence.EntityManager;
import jakarta.persistence.Query;
import jakarta.persistence.TypedQuery;
import jakarta.persistence.criteria.CriteriaBuilder;
import jakarta.persistence.criteria.CriteriaQuery;
import jakarta.persistence.criteria.Join;
import jakarta.persistence.criteria.JoinType;
import jakarta.persistence.criteria.Predicate;
import jakarta.persistence.criteria.Root;
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
	
	//JPQL java persistence query language
	public List<Course> selectAllCourses()
	{
		Query query = em.createNamedQuery("selectAllCourse");
		List<Course> result=query.getResultList();
		logger.info("All Courses using createQ -> {}",result);
		return result;
	}
	
	public void getratingofCourse(int id)
	{
		Course course=em.find(Course.class, id);
		logger.info("Review of {} -> {}",id,course.getRating());
		
	}
	public void addratingtoCourse(int id,Rating rating)
	{
		//get course
		Course course=em.find(Course.class, id);
		logger.info("Review of {} -> {}",id,course.getRating());
		
		//add review to that course
		course.addRating(rating);
		rating.setCourse(course);
		
		//save to db
		em.persist(rating);
		
	}
	
	public void ManageEM()
	{
		
		Course update = new Course("Spring Boot");
		em.persist(update);
		
		em.flush();
		
		Course insert =new Course("MySQL");
		em.persist(insert);
		
		em.flush();  //to sync the db
		
		em.detach(insert);  // unsync from the db
		
		em.clear();  //unsync all the ems
		
		insert.setName("PostgreSQL - Updated");
		
		em.flush(); 
		
		
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
   
    
	/* public void critical_q()
	    {
		//Criteria Query
			
			CriteriaBuilder cb = em.getCriteriaBuilder();
			
			CriteriaQuery<Course> cq=cb.createQuery(Course.class);
			
			Root<Course> courseRoot=cq.from(Course.class);
			
			Join<Object, Object> join = courseRoot.join("student",JoinType.LEFT);
			
			//no need for join Predicate pre=cb.like(courseRoot.get("name"), "J%");
			
			//cq.where(pre);
			
		    TypedQuery<Course> critical_query = em.createQuery(cq.select(courseRoot));
			
			List<Course> critical_Query_result=critical_query.getResultList();
			logger.info("Critical Query 1 -> {}",critical_Query_result);
			logger.info("Critical Query to get J% -> {}",critical_Query_result);
			logger.info("Critical Query left Join {}",critical_Query_result);
		    
	    }
	    
	    */

	

}
