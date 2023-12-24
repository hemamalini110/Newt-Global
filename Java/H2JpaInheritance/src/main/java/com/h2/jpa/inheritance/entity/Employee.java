package com.h2.jpa.inheritance.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Id;
import jakarta.persistence.Inheritance;
import jakarta.persistence.InheritanceType;
import jakarta.persistence.MappedSuperclass;

//Employee is not an entity no table created it just superclass from all the subclass retrive only from subclass
@MappedSuperclass    
//@Entity
//@Inheritance(strategy =InheritanceType.JOINED)  
public abstract class Employee 
{
	@Id
	@GeneratedValue
	private int id;
	
	public String name;
	

	public Employee(String name) {
		super();
		this.name = name;
	}
	
	public Employee() {}
	

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	public int getId()
	{
		return id;
	}

	@Override
	public String toString() {
		return "Employee [id=" + id + ", name=" + name + "]";
	}

	
	

}
