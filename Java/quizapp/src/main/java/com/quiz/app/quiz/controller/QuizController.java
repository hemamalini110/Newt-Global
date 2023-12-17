package com.quiz.app.quiz.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.quiz.app.quiz.QuestionWrapper;
import com.quiz.app.quiz.Response;
import com.quiz.app.quiz.question;
import com.quiz.app.quiz.service.QuizService;

@RestController 
@RequestMapping("quiz")
public class QuizController 
{
	@Autowired
	QuizService quizService;
	
	@PostMapping("create")
	public ResponseEntity<String> createQuiz(@RequestParam String category, @RequestParam int NoOfQ, @RequestParam String quizTitle)
	{
		return quizService.createQuiz(category,NoOfQ,quizTitle);
	}
	
	@GetMapping("get/{id}")
	public ResponseEntity<List<QuestionWrapper>> getQuiz(@PathVariable Integer id)
	{
		return quizService.getQuizQuestion(id);
		
	}
	
	@PostMapping("submit/{id}")
	public ResponseEntity<Integer> submitQuiz(@PathVariable Integer id, @RequestBody List<Response> responses )
	{
		return quizService.calculateResult(id,responses);
		
	}
	
	
	
	
}
