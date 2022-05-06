<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.time.LocalDateTime"%>

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
			String username= (String)session.getAttribute("username");
			String Car_model = request.getParameter("Car Model");
			String Car_make = request.getParameter("Car Make");
			String Car_color = request.getParameter("Car Color");
			int Car_year = Integer.parseInt(request.getParameter("Car Year"));
			String Car_type = request.getParameter("Car Type");
			String vin = request.getParameter("Car Vin");
			int Start_Bid = Integer.parseInt(request.getParameter("Starting Bid"));
			int Low_bound = Integer.parseInt(request.getParameter("Lower Increment Bound"));
			int Secret_min = Integer.parseInt(request.getParameter("Secret Min"));
			String Close_date = request.getParameter("Close Date");
			
			String item_str = "INSERT INTO Item(model,make,car_type,color,car_year,vin) VALUES(?,?,?,?,?,?);";
			String auction_str = "INSERT INTO Auction(seller_name,vin,initial_bidding_price,lbound_increment,secret_min,close_date) VALUES(?,?,?,?,?,?);";
			String Seller_str = "INSERT INTO Seller(seller_username) VALUES(?);";
			String Sells_str = "INSERT INTO Sells(seller_username,vin) VALUES(?,?);";
			String check_seller ="SELECT COUNT(*) FROM Seller WHERE(seller_username= '"+username+"')";
			String check_item_sold ="SELECT COUNT(*) FROM Sells WHERE(seller_username= '"+username+"' AND vin = '"+vin+"')";

			//Make a SELECT query from the sells table with the price range specified by the 'price' parameter at the index.jsp

			//Create a Prepared SQL statement allowing you to introduce the parameters of the query
			PreparedStatement ps = con.prepareStatement(item_str);
			PreparedStatement pst = con.prepareStatement(auction_str);
			PreparedStatement psst = con.prepareStatement(Seller_str);
			PreparedStatement psells = con.prepareStatement(Sells_str);

			//result.getString("COUNT(*)").equals("1")==true
			Statement s = con.createStatement();
			ResultSet result = s.executeQuery(check_seller);
			result.next();
			//result = stmt.executeQuery(check_item_sold);
			int numRows = result.getInt("COUNT(*)") ;
			if(numRows<1){
				psst.setString(1, username);
				psst.executeUpdate();
			}
			result.close();
			result = s.executeQuery(check_item_sold);
			psst.close();

			//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
			ps.setString(1, Car_model);
			ps.setString(2, Car_make);
			ps.setString(3, Car_type);
			ps.setString(4, Car_color);
			ps.setInt(5, Car_year);
			ps.setString(6, vin);
			ps.executeUpdate();
			
			pst.setString(1, username);
			pst.setString(2, vin);
			pst.setInt(3, Start_Bid);
			pst.setInt(4, Low_bound);
			pst.setInt(5, Secret_min);
			pst.setString(6, Close_date);
			pst.executeUpdate();
			
			if(numRows<1){
				psells.setString(1, username);
				psells.setString(2, vin);
				psells.executeUpdate();
			}

			result.close();
			psells.close();
			
			
			//close the connection
			ps.close();
			pst.close();
		
			stmt.close();
			s.close();
			con.close();
			out.print("<meta http-equiv='Refresh' content='0; url=\"Home.jsp\"' />");
			
		} catch (Exception ex) {
			out.print(ex);
		}
	%>

</body>
</html> 