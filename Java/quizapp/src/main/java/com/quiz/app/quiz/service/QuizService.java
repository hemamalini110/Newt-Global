package com.quiz.app.quiz.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.quiz.app.questions.repo.questionRepo;
import com.quiz.app.quiz.QuestionWrapper;
import com.quiz.app.quiz.Quiz;
import com.quiz.app.quiz.Response;
import com.quiz.app.quiz.question;
import com.quiz.app.quiz.repo.QuizRepo;

@Service
public class QuizService 
{

	@Autowired
	QuizRepo quizRepo;
	
	@Autowired
	questionRepo quesRepo;
	
	public ResponseEntity<String> createQuiz(String category, int noOfQ, String quizTitle) {
		
		List<question> questions = quesRepo.findRandomQuestionByCategory(category,noOfQ);
		Quiz quiz=new Quiz();
		quiz.setTitle(quizTitle);
		quiz.setQuestions(questions);
		quizRepo.save(quiz);
		return new ResponseEntity<>("Success",HttpStatus.OK);
	}

	

	public ResponseEntity<List<QuestionWrapper>> getQuizQuestion(Integer id) 
	{
		Optional<Quiz> quiz=quizRepo.findById(id);
		List<question> questfromDB= quiz.get().getQuestions();
		List<QuestionWrapper> questtoUser = new ArrayList();
		for(question q: questfromDB)
		{
			QuestionWrapper qw=new QuestionWrapper(q.getId(),q.getQuestion_title(),q.getOption1(),q.getOption2(),q.getOption3(),q.getOption4());
			questtoUser.add(qw);
		}
		return new ResponseEntity<>(questtoUser,HttpStatus.OK);
	}



	@SuppressWarnings("unlikely-arg-type")
	public ResponseEntity<Integer> calculateResult(Integer id, List<Response> responses) 
	{
		Quiz quiz= quizRepo.findById(id).get();
		List<question> questions=quiz.getQuestions();
		
		int right=0;
		int i=0;
		for(Response response : responses)
		{
			
			if(response.getResponse().equals(questions.get(i).getRight_answer()))
				right++;
			i++;
		}
				
		return new ResponseEntity<>(right,HttpStatus.OK);
	}

	
}
