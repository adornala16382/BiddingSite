<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Bid Logic</title>
	<link href="styles.css" rel="stylesheet">
</head>
	<body>
	
	<%
		
	    try {
	    	
	    	ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();	
			
			//Create a SQL statement
			Statement stmt = con.createStatement();
			String username= (String)session.getAttribute("username");
			out.println(username);
		    String AutoBid = request.getParameter("AB");
		    out.println(AutoBid);
		    int bidPrice = Integer.parseInt(request.getParameter("bidPrice"));
		    out.println(bidPrice);
		    int Increment = Integer.parseInt(request.getParameter("Increment"));
		    out.println(Increment);
		    int Max = Integer.parseInt(request.getParameter("upper_limit"));
		    out.println(Max);
		    String vin = request.getParameter("vin");
		    out.println(vin);
		    String Bidding= "INSERT INTO Bids(buyer_username, vin, bidding_price) VALUES(?,?,?)";
			PreparedStatement ps;
			PreparedStatement ps2;

		    if(AutoBid!=null){
		    	String AB = "INSERT INTO Auto_Bids (buyer_username, vin, bidding_price, increment, upper_limit) VALUES(?,?,?,?,?)";
		    	
		    	ps = con.prepareStatement(AB);
		    	ps.setString(1, username);
				ps.setString(2, vin);
				ps.setInt(3, bidPrice);
				ps.setInt(4, Increment);
				ps.setInt(5, Max);
				ps.executeUpdate();
				ps.close();
		    }
	    	ps2 = con.prepareStatement(Bidding);
	    	ps2.setString(1, username);
			ps2.setString(2, vin);
			ps2.setInt(3, bidPrice);
			ps2.executeUpdate();
			ps2.close();

			out.print("<meta http-equiv='Refresh' content='0; url=\"Home.jsp\"' />");
		    con.close();
		} catch (Exception ex) {
			out.print(ex);
		}

	%>
	 
	</body>

</html>