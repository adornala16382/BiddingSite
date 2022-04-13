<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Profile</title>
	<link href="styles.css" rel="stylesheet">
</head>
<body>
	<% 	
	    if(session.getAttribute("username")!=null){  
	        String username=(String)session.getAttribute("username");
	        out.print("<h5>Username: "+username+"</h5>"); 
	    }
	    else{  
        	out.print("<a href=\"Login.jsp\">Sign In</a>");
        	//out.print("<form method=\"post\" action=\"	Login.jsp\"><input type=\"submit\" value=\"Sign In\" /></form>");  
        }  
        out.close();  
	%>
</body>
</html>