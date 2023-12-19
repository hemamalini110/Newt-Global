package com.h2.jpa.db.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Id;

@Entity
public class Course {
	@Id
	private int id;
	
	private String name;
	
	public Course() {}
	
	public Course(String name) {
		super();
		this.name=name;
	}

	
	public Course(int id, String name) {
		super();
		this.id = id;
		this.name = name;
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
