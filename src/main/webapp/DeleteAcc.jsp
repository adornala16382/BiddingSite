<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Delete Account</title>
	<link href="styles.css" rel="stylesheet">
    <div class="topnav">
		<a class="logo" href="Home.jsp"><img src="BuyMeLogo.png" width = "auto" height = "35"></a>
		<div class="topnav-right">
		    <a href="Login.jsp">Sign In</a>"
		</div>
	</div>
</head>
<body>
	<%
        if(session.getAttribute("username")!=null){ 	
            try {  
                //Get the database connection
                ApplicationDB db = new ApplicationDB();	
                Connection con = db.getConnection();

                //Create a SQL statement
                Statement stmt = con.createStatement();
                
                String username = (String)session.getAttribute("username");
                //Make an delete statement for the Account table:
                String delete = "DELETE FROM Account WHERE username=?;";
                
				//Create a Prepared SQL statement allowing you to introduce the parameters of the query
				PreparedStatement ps = con.prepareStatement(delete);
		
				//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
				ps.setString(1, username);
				//Run the query against the DB
				ps.executeUpdate();

                session.invalidate();
                out.print("<meta http-equiv='Refresh' content='0; url=\"Home.jsp\"' />");

                //close the connection.
                stmt.close();
                con.close();
                
            } catch (Exception ex) {
                out.print("Something went wrong: ");
                out.print(ex);
            }
        }
        else{
            out.print("You are not signed in");
        }
	%>
</body>
</html>