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
	<title>Delete Alert</title>
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
			
			String bid_username = request.getParameter("username");
			String vin = request.getParameter("vin");
			int bidding_price = Integer.parseInt(request.getParameter("price"));
			//Create a SQL statement
			Statement stmt = con.createStatement();
			String delete = "DELETE FROM Bids WHERE buyer_username='"+bid_username+"' AND vin='"+vin
				+"' AND bidding_price="+bidding_price+";";
			
			//Create a Prepared SQL statement allowing you to introduce the parameters of the query
			stmt.executeUpdate(delete);

			Statement stmt2 = con.createStatement();	
			String findMax = "SELECT MAX(bidding_price) as max_price FROM Bids WHERE buyer_username='"+bid_username+"' AND vin='"+vin+"'";
			ResultSet max = stmt.executeQuery(findMax);
			int maxPrice=0;
			if(max.next()){
				maxPrice = Integer.parseInt(max.getString("max_price"));
			}
			max.close();
			stmt2.close();
			Statement stmt3 = con.createStatement();
			String update = "UPDATE Auction SET initial_bidding_price= '"+maxPrice+"'WHERE Auction.vin= '"+vin+"';";
			
			//Create a Prepared SQL statement allowing you to introduce the parameters of the query
			stmt3.executeUpdate(update);
			stmt3.close();
			//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
			stmt.close();
			con.close();

			out.print("<meta http-equiv='Refresh' content='0; url=\"Details.jsp?id="+vin+"\"' />");
		} catch (Exception ex) {
			out.print("Something went wrong: ");
			out.print(ex);
		}
	}
%>
</body>
</html>