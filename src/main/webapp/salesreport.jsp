<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Sell Item</title>
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
	        	out.print("<a href=\"Alerts.jsp?prev="+prevPath+"\">Alerts</a>");
	        	out.print("<a href=\"Sellitem.jsp?prev="+prevPath+"\">Sell Vehicle</a>");
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
<%
	try {
		
		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		String IS=  request.getParameter("IS");
        String ES=  request.getParameter("ES");
        String ITS=  request.getParameter("ITS");
        String EUS=  request.getParameter("EUS");
        String BSI=  request.getParameter("BSI");
        String BBS=  request.getParameter("BBS");
        String user = (String)request.getParameter("ITTS");
        Statement stmt = con.createStatement();
        
        ResultSet result;
        String str= "";
        
        if(IS!=null){
        	
        	str= "SELECT Item.make as make, Item.model as model, Item.car_type as type, Item.color as color, Item.car_year as year, Sum(initial_bidding_price) as earnings FROM Auction LEFT JOIN Item on Auction.vin = Item.vin WHERE (Auction.closed = 'true') GROUP BY Item.make, Item.model, Item.car_type, Item.color, Item.car_year ;";
        	result = stmt.executeQuery(str);
        	out.print("<h1>Sales Report For Each Item</h1>");
   			while(result.next()){
   				
   				%> 
   				<div class= "SR">
   				<table>
   				<tr>
   				<td><%out.print(result.getString("make"));%> </td>
   				<td><%out.print(result.getString("model"));%> </td>
   				<td><%out.print(result.getString("color"));%> </td>
   				<td><%out.print(result.getString("year"));%> </td>
   				<td>$<%out.print(result.getString("earnings"));%> </td>
   				</tr> 
   				</table>
   				</div>
   				<% 
   				
   			}
        	
        	
        }
        else if(ES!=null){
        	str= "SELECT Sum(initial_bidding_price) as total_earnings FROM Auction WHERE (Auction.closed = 'true');";
        	result = stmt.executeQuery(str);
        	out.print("<h1>Sales Report For Total Earnings</h1>");
   			while(result.next()){
   				
   				%> 
   				<div class= "SR">
   				<table>
   				<tr>
   				<td>$<%out.print(result.getString("total_earnings"));%> </td>
   				</tr> 
   				</table>
   				</div>
   				<% 
   				
   			}
        	
        }
        else if(ITS!=null){
        	str= "SELECT Item.car_type as type, Sum(initial_bidding_price) as earnings FROM Auction LEFT JOIN Item on Auction.vin = Item.vin WHERE (Auction.closed = 'true') GROUP BY Item.car_type;";
        	result = stmt.executeQuery(str);
        	out.print("<h1>Sales Report For Total Earnings For each Car Type</h1>");
		while(result.next()){
   				
   				%> 
   				<div class= "SR">
   				<table>
   				<tr>
   				<td><%out.print(result.getString("type"));%> </td>
   				<td>$<%out.print(result.getString("earnings"));%> </td>
   				</tr> 
   				</table>
   				</div>
   				<% 
   				
   			}
        	
        }
        else if(EUS!=null){
        	str = "SELECT Seller.seller_username as user, SUM(initial_bidding_price) as earnings FROM Seller LEFT JOIN Auction on Seller.seller_username = Auction.seller_name WHERE (Auction.closed = 'true' AND Auction.seller_name = '"+user+"') GROUP BY Seller.seller_username;";
        	result = stmt.executeQuery(str);
			while(result.next()){
   				
   				%> 
   				<div class= "SR">
   				<table>
   				<tr>
   				<td><%out.print(result.getString("user"));%> </td>
   				<td>$<%out.print(result.getString("earnings"));%> </td>
   				</tr> 
   				</table>
   				
   				</div>
   				
   				
   				<% 
   				
   			}
        	
        }
        else if(BSI!=null){
        	str = "SELECT Item.make as make, Item.model as model, Item.car_type as type, Item.color as color, Item.car_year as year, Sum(Auction.initial_bidding_price) earnings, COUNT(distinct Item.make, Item.model,Item.color,Item.car_type,Item.car_year) as best_selling  FROM Item LEFT JOIN Auction on Auction.vin = Item.vin WHERE( Auction.closed = 'true') GROUP BY Item.make, Item.model, Item.car_type, Item.color, Item.car_year ORDER BY best_selling DESC LIMIT 3;";
        	result = stmt.executeQuery(str);
        	out.print("<h1>Sales Report For Total Earnings For Best Selling Items</h1>");
			while(result.next()){
   				
   				%> 
   				<div class="SR">
   				<table>
   				<tr>
   				<td><%out.print(result.getString("make"));%> </td>
   				<td><%out.print(result.getString("model"));%> </td>
   				<td><%out.print(result.getString("color"));%> </td>
   				<td><%out.print(result.getString("year"));%> </td>
   				<td>$<%out.print(result.getString("earnings"));%> </td>
   				<td><%out.print(result.getString("best_selling"));%> </td>
   				</tr> 
   				</table>
   				</div>
   				
   				<% 
	
   		}
        	
        }
        else if(BBS !=null){
        	str = "SELECT  buyer_name as winner , SUM(final_bid) as final_bid FROM (SELECT buyer_username AS buyer_name, MAX(bidding_price) as final_bid FROM Bids LEFT join Auction on Bids.vin = Auction.vin  WHERE (Auction.closed= 'true' AND bidding_price>Auction.secret_min) GROUP BY Bids.buyer_username,Bids.vin) AS t group by buyer_name ;";
        	result = stmt.executeQuery(str);
        	out.print("<h1>Sales Report For Best Buyers</h1>");
			while(result.next()){
   				
   				%> 
   				<div class="SR">
   				<table>
   				<tr>
   				<td><%out.print(result.getString("winner"));%> </td>
   				<td><%out.print(result.getString("final_bid"));%> </td>

   				</tr> 
   				</table>
   				</div>
   				
   				<% 

   		}

        }
	}

	catch (Exception ex) {
		out.print(ex);
	}

%>


</body>
</html> 