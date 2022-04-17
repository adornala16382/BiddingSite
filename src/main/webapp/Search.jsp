<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Home</title>
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
	<br>
	<form method="get" action="Search.jsp">
		<% String search = request.getParameter("key"); 
			if(search==null){
				out.print("<meta http-equiv='Refresh' content='0; url=\"Home.jsp\"' />");
			}
			
			out.print("<input class=\"searchBar\" type=\"text\" value=\""+search+"\" name=\"key\" placeholder=\"Search for items..\">");
		%>
		<input class="searchButton" type="submit" value="Search" />
	</form>
	<div class="padding20"></div>
		  <%
		  	try {
				
				//Get the database connection
				ApplicationDB db = new ApplicationDB();	
				Connection con = db.getConnection();	
				
				//Create a SQL statement
				Statement stmt = con.createStatement();
				
				//Get the combobox from the index.jsp
				//Make a SELECT query from the sells table with the price range specified by the 'price' parameter at the index.jsp
				String str = "SELECT model FROM Test WHERE model LIKE '%"+search+"%';";
				//Run the query against the database.
				ResultSet result = stmt.executeQuery(str);
				int len = 0;
				while(result.next()){
					len++;
					String model = result.getString("model");
					//String id = result.getString("id");
					//String curBid = result.getString("curBid");
					//String seller = result.getString("seller");
					%>
					<div class="itemBox">
					<%
						out.print("<a href=\"Details.jsp?id="+model+"\">"); 
						out.print(model); %>
						</a>
					</div>
				<%
				}
				if(len==0){
					out.print("Make sure everything is typed correctly");
				}
				//close the connection.
				result.close();
				stmt.close();
				con.close();
			}catch (Exception ex) {
				out.print(ex);
			}	  
		  %>
</body>
</html>