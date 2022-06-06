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
	<title>Delete Auction</title>
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
			
			String vin = request.getParameter("vin");
			//Create a SQL statement
			Statement stmt2 = con.createStatement();
			//Make an insert statement for the Account table:
			String delete2 = "DELETE FROM Bids WHERE vin='"+vin+"';";
			stmt2.executeUpdate(delete2);

			Statement stmt = con.createStatement();
			//Make an insert statement for the Account table:
			String delete = "DELETE FROM Auction WHERE vin='"+vin+"';";
			
			//Create a Prepared SQL statement allowing you to introduce the parameters of the query
			stmt.executeUpdate(delete);
			Statement stmt3 = con.createStatement();
			//Make an insert statement for the Account table:
			String delete3 = "DELETE FROM Item WHERE vin='"+vin+"';";
			stmt3.executeUpdate(delete3);
			stmt3.close();
	
			//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
			stmt2.close();
			stmt.close();
			con.close();

			out.print("<meta http-equiv='Refresh' content='0; url=\"Home.jsp\"' />");
		} catch (Exception ex) {
			out.print("Something went wrong: ");
			out.print(ex);
		}
	}
%>
</body>
</html>