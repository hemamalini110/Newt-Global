package com.h2.jpa.inheritance.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Id;

@Entity
public class FullTimeEmployee extends Employee 
{
	
	private int salary;
	
	public FullTimeEmployee(String name, int salary) {
		super(name);
		this.salary = salary;
	}


	public FullTimeEmployee() {}
	
	

}
