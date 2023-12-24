package com.h2.jpa.inheritance.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Id;

@Entity
public class PartTimeEmployee extends Employee 
{
	
	private int hourlyWage;
	
	public PartTimeEmployee(String name, int hourlyWage) {
		super(name);
		this.hourlyWage = hourlyWage;
	}


	public PartTimeEmployee() {}
	
	

}
