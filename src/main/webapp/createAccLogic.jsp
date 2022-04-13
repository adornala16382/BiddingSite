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
<title>Insert title here</title>
</head>
<body>
	<%

			String username = request.getParameter("username");
			String password = request.getParameter("password");
			String confirmPassword = request.getParameter("confirm password");
			
			if(username==""){
				out.print("Must give username");
			}
			else if(password==""){
				out.print("Must give password");
			}
			else if(password.equals(confirmPassword)==false){
				out.print("Passwords don't match");
			}
			else{
				try {
					
					//Get the database connection
					ApplicationDB db = new ApplicationDB();	
					Connection con = db.getConnection();
			
					//Create a SQL statement
					Statement stmt = con.createStatement();
					//Make an insert statement for the Sells table:
					String insert = "INSERT INTO Account(username, password)"
							+ "VALUES (?, ?)";
					
					//Create a Prepared SQL statement allowing you to introduce the parameters of the query
					PreparedStatement ps = con.prepareStatement(insert);
			
					//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
					ps.setString(1, username);
					ps.setString(2, password);
					//Run the query against the DB
					ps.executeUpdate();
			
					//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
					stmt.close();
					con.close();
			
					out.print("Insert succeeded!");
					
				} catch (Exception ex) {
					out.print("Something went wrong");
					out.print(ex);
				}
			}
		out.close();
	%>
</body>
</html>