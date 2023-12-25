package com.h2.jpa.db.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Id;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.NamedQuery;

@Entity
@NamedQuery(name="selectAllRating", query = "Select c from Course c")
public class Rating {
	@Id
	@GeneratedValue
	private int id;
	
	private String description;
	
	private String rating;
	
	@ManyToOne
	private Course course;
	
	public Rating() {}
	
	
	
	public Course getCourse() {
		return course;
	}

	public void setCourse(Course course) {
		this.course = course;
	}
	
	
	public Rating( String rating,String description) {
		super();
		this.description = description;
		this.rating = rating;
		
	}
	
	public Rating(String description, String rating, Course course) {
		super();
		this.description = description;
		this.rating = rating;
		this.course = course;
	}

	
	public String getRating() {
		return rating;
	}

	public void setRating(String rating) {
		this.rating = rating;
	}

	public String getNumber() {
		return description;
	}

	public void setNumber(String description) {
		this.description = description;
	};
	
	public int getId() {
		return id;
	}

	@Override
	public String toString() 
	{
		return "Rating [id=" + id + ",rating=" + rating + ", description=" + description + "]";
	}
	
}
