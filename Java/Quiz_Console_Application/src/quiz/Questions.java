package quiz;

public class Questions 
{
	
	private int id;
	private String question;
	private String[] options=new String[4];
	private String answer;
	
	
	public Questions(int id, String question, String[] answers, String answer) {
		super();
		this.id = id;
		this.question = question;
		this.options = answers;
		this.answer = answer;
	}


	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getQuestion() {
		return question;
	}
	public void setQuestion(String question) {
		this.question = question;
	}
	public String[] getoptions() {
		return options;
	}
	public void setoptions(String[] options) {
		this.options = options;
	}
	public String getAnswer() {
		return answer;
	}
	public void setAnswer(String answer)
	{
		this.answer = answer;
	}
	
	
}
