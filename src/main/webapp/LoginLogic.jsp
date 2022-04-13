<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Insert title here</title>
	<link href="styles.css" rel="stylesheet">
</head>
<body>
	<% 
		try {

			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();	
			
			//Create a SQL statement
			Statement stmt = con.createStatement();
			//Get the combobox from the index.jsp
			String username = request.getParameter("login username");
			String password = request.getParameter("login password");
			//Make a SELECT query from the sells table with the price range specified by the 'price' parameter at the index.jsp
			String str = "SELECT COUNT(*) FROM Account WHERE username='"+username+"' AND password='"+password+"'";
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);
			
			
			if(result.next()){
				if(result.getString("COUNT(*)").equals("1")==true){
			        HttpSession session1=request.getSession();  
			        session.setAttribute("username",username);
					out.print("<meta http-equiv='Refresh' content='0; url=\"Home.jsp\"' />");
				}
				else{
					out.print("Account doesn't exist");
				}
			}
			else{
				out.print("Something went wrong");
			}

			//close the connection.
			result.close();
			stmt.close();
			con.close();
			
			
			
		} catch (Exception ex) {
			out.print(ex);
		}
		out.close();
	%>

</body>
</html>