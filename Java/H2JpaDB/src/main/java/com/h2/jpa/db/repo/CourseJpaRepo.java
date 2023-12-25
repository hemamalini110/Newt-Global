package com.h2.jpa.db.repo;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.h2.jpa.db.entity.Course;

public interface CourseJpaRepo extends JpaRepository<Course, Integer> 
{

}
