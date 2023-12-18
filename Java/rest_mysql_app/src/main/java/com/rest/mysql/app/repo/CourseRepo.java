package com.rest.mysql.app.repo;

import org.springframework.data.jpa.repository.JpaRepository;

import com.rest.mysql.app.entity.Courses;

public interface CourseRepo extends JpaRepository<Courses, Integer>
{

}
