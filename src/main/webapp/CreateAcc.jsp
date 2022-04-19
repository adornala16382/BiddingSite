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
	<div class="topnav">
		<a class="logo" href="Home.jsp"><img src="BuyMeLogo.png" width = "auto" height = "35"></a>
		<div class="topnav-right">
			<% 	
			String prevURI = request.getRequestURI();
        	String prevParam = request.getQueryString();
        	String prevPath;
        	if(prevParam==null){
        		prevPath = prevURI;
        	}
        	else{
        		prevPath = prevURI+"?"+prevParam;
        	}
	        if(session.getAttribute("username")!=null){  
				String username=(String)session.getAttribute("username");
	        	out.print("<a>Welcome "+username+"</a>"); 
	        	out.print("<a href=\"LogoutLogic.jsp?prev="+prevPath+"\">Sign Out</a>");
				%>
				<a href="Profile.jsp">Profile</a>
	        <%}  
	        else{
	        	out.print("<a href=\"Login.jsp?prev="+prevPath+"\">Sign In</a>");
	        }  
			%>
		</div>
	</div>
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
      <%
      	String displayMessage1 = request.getParameter("missingDetails");
      	String displayMessage2 = request.getParameter("exist");
    	if(displayMessage1!=null){
    		out.print("<h5>Make sure everything is typed correctly</h5>");
    	}
    	else if(displayMessage2!=null){
    		out.print("<h5>Account already exists</h5>");
    	}
      %>
	    <input type="submit" value="Create Account" />
    </form>
</body>
</html>