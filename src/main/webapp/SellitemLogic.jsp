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
			String Car_make = request.getParameter("Car Make");
			String Car_model = request.getParameter("Car Model");
			String Car_color = request.getParameter("Car Color");
			String Car_year = request.getParameter("Car Year");
			//Make a SELECT query from the sells table with the price range specified by the 'price' parameter at the index.jsp
			//String str = "SELECT COUNT(*) FROM Account WHERE username='"+username+"' AND password='"+password+"'";
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);
			
			
			if(result.next()){
				String prevPage = request.getParameter("prev");
				if(prevPage.equals("null")){
					prevPage = "Home.jsp";
					out.print("<meta http-equiv='Refresh' content='0; url=\"Home.jsp\"' />");
				}
				if(result.getString("COUNT(*)").equals("1")==true){
			        request.getSession();  
			        session.setAttribute("username",username);
					out.print("<meta http-equiv='Refresh' content='0; url=\""+prevPage+"\"' />");
				}
				else{
		        	String prevParam = request.getQueryString();
		        	String prevPath;
		        	if(prevParam==null){
		        		prevPath = "";
		        	}
		        	else{
		        		prevPath = "Login.jsp?"+prevParam;
		        	}
					out.print("<meta http-equiv='Refresh' content='0; url=\""+prevPath+"&displayMessage=true\"' />");
					out.print("Username or password is incorrect");
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
	%>

</body>
</html>