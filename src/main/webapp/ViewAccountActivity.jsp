<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Account Activity</title>
	<link href="styles.css" rel="stylesheet">
	<div class="topnav">
		<a class="logo" href="Home.jsp"><img src="BuyMeLogo.png" width = "auto" height = "35"></a>
		<% if(session.getAttribute("username")!=null){  
			String username=(String)session.getAttribute("username");
        	out.print("<a>Welcome "+username+"</a>"); 
		}
		%>
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
	        	out.print("<a href=\"Sellitem.jsp?prev="+prevPath+"\">Sell Car</a>");
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
<h1>View Account Activity</h1>
<div class="padding50"></div>
	<%					
		String username;
		if(request.getParameter("username")==null){
			username = (String)session.getAttribute("username");
		}
		else{
			username = request.getParameter("username");
		}
	 %>
	<form method="get" action="ViewAccountActivity.jsp">
			<input class="searchBar" type="text" name="username" placeholder="Search for a user..." value="<%out.print(username);%>">
			<input class="searchButton" type="submit" value="Search" />
	</form>
	<div class="padding50"></div>
		<div class="activityDiv">
		<h3>Bid</h3>
	       <table class="activityTable">
			  <tr>
			    <th>Username</th>
			    <th>Auction</th>
			    <th>Time</th>
			  </tr>
			  <%
			  	try{
					//Get the database connection
					ApplicationDB db = new ApplicationDB();	
					Connection con = db.getConnection();	
					
					//Create a SQL statement
					Statement activityStmt = con.createStatement();
					String activityStr = "SELECT buyer_username, vin, bidding_time FROM Bids "
							+"WHERE buyer_username='"+username+"';";
					
					ResultSet activityResult = activityStmt.executeQuery(activityStr);
					while(activityResult.next()){
						String buyer_username = activityResult.getString("buyer_username");
						String vin = activityResult.getString("vin");
						String bidding_time =activityResult.getString("bidding_time");
						out.print("<tr><td>"+buyer_username+"</td>");
						out.print("<td>"+vin+"</td>");
						out.print("<td>"+bidding_time+"</td></tr>");
					}
					//close the connection.
					activityResult.close();
					activityStmt.close();
					con.close();
				} catch (Exception ex) {
					out.print(ex);
				}
			  %>
			</table>
		</div>
		<div class="activityDiv2">
		<h3>Sold</h3>
	       <table class="activityTable2">
			  <tr>
			    <th>Username</th>
			    <th>Auction</th>
			    <th>Time</th>
			  </tr>
			  <%
			  	try{
					//Get the database connection
					ApplicationDB db = new ApplicationDB();	
					Connection con = db.getConnection();	
								Statement activityStmt2 = con.createStatement();
					String activityStr2 = "SELECT seller_name, vin, open_date FROM Auction "
							+"WHERE seller_name='"+username+"';";
					
					ResultSet activityResult2 = activityStmt2.executeQuery(activityStr2);
					while(activityResult2.next()){
						String seller_name = activityResult2.getString("seller_name");
						String vin2 = activityResult2.getString("vin");
						String open_time =activityResult2.getString("open_date");
						out.print("<tr><td>"+seller_name+"</td>");
						out.print("<td>"+vin2+"</td>");
						out.print("<td>"+open_time+"</td></tr>");
					}
					//close the connection.
					activityResult2.close();
					activityStmt2.close();
					con.close();
				} catch (Exception ex) {
					out.print(ex);
				}
			  %>
			</table>
		</div>
	<div class="padding20"></div>



</body>
</html> 