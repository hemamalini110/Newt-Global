package com.h2.jpa.inheritance.repo;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.h2.jpa.inheritance.entity.Employee;

import jakarta.persistence.EntityManager;
import jakarta.transaction.Transactional;

@Repository
@Transactional
public class EmployeeRepo 
{

	@Autowired
	EntityManager em;
	
	public Employee findById(int id)
	{
		Employee employee = em.find(Employee.class, id);
		return employee;
	}
	
	public void insert(Employee employee)
	{
		em.persist(employee);
	}
	
	public List<Employee> allemployees()  // union is used to retrive in table per class
	{
		return em.createQuery("Select e from Employee e",Employee.class).getResultList();
	}
}
