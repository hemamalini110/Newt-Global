package com.jdbc.postgres;
import java.sql.*;

public class Main {

	public static void main(String[] args)
	{
		String url="jdbc:postgresql://localhost:5432/student_details";
		String username="postgresql";
		String password="0000";
		
		String read_sql="select * from student";
		String create_sql="insert into student values(4,'John',10,88)";
		String update_sql="update student set student_id=104 where student_id=4";
		String delete_sql="delete from student where student_id=104";
		
		int id=104;
		String name="Jaan";
		int standard=10;
		int mark=98;
		
		String inser_psql="insert into student values(?,?,?,?)";
		
		try 
		{
			Connection connection=DriverManager.getConnection(url, username, password);
			System.out.println("Connection established");
			Statement statement=connection.createStatement();
			
			
			ResultSet rs=statement.executeQuery(read_sql);
			while(rs.next())
			{
				System.out.print(rs.getInt(1)+" ");
				System.out.print(rs.getString(2)+" ");
				System.out.print(rs.getInt(3)+" ");
				System.out.println(rs.getInt(4));
			
			}
			
			statement.execute(create_sql);
			
			statement.execute(update_sql);
			
			statement.execute(delete_sql);
			
			//preparedstatement
			
			PreparedStatement Pstatement=connection.prepareStatement(inser_psql);
			Pstatement.setInt(1,id);
			Pstatement.setString(2,name);
			Pstatement.setInt(3, standard);
			Pstatement.setInt(4, mark);
			
			Pstatement.execute();
			
			connection.close();
			
			System.out.println("Connection Closed");
			
		}
		catch (SQLException e)
		{
			e.printStackTrace();
			System.out.print("Connection not  established");
		}
	}

}
