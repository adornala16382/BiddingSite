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
	        	out.print("<a href=\"LogoutLogic.jsp\">Sign Out</a>");
				%>
				<a href="Profile.jsp">Profile</a>
	        <%}  
	        else{
	        	out.print("<a href=\"Login.jsp\">Sign In</a>");
	        }  
			%>
		</div>
	</div>
</head>
<body>
	<%
	String customerRep = request.getParameter("CustomerRep");
	String type = (String)session.getAttribute("type");
	if(customerRep!=null && type!=null && type.equals("Admin")){
		out.print("<h1>Create New Customer Representative Account</h1>");
		out.print("<form method=\"post\" action=\"createAccLogic.jsp\">");
		out.print("<input type=\"hidden\" name=\"CustomerRep\" value=\"True\" />");
	}
	else{
		out.print("<h1>Create New Account</h1>");
		out.print("<form method=\"post\" action=\"createAccLogic.jsp\">");
	}
	%>
	    <label >Username:</label> <br>
	    <input type="text" id="username" name="username"><br>
	    <label >Password</label><br>
	    <input type="password" id="password" name="password"> <br>
	    <label >Confirm Password</label><br>
	    <input type="password" id="confirm password" name="confirm password"> 
      <%
      	String displayMessage1 = request.getParameter("missingDetails");
      	String displayMessage2 = request.getParameter("exist");
      	String displayMessage3 = request.getParameter("success");
    	if(displayMessage1!=null){
    		out.print("<h5>Make sure everything is typed correctly</h5>");
    	}
    	else if(displayMessage2!=null){
    		out.print("<h5>Account already exists</h5>");
    	}
    	else if(displayMessage3!=null){
    		out.print("<h5>Account Created Successfully!</h5>");
    	}
      %>
      	<br>
	    <input class="bb_blue" type="submit" value="Create Account" />
    </form>
</body>
</html>