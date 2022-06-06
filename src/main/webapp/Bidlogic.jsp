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
			Statement stmt = con.createStatement();
			String username= (String)session.getAttribute("username");
			
		    String AutoBid = request.getParameter("AB");
		   
		    
		    int bidPrice = Integer.parseInt(request.getParameter("bidPrice"));
		    
		    String vin = request.getParameter("vin");
			String str = "SELECT * FROM Auction WHERE Auction.vin='"+vin+"';";
			ResultSet result = stmt.executeQuery(str);
			int current_bid =0;
			int lbound = 0;
			
			if(result.next()){
				current_bid = Integer.parseInt(result.getString("initial_bidding_price"));
				lbound = Integer.parseInt(result.getString("lbound_increment"));
			}

		   	String Bidding= "INSERT INTO Bids(buyer_username, vin, bidding_price) VALUES(?,?,?)";
		   	String update = "UPDATE Auction SET initial_bidding_price= '"+bidPrice+"'WHERE Auction.vin= '"+vin+"';";
			PreparedStatement ps;
			PreparedStatement ps2;
			Statement ps3 = con.createStatement();

			if(AutoBid!=null){
				int Increment = Integer.parseInt(request.getParameter("Increment"));
			    int Max = Integer.parseInt(request.getParameter("upper_limit"));
				
				if(bidPrice >=current_bid+lbound && bidPrice<= Max && Increment>=lbound){
					String AB = "INSERT INTO Auto_Bids (buyer_username, vin, bidding_price, increment, upper_limit) VALUES(?,?,?,?,?)";
			    	
			    	ps = con.prepareStatement(AB);
			    	ps.setString(1, username);
					ps.setString(2, vin);
					ps.setInt(3, bidPrice);
					ps.setInt(4, Increment);
					ps.setInt(5, Max);
					ps.executeUpdate();
					ps.close();			
					ps3.executeUpdate(update);	
				}
			}
			else if(bidPrice>=current_bid+lbound){
			    	ps2 = con.prepareStatement(Bidding);
			    	ps2.setString(1, username);
					ps2.setString(2, vin);
					ps2.setInt(3, bidPrice);
					ps2.executeUpdate();
					ps2.close();
					ps3.executeUpdate(update);
			}
		    else{
		    	out.print("Parameters Incorrect");
		    }
			//Start checking if bids are closed 
		    out.print("<meta http-equiv='Refresh' content='0; url=\"Home.jsp\"' />");
		    con.close();

		} catch (Exception ex) {
			out.print(ex);
		}
	%>
	</body>
</html>