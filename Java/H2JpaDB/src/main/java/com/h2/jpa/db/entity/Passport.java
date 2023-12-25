package com.h2.jpa.db.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Id;
import jakarta.persistence.NamedQuery;
import jakarta.persistence.OneToOne;

@Entity
@NamedQuery(name="selectAllPassport", query = "Select c from Course c")
public class Passport {
	@Id
	@GeneratedValue
	private int id;
	
	private String number;
	
	//make 1-1 mapping bidirectional and owned by anyone entity here it is owned by student and mentioned in unowned entity
	@OneToOne(fetch = FetchType.LAZY, mappedBy = "passport") 
	private Student student;
	
	public Passport() {}
	
	public Passport(String number) {
		super();
		this.number = number;
	}

	
	public Student getStudent() {
		return student;
	}
 
	public void setStudent(Student student) {
		this.student = student;
	}

	public String getNumber() {
		return number;
	}

	public void setNumber(String number) {
		this.number = number;
	};
	
	public int getId() {
		return id;
	}

	@Override
	public String toString() 
	{
		return "Passport [id=" + id + ", number=" + number + "]";
	}
	
}
