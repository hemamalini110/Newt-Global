package com.quiz.app.questions.controller;

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

import com.quiz.app.questions.service.questionService;
import com.quiz.app.quiz.question;

@RestController
@RequestMapping("question")
public class questionController 
{
	@Autowired
	questionService questionservice;
	
	@GetMapping("allquestions")
	public ResponseEntity<List<question>> getquestions()
	{
		return questionservice.getquestions();
	}
	
	@GetMapping("category/{category}")
	public ResponseEntity<List<question>> getquestionByCategory(@PathVariable String category)
	{
		return questionservice.getquestionByCategory(category);
	}
	
	@PostMapping("add")
	public ResponseEntity<String> addquestion(@RequestBody question ques)
	{
		return questionservice.addquestion(ques);
	}
}
