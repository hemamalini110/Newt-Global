package com.h2.jpa.db.repo;

import java.util.List;

import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.h2.jpa.db.entity.Course;
import com.h2.jpa.db.entity.Passport;
import com.h2.jpa.db.entity.Student;

import jakarta.persistence.EntityManager;
import jakarta.persistence.Query;
import jakarta.transaction.Transactional;

@Repository
@Transactional
public class StudentRepo 
{
	@Autowired
	EntityManager em;
	
	public org.slf4j.Logger logger = LoggerFactory.getLogger(this.getClass());

	
	public Student findById(int id)
	{
		return em.find(Student.class, id);
			
	}
	
	public Student upsert(Student student)
	{
		if(student.getId() == 0)
		{
			em.persist(student);
		}
		else
		{
			em.merge(student);
		}
		return student;
	}
	
	public void deleteById(int id)
	{
		Student student=findById(id);
		em.remove(student);
	}
	
	public void saveStudentwithPassport()
	{
		Passport passport =new Passport("P682");
		em.persist(passport);
		
		Student student1=new Student("Jack");
		student1.setPassport(passport);
		em.persist(student1);
		
	}
	
	public void passportDetailsofstudent(int id)
	{
		Student student=em.find(Student.class, id);    //persistence context (student) manage entity and give access to db
		logger.info("Student details -> {}",student);  
		logger.info("Passport details -> {}",student.getPassport());  //persistence context (student,passport)
		
	}
	public void StudentDetailsofPassport(int id)
	{
		Passport passport=em.find(Passport.class, id);    //persistence context (student) manage entity and give access to db
		logger.info("Passport details -> {}",passport);  
		logger.info("Student details -> {}",passport.getStudent());  //persistence context (student,passport)
		
	}
	
	public void getStudentandCourse(int id)
	{
		Student student = em.find(Student.class, id);
		logger.info("Student {} Course {}",student,student.getCourses());
	}
	
	public void insertStudentandCourse(Student student,Course course)
	{
		student.addCourses(course);
		course.addStudents(student);
		
		em.persist(course);
		em.persist(student);
	}
	
	//JPQL java persistence query language
	public List<Student> selectAllStudents()
	{
		Query query = em.createNamedQuery("selectAllStudent");
		List<Student> result=query.getResultList();
		logger.info("All Students using createQ -> {}",result);
		return result;
	}
	
	/*public void ManageEM()
	{
		
		Student update = new Student(1006,"Spring Boot");
		em.persist(update);
		
		em.flush();
		
		Student insert =new Student(1007,"MySQL");
		em.persist(insert);
		
		em.flush();  //to sync the db
		
		em.detach(insert);  // unsync from the db
		
		em.clear();  //unsync all the ems
		
		insert.setName("PostgreSQL - Updated");
		
		em.flush(); 
		
		
		// Native Query
		
		Query filter_query = em.createNativeQuery("Select * from Student where id=?  ",Student.class);
		filter_query.setParameter(1, 1001);
		List<Student> filter_result=filter_query.getResultList();
		logger.info("Filter 1001 using nativeQ as parameter number  -> {}",filter_result);
	
		// Native Query with named parameter 
		
		Query filter_query1 = em.createNativeQuery("Select * from Student where id = :id ",Student.class);
		filter_query1.setParameter("id",1002);
		List<Student> filter_result1=filter_query1.getResultList();
		logger.info("Filter 1002 using nativeQ as parameter name -> {}",filter_result1);
	}*/

	

}
