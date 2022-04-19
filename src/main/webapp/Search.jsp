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
		<input type="hidden" name="page" value="0" />
	</form>
	<div class="padding20"></div>
		  <%
		  	try {
				
				//Get the database connection
				ApplicationDB db = new ApplicationDB();	
				Connection con = db.getConnection();	
				
				//Create a SQL statement
				//Second statement
				Statement stmt2 = con.createStatement();
				String str2 = "SELECT COUNT(*) FROM Item WHERE make LIKE '%"+search+"%';";
				ResultSet result2 = stmt2.executeQuery(str2);
				
				int pageLimit = 5;
				int curPage = Integer.valueOf(request.getParameter("page"));
				int startIndex = curPage * pageLimit;
				int numRows=0;
				if(result2.next()){
					numRows = Integer.valueOf(result2.getString("COUNT(*)"));
				}
				//close the connection.
				result2.close();
				stmt2.close();
				Statement stmt = con.createStatement();
				String str = "SELECT * FROM Item WHERE make LIKE '%"+search+"%' LIMIT "+startIndex+","+pageLimit+";";
				//Run the query against the database.
				ResultSet result = stmt.executeQuery(str);
				int len = 0;
				while(result.next()){
					len++;
					String make = result.getString("make");
					String model = result.getString("model");
					String car_type = result.getString("car_type");
					String color = result.getString("color");
					String car_year = result.getString("car_year");
					String item_id = result.getString("item_id");
			%>
					<div class="itemBox">
					
					<div class="items">
					
					<ul>
					
					<%
				
						out.print("<li><a href=\"Details.jsp?id="+make+"\">"); 
						out.print(make);
						out.print("</a></li>");
						out.print("<li>"+model+"</li>");
						out.print("<li>"+car_type+"</li>");
						out.print("<li>"+color+"</li>");
						out.print("<li>"+car_year+"</li>");
					%>
					
					</ul>
					</div>
					</div>
				<%
				
				}
				//close the connection.
				result.close();
				stmt.close();
				con.close();
				if(len==0){
					out.print("No matches found");
				}
				else{
					%>
					<div class="padding20"></div>
					<%
					String key = request.getParameter("key");
					String page1 = request.getParameter("page");
					int pagenumber = Integer.valueOf(page1);
					if(pagenumber > 0){
						out.print("<button><a href=\"Search.jsp?key="+key+"&page="+(pagenumber-1)+"\">previous</a></button>");
					}
					out.print("<button><a href=\"Search.jsp?key="+key+"&page="+(pagenumber)+"\">"+pagenumber+"</a></button>");
					if(pagenumber < (int)((numRows-1)/pageLimit)){
						out.print("<button><a href=\"Search.jsp?key="+key+"&page="+(pagenumber+1)+"\">next</a></button>");
					}
				}
				%>
				<div class="padding20"></div>
				<%
			}catch (Exception ex) {
				out.print(ex);
			}
		  %>
</body>
</html>