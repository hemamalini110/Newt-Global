package quiz;
import java.util.*;

public class Service 
{
	
	Scanner sc=new Scanner(System.in);
	Questions questions[]= new Questions[5];
	
	String answers[]=new String[5];
	
	public Service()
	{
		String q1Opts[]= {"Object","Array","Constructor","System"};
		questions[0] = new Questions(1,"What is instance of the class ? ",q1Opts,"Object"); 
		
		String q2Opts[]= {"int","string","char","String"};
		questions[1] = new Questions(1,"Which data type is used to create a variable that should store text?",q2Opts,"String"); 
		
		String q3Opts[]= {"len()","length()","getSize()","getLength()"};
		questions[2] = new Questions(1,"Which method can be used to find the length of a string?",q3Opts,"length()");
		
		String q4Opts[]= {"val = 5;","float val=10;","int val=5;","num val=5;"};
		questions[3] = new Questions(1,"How do you create a variable with the numeric value 5?",q4Opts,"int val=5;"); 
		
		String q5Opts[]= {"=","<=","==","!="};
		questions[4] = new Questions(1,"Which operator can be used to compare two values?",q5Opts,"=="); 
		
	}
	
	public void getQuestions()
	{
		for(int i=0;i<questions.length;i++)
		{
			System.out.println("Question "+(i+1)+" : "+ questions[i].getQuestion());
			String opts[]=questions[i].getoptions();
			char choice='A';
			for(String k : opts )
			{
				System.out.println((char)choice+") "+k);
				choice++;
			}
			System.out.println();
			System.out.println("Give your Answer....");
			answers[i]=sc.next();
			System.out.println();

		}
	}
	
	
	
	public void showResult()
	{
		int score=0;
		for(int i=0;i<answers.length;i++)
		{
			String temp=questions[i].getAnswer();
			if(answers[i].equals(temp))
			{
				score++;
			}
			
		}
		System.out.println("Your Score.... "+ score);
	}
	
	public void showWrongAnswer()
	{
		for(int i=0;i<answers.length;i++)
		{
			String temp=questions[i].getAnswer();
			if(!answers[i].equals(temp))
			{
				System.out.println("Question "+(i+1)+" : "+ questions[i].getQuestion());
				System.out.println("Answer : "+questions[i].getAnswer());
				System.out.println();
			}
			
		}
	}

}
