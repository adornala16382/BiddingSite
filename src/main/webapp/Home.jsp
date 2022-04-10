<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Home</title>
</head>
<body>
	<% 	
        HttpSession session1=request.getSession(false); 
		String username=(String)session.getAttribute("username");
        if(username!=null){  
        	out.print("Hello, "+username+" Welcome to Home Page"); 
        	out.print("<form method=\"post\" action=\"LogoutLogic.jsp\"><input type=\"submit\" value=\"Sign Out\" /></form>");
        }  
        else{  
        	out.print("Please Sign In");
        	out.print("<form method=\"post\" action=\"Login.jsp\"><input type=\"submit\" value=\"Sign In\" /></form>");  
        }  
        out.close();  
	%>
</body>
</html>