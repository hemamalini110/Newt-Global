<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Title</title>
</head>
<body>
	<h1>Home page</h1>
	<!-- 
	<form action="add">
		<label>Enter first number:</label> <input type="text" name="n1">
	    <label>Enter second number:</label> <input type="text" name="n2">
		<input type=submit name="add">
	</form>    
	 --> 
	 
	 <form action="addstudent" method="post">
	 	<label>Enter student id:</label> <input type="text" name="id">
	    <label>Enter student name:</label> <input type="text" name="name">
	    <input type=submit name="submit">
	 </form>
	 
	 <form action="getstudent" method="get">
	 	<label>Enter student id:</label> <input type="text" name="id">
	    <input type=submit name="submit">
	 </form>
	 
	 <form action="getstudentByname" method="get">
	 	<label>Enter student name:</label> <input type="text" name="name">
	    <input type=submit name="submit">
	 </form>
</body>
</html>