package com.quiz.app.questions.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.quiz.app.questions.repo.questionRepo;
import com.quiz.app.quiz.question;

@Service
public class questionService 
{
	@Autowired
	questionRepo questionrepo;

	public ResponseEntity<List<question>> getquestions() 
	{
		try
		{
			return new ResponseEntity<>(questionrepo.findAll(),HttpStatus.BAD_REQUEST);
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
		return new ResponseEntity<>(new ArrayList<>(),HttpStatus.OK);

	}

	public ResponseEntity<List<question>> getquestionByCategory(String category)
	{
		
		try
		{
			return new ResponseEntity<>(questionrepo.findByCategory(category), HttpStatus.OK) ;	
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
		return new ResponseEntity<>(new ArrayList<>(),HttpStatus.BAD_REQUEST);
		
	}

	public ResponseEntity<String> addquestion(question ques)
	{
		try
		{
			questionrepo.save(ques);
			return new ResponseEntity<>("Success",HttpStatus.CREATED);
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
		return new ResponseEntity<>("Not Added",HttpStatus.BAD_REQUEST);
		
	}

}
