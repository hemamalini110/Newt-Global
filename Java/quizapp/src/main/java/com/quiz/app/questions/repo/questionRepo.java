package com.quiz.app.questions.repo;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.quiz.app.quiz.question;

@Repository
public interface questionRepo extends JpaRepository<question, Integer>{


	List<question> findByCategory(String category);

	@Query(value= "SELECT * FROM questions q WHERE q.category=:category ORDER BY RANDOM() LIMIT :noOfQ ",nativeQuery=true)
	List<question> findRandomQuestionByCategory(String category, int noOfQ);

	
}
