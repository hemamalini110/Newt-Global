package com.h2.jpa.inheritance;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

import com.h2.jpa.inheritance.entity.FullTimeEmployee;
import com.h2.jpa.inheritance.entity.PartTimeEmployee;
import com.h2.jpa.inheritance.repo.EmployeeRepo;

@SpringBootApplication
public class H2JpaInheritanceApplication implements CommandLineRunner {

	
	@Autowired
	EmployeeRepo empRepo;
	
	public static void main(String[] args) {
		SpringApplication.run(H2JpaInheritanceApplication.class, args);
	}

	@Override
	public void run(String... args) throws Exception {
		// TODO Auto-generated method stub
		
		empRepo.insert(new FullTimeEmployee("Jack",10000));
		empRepo.insert(new PartTimeEmployee("Jill",200));
		
	}

	
}
