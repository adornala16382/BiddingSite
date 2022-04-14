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
					%>
		        	<a href="LogoutLogic.jsp">Sign Out</a>
					<a href="Profile.jsp">Profile</a>
		        <%}  
		        else{  
		        	out.print("<a href=\"Login.jsp\">Sign In</a>");
		        }  
		        out.close();  
			%>
		</div>
	</div>
</head>
<body>
</body>
</html>