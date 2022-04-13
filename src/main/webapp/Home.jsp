<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Home</title>
	<link href="styles.css" rel="stylesheet">
	<div class="topnav">
		<a class="active" href="Home.jsp">Home</a>
		<div class="topnav-right">
			<% 	
		        if(session.getAttribute("username")!=null){  
					String username=(String)session.getAttribute("username");
		        	out.print("<a>Welcome "+username+"</a>"); 
		        	out.print("<a href=\"LogoutLogic.jsp\">Sign Out</a>");
					out.print("<a href=\"Profile.jsp\" class=\"dropbtn\">Profile<i class=\"fa fa-caret-down\"></i></a>");
    				out.print("<div class=\"topnav-right-content\"><a href=\"#\">Link 1</a></div>");
		        	//out.print("<form method=\"post\" action=\"LogoutLogic.jsp\"><input type=\"submit\" value=\"Sign Out\" /></form>");
		        	//out.print("<a>Profile</a>");
		        }  
		        else{  
		        	out.print("<a href=\"Login.jsp\">Sign In</a>");
		        	//out.print("<form method=\"post\" action=\"	Login.jsp\"><input type=\"submit\" value=\"Sign In\" /></form>");  
		        }  
		        out.close();  
			%>
		</div>
	</div>
</head>
<body>
</body>
</html>