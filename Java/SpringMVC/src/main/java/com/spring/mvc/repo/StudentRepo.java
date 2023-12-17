package com.spring.mvc.repo;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.spring.mvc.Student;

public interface StudentRepo extends JpaRepository<Student, Integer>
{

	//List<Student> findByName(String name);   // Query DSL Domain Specific Language
	
	@Query("from Student where name= :studentname")
	List<Student> find(@Param("studentname") String name);
 
}
