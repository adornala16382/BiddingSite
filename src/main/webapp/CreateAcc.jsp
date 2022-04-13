<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Create Account</title>
	<link href="styles.css" rel="stylesheet">
</head>
<body>

    <h1>Create New Account</h1>
    <form method="post" action="createAccLogic.jsp">
	    <label >Username:</label> <br>
	    <input type="text" id="username" name="username"><br>
	    <label >Password</label><br>
	    <input type="text" id="password" name="password"> <br>
	    <label >Confirm Password</label><br>
	    <input type="text" id="confirm password" name="confirm password"> <br>
	    <input type="submit" value="Create Account" />
    </form>
</body>
</html>