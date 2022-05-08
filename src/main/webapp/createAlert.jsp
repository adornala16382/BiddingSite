<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.time.LocalDateTime"%>
<%@ page import="java.time.format.DateTimeFormatter"%> 

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Create Alert</title>
	<link href="styles.css" rel="stylesheet">
</head>
<body>
<%
	String username = (String)session.getAttribute("username");
	if(username==null){
		out.print("<meta http-equiv='Refresh' content='0; url=\"Login.jsp\"' />");
	}
	else{
		try {
			
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();
			
			String model = request.getParameter("Car Model");
			String make = request.getParameter("Car Make");
			String car_type = request.getParameter("Car Type");
			String color = request.getParameter("Car Color");
			
			//Create a SQL statement
			Statement stmt = con.createStatement();
			//Make an insert statement for the Account table:
			String insert = "INSERT INTO Alert(alert_username, model, make, car_type, color)"
					+ "VALUES (?,?,?,?,?);";
			
			//Create a Prepared SQL statement allowing you to introduce the parameters of the query
			PreparedStatement ps = con.prepareStatement(insert);
	
			//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
			ps.setString(1, username);
			ps.setString(2, model);
			ps.setString(3, make);
			ps.setString(4, car_type);
			ps.setString(5, color);
			//Run the query against the DB
			ps.executeUpdate();
	
			//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
			ps.close();
			stmt.close();
			con.close();
			String prevPath = request.getParameter("prev");
			if(prevPath!=null){
				out.print("<meta http-equiv='Refresh' content='0; url=\""+prevPath+"\"' />");
			}
			else{
				out.print("<meta http-equiv='Refresh' content='0; url=\"Alerts.jsp\"' />");
			}
			
			
		} catch (Exception ex) {
			out.print("Something went wrong: ");
			out.print(ex);
		}
	}
%>
</body>
</html>