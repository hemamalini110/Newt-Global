package quiz;
import java.util.*;

public class Main
{
	public static void main(String args[])
	{
		Scanner sc=new Scanner(System.in);
		Service service = new Service();
		
		System.out.println("Are you ready to start the quizzzzz... Y or N");
		char choice=sc.next().charAt(0);
		if(choice=='Y')
		{
		    System.out.println("Lets get started :) ");
		    System.out.println();
			service.getQuestions();
			
			service.showResult();
			System.out.println("This is the time to correct the mistakes... ");
		    System.out.println();
			service.showWrongAnswer();
			

		}
		else
		{
			System.out.println("Quit :(");
		}
		
	}
}
