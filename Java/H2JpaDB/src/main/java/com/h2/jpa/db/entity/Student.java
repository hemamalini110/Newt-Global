package com.h2.jpa.db.entity;

import java.util.ArrayList;
import java.util.List;

import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.JoinTable;
import jakarta.persistence.ManyToMany;
import jakarta.persistence.NamedQuery;
import jakarta.persistence.OneToOne;

@Entity
@NamedQuery(name="selectAllStudent", query = "Select c from Course c")
public class Student {
	@Id
	@GeneratedValue
	private int id;
	
	private String name;
	
	@OneToOne(fetch = FetchType.LAZY) // fetch the data without joining the table
	private Passport passport;
	
	//..- 1 default eager       ..-.. default lazy
	
	@ManyToMany
	@JoinTable(name="Student_Course",
	joinColumns = @JoinColumn(name="Student_id") ,
	inverseJoinColumns =  @JoinColumn(name="Course_id"))
	private List<Course> courses = new ArrayList<>();
	
	public Student() {}
	
	public Student(String name) {
		super();
		this.name = name;
	}
	
	

	public List<Course> getCourses() {
		return courses;
	}

	public void addCourses(Course courses) {
		this.courses.add(courses);
	}
	
	public void removeCourses(Course courses) {
		this.courses.remove(courses);
	}

	public Passport getPassport() {
		return passport;
	}

	public void setPassport(Passport passport) {
		this.passport = passport;
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
		return "Student [id=" + id + ", name=" + name + "]";
	}
	
}
