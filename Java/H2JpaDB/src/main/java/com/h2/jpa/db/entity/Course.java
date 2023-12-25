package com.h2.jpa.db.entity;

import java.util.ArrayList;
import java.util.List;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Id;
import jakarta.persistence.ManyToMany;
import jakarta.persistence.NamedQuery;
import jakarta.persistence.OneToMany;

@Entity
@NamedQuery(name="selectAllCourse", query = "Select c from Course c")
public class Course {
	@Id
	@GeneratedValue
	private int id;
	
	private String name;
	
	@OneToMany(mappedBy = "course")
	private List<Rating> rating =new ArrayList();
	
	@ManyToMany(mappedBy = "courses")
	private List<Student> students = new ArrayList();
	
	public List<Rating> getRating()
	{
		return rating;
		
	}
	public void removeRating(Rating rating) {
		this.rating.remove(rating);
	}

	public void addRating(Rating rating) {
		this.rating.add(rating);
	}

	
	public List<Student> getStudents() {
		return students;
	}
	public void addStudents(Student students) {
		this.students.add(students);
	}
	
	public Course() {}
	
	public Course(String name) {
		super();
		this.name=name;
	}
	
	public Course(int id,String name) {
		super();
		this.id=id;
		this.name=name;
	}
	
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	};
	
	public int getId() {
		return id;
	}

	@Override
	public String toString() 
	{
		return "Course [id=" + id + ", name=" + name + "]";
	}
	
}
