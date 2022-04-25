<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<link href="styles.css" rel="stylesheet">
	<title>Create Account</title>
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
	<%
			String username = request.getParameter("username");
			String password = request.getParameter("password");
			String customerRep = request.getParameter("CustomerRep");
			String confirmPassword = request.getParameter("confirm password");
			
			if(username=="" || password=="" || password.equals(confirmPassword)==false){
				if(customerRep!=null){
					out.print("<meta http-equiv='Refresh' content='0; url=\"CreateAcc.jsp?CustomerRep=True&missingDetails=True\"' />");
				}
				else{
					out.print("<meta http-equiv='Refresh' content='0; url=\"CreateAcc.jsp?missingDetails=True\"' />");
				}
			}
			else{
				try {
					
					//Get the database connection
					ApplicationDB db = new ApplicationDB();	
					Connection con = db.getConnection();
			
					//Create a SQL statement
					Statement stmt = con.createStatement();
					//Make an insert statement for the Account table:
					String insert = "";
					if(customerRep!=null){
						insert = "INSERT INTO Account(username, password, type)"
								+ "VALUES (?, ?, ?)";
					}
					else{
						insert = "INSERT INTO Account(username, password)"
								+ "VALUES (?, ?)";
					}
					
					//Create a Prepared SQL statement allowing you to introduce the parameters of the query
					PreparedStatement ps = con.prepareStatement(insert);
			
					//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
					ps.setString(1, username);
					ps.setString(2, password);
					if(customerRep!=null){
						ps.setString(3, "CustomerRep");
					}
					//Run the query against the DB
					ps.executeUpdate();
			
					//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
					ps.close();
					stmt.close();
					con.close();
					if(customerRep!=null){
						out.print("<meta http-equiv='Refresh' content='0; url=\"CreateAcc.jsp?success=True&CustomerRep=True\"' />");
					}
					else{
				        request.getSession();  
				        session.setAttribute("username",username);	
						out.print("<meta http-equiv='Refresh' content='0; url=\"Home.jsp\"' />");
					}
			        
					
				} catch (Exception ex) {
					out.print("Something went wrong: ");
					out.print(ex);
					if(customerRep!=null){
						out.print("<meta http-equiv='Refresh' content='0; url=\"CreateAcc.jsp?exist=True&CustomerRep=True\"' />");
					}
					else{
						out.print("<meta http-equiv='Refresh' content='0; url=\"CreateAcc.jsp?exist=True\"' />");
					}
				}
			}
	%>
</body>
</html>