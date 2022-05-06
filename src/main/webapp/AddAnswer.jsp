<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Add Answer</title>
	<link href="styles.css" rel="stylesheet">
</head>
<body>
<%
	String username = (String)session.getAttribute("username");
	String answer= request.getParameter("answer");
	int qid = Integer.parseInt(request.getParameter("qid"));
	
	if(username==null){
		out.print("<meta http-equiv='Refresh' content='0; url=\"Login.jsp\"' />");
	}
	else{
		try {
			
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();
	
			//Create a SQL statement
			Statement stmt = con.createStatement();
			//Make an insert statement for the Account table:
			String insert = "INSERT INTO Answer(qid, aUsername, answer)"
						+ "VALUES (?, ?, ?)";
			
			//Create a Prepared SQL statement allowing you to introduce the parameters of the query
			PreparedStatement ps = con.prepareStatement(insert);
	
			//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
			ps.setInt(1, qid);
			ps.setString(2, username);
			ps.setString(3, answer);
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
				out.print("<meta http-equiv='Refresh' content='0; url=\"Home.jsp\"' />");
			}
			
			
		} catch (Exception ex) {
			out.print("Something went wrong: ");
			out.print(ex);
		}
	}
%>
</body>
</html>