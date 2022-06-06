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
		<% 
		String sessType = (String)session.getAttribute("type");
		if(session.getAttribute("username")!=null){  
			String username=(String)session.getAttribute("username");
			String visits = (String)session.getAttribute("visits");
			int numVisits = 0;
			session.setAttribute("visits", String.valueOf(numVisits));
			try{
				//Get the database connection
				ApplicationDB db = new ApplicationDB();	
				Connection con = db.getConnection();	
				
				//Create a SQL statement
				//Second statement
				if(numVisits==1){
					Statement stmt = con.createStatement();
					String str = "SELECT * FROM Alert WHERE alert_username='"+username+"';";
					ResultSet result = stmt.executeQuery(str);
					while(result.next()){
						String alert_username = result.getString("alert_username");
						String model = result.getString("model");
						String make = result.getString("make");
						String car_type = result.getString("car_type");
						String color = result.getString("color");
						//
						Statement stmt2 = con.createStatement();
						String str2 = "SELECT COUNT(*) FROM Auction "
								+"JOIN Item ON Auction.vin=Item.vin "
								+"WHERE model LIKE '%"+model+"%' AND make LIKE '%"+make+"%' AND car_type LIKE '%"+car_type+"%' AND color LIKE '%"+color+"%';";
						ResultSet result2 = stmt2.executeQuery(str2);
						if(result2.next()){
							if(result2.getString("COUNT(*)").equals("0")==false){
								//display alert
								%>
								<div class="alert">
								  <span class="closebtn" onclick="this.parentElement.style.display='none';">&times;</span>
								  You have a new alert! Vehicle available. Please check your alerts tab.
								</div>
								<% 
							}
							result2.close();
							stmt2.close();
						}
						result.close();
						stmt.close();
						Statement stmt1 = con.createStatement();
						String str1 = "SELECT * FROM Bids WHERE buyer_username='"+username+"' GROUP BY vin;";
						ResultSet result1 = stmt1.executeQuery(str1);
						while(result1.next()){
							String vin = result1.getString("vin");
							Statement stmt4 = con.createStatement();
							String str4 = "SELECT MAX(bidding_price) AS max FROM Bids WHERE buyer_username='"+username+"' AND vin='"+vin+"' GROUP BY bidding_price;";
							ResultSet result4 = stmt4.executeQuery(str4);
							if(result4.next()){
								int yourMax = Integer.parseInt(result4.getString("vin"));
								Statement stmt3 = con.createStatement();
								String str3 = "SELECT * FROM Auction WHERE vin='"+vin+"';";
								ResultSet result3 = stmt3.executeQuery(str3);
								if(result3.next()){
									int curBid = Integer.parseInt(result3.getString("initial_bidding_price"));
									if(curBid > yourMax){
										%>
										<div class="alert">
										  <span class="closebtn" onclick="this.parentElement.style.display='none';">&times;</span>
										  Someone Bid higher than you
										</div>
										<%
									}
								}
								stmt3.close();
								result3.close();
							}
							stmt4.close();
							result4.close();
						}
						stmt1.close();
						result1.close();
						stmt2.close();
						result2.close();

					}
				}
				con.close();
			}catch (Exception ex) {
				out.print(ex);
			}
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
	<br>
	<form method="get" action="Search.jsp">
		<% String search = request.getParameter("key"); 
			if(search==null){
				out.print("<meta http-equiv='Refresh' content='0; url=\"Home.jsp\"' />");
			}
			
			out.print("<div><input class=\"searchBar\" type=\"text\" value=\""+search+"\" name=\"key\" placeholder=\"Search for items..\">");
			String makefilter=  (String) request.getParameter("Make Filter");
			String modelfilter=  (String)request.getParameter("Model Filter");
			String colorfilter=  (String)request.getParameter("Color Filter");
			String yearfilter=  (String)request.getParameter("Year Filter");
			String typefilter=  (String)request.getParameter("Type Filter");
			String highfilter = (String)request.getParameter("High Filter");
			String startfilter=  (String)request.getParameter("Start Filter");
			String closefilter = (String)request.getParameter("Close Filter");
			
			if(yearfilter == ""){
				yearfilter= "0";
			}
			if(yearfilter == null){
				yearfilter= "0";
			}
			if(startfilter == null ){
				startfilter= "";
			}
			if(closefilter == null ){
				closefilter= "";
			}
			if(typefilter == null ){
				typefilter= "";
			}
			if(makefilter == null ){
				makefilter= "";
			}
			if(modelfilter == null ){
				modelfilter= "";
			}
			if(colorfilter == null ){
				colorfilter= "";
			}
		%>
		<input id="searchbutt" class="searchButton" type="submit" value="Search" />
		<input type="hidden" name="page" value="0" /></div>
		<div class= "filterbox" >

		<label for="Makefilter">Car Make:</label><br>
		<input type="text" id="Makefilter" name="Make Filter" value='<%out.print(makefilter);%>'><br>
		<label for="Modelfilter">Car Model:</label><br>
		<input type="text" id="Modelfilter" name="Model Filter" value='<%out.print(modelfilter);%>'><br>
		<label for="Colorfilter">Car Color:</label><br>
		<input type="text" id="Colorfilter" name="Color Filter" value='<%out.print(colorfilter);%>'><br>
		<label for="Yearfilter">Car Year:</label><br>
		<input type="text" id="Yearfilter" name="Year Filter" value='<%out.print(yearfilter);%>'><br>
		<label for="Typefilter">Car Type:</label><br>
		<input type="text" id="Typefilter" name="Type Filter" value='<%out.print(typefilter);%>'><br>
		 <label for="Start_filter">Dates After:</label><br>
  		<input type="datetime-local" id="Start_filter" name="Start Filter" value='<%out.print(startfilter);%>'><br>
  		 <label for="Close_filter">Dates Before:</label><br>
  		<input type="datetime-local" id="Close_filter" name="Close Filter" value='<%out.print(closefilter);%>'><br>
		<label for="Highfilter">Price High to Low:</label><br>
		<input type="checkbox" id="Highfilter" name="High Filter"><br>				
		</div>
	</form>
	
	<div class="padding20"></div>
		  <%
		  	try {
				//Get the database connection
				ApplicationDB db = new ApplicationDB();	
				Connection con = db.getConnection();	
				
				//Create a SQL statement
				Statement closestmt = con.createStatement();
				Statement cu = con.createStatement();
				String close = "SELECT vin FROM Auction WHERE Auction.close_date<now();";
				String change = "";
				ResultSet rc = closestmt.executeQuery(close);
				while(rc.next()){
					change  = "UPDATE Auction SET closed = 'true' WHERE Auction.vin = '"+rc.getString("vin")+"';";
					cu.executeUpdate(change);

				}
				rc.close();
				cu.close();
				closestmt.close();
				
				Statement stmt2 = con.createStatement();
				String str2 = "SELECT COUNT(*) FROM Item WHERE make LIKE '%"+search+"%';";
				ResultSet result2 = stmt2.executeQuery(str2);
				
				int pageLimit = 5;
				int numVehicles=0;
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
				Statement stmt3 = con.createStatement();
				
				String str = "";
				
				if(yearfilter.equals("0")){			
					if(startfilter.equals("") == false){
						if(closefilter.equals("") == false){
							str = "SELECT * FROM Auction LEFT JOIN Item ON Auction.vin = Item.vin WHERE Auction.vin LIKE '%"+search+"%' OR Item.color LIKE '%"+search+"%' OR Item.model LIKE '%"+search+"%' OR Item.make LIKE '%"+search+"%' OR Item.car_year LIKE '%"+search+"%' OR Item.car_type LIKE '%"+search+"%' OR Item.car_year = "+yearfilter+" HAVING(Item.make LIKE '%"+makefilter+"%' AND Auction.close_date > '"+startfilter+"' AND Auction.close_date < '"+closefilter+"' AND Item.color LIKE '%"+colorfilter+"%' AND Item.model LIKE '%"+modelfilter+"%') ORDER BY Auction.initial_bidding_price ASC LIMIT "+startIndex+","+pageLimit+";";				
						}
						else{
							str = "SELECT * FROM Auction LEFT JOIN Item ON Auction.vin = Item.vin WHERE Auction.vin LIKE '%"+search+"%' OR Item.color LIKE '%"+search+"%' OR Item.model LIKE '%"+search+"%' OR Item.make LIKE '%"+search+"%' OR Item.car_year LIKE '%"+search+"%' OR Item.car_type LIKE '%"+search+"%' OR Item.car_year = "+yearfilter+" HAVING(Item.make LIKE '%"+makefilter+"%' AND Auction.close_date > '"+startfilter+"' AND Item.color LIKE '%"+colorfilter+"%' AND Item.model LIKE '%"+modelfilter+"%') ORDER BY Auction.initial_bidding_price ASC LIMIT "+startIndex+","+pageLimit+";";							
						}
					}
					else{
						if(closefilter.equals("") == false){
							str = "SELECT * FROM Auction LEFT JOIN Item ON Auction.vin = Item.vin WHERE Auction.vin LIKE '%"+search+"%' OR Item.color LIKE '%"+search+"%' OR Item.model LIKE '%"+search+"%' OR Item.make LIKE '%"+search+"%' OR Item.car_year LIKE '%"+search+"%' OR Item.car_type LIKE '%"+search+"%' OR Item.car_year = "+yearfilter+" HAVING(Item.make LIKE '%"+makefilter+"%' AND Auction.close_date < '"+closefilter+"' AND Item.color LIKE '%"+colorfilter+"%' AND Item.model LIKE '%"+modelfilter+"%') ORDER BY Auction.initial_bidding_price ASC LIMIT "+startIndex+","+pageLimit+";";
						}
						else{
							str = "SELECT * FROM Auction LEFT JOIN Item ON Auction.vin = Item.vin WHERE Auction.vin LIKE '%"+search+"%' OR Item.color LIKE '%"+search+"%' OR Item.model LIKE '%"+search+"%' OR Item.make LIKE '%"+search+"%' OR Item.car_year LIKE '%"+search+"%' OR Item.car_type LIKE '%"+search+"%' OR Item.car_year = "+yearfilter+" HAVING(Item.make LIKE '%"+makefilter+"%' AND Item.color LIKE '%"+colorfilter+"%' AND Item.model LIKE '%"+modelfilter+"%') ORDER BY Auction.initial_bidding_price ASC LIMIT "+startIndex+","+pageLimit+";";
						}	
					}
				}
				else{
					
					if(startfilter.equals("") == false){
						if(closefilter.equals("") == false){
							str = "SELECT * FROM Auction LEFT JOIN Item ON Auction.vin = Item.vin WHERE Auction.vin LIKE '%"+search+"%' OR Item.color LIKE '%"+search+"%' OR Item.model LIKE '%"+search+"%' OR Item.make LIKE '%"+search+"%' OR Item.car_year LIKE '%"+search+"%' OR Item.car_type LIKE '%"+search+"%' OR Item.car_year = "+yearfilter+" HAVING(Item.make LIKE '%"+makefilter+"%' AND Auction.close_date > '"+startfilter+"' AND Item.color LIKE '%"+colorfilter+"%' AND Auction.close_date < '"+closefilter+"' AND Item.model LIKE '%"+modelfilter+"%' AND Item.car_type LIKE '%"+typefilter+"%' AND Item.car_year LIKE '%"+yearfilter+"%' ) ORDER BY Auction.initial_bidding_price ASC  LIMIT "+startIndex+","+pageLimit+";";
						}
						else{
							str = "SELECT * FROM Auction LEFT JOIN Item ON Auction.vin = Item.vin WHERE Auction.vin LIKE '%"+search+"%' OR Item.color LIKE '%"+search+"%' OR Item.model LIKE '%"+search+"%' OR Item.make LIKE '%"+search+"%' OR Item.car_year LIKE '%"+search+"%' OR Item.car_type LIKE '%"+search+"%' OR Item.car_year = "+yearfilter+" HAVING(Item.make LIKE '%"+makefilter+"%' AND Auction.close_date > '"+startfilter+"' AND Item.color LIKE '%"+colorfilter+"%' AND Item.model LIKE '%"+modelfilter+"%' AND Item.car_type LIKE '%"+typefilter+"%' AND Item.car_year LIKE '%"+yearfilter+"%' ) ORDER BY Auction.initial_bidding_price ASC  LIMIT "+startIndex+","+pageLimit+";";
						}
					}	
					else{
						if(closefilter.equals("") == false){
							str = "SELECT * FROM Auction LEFT JOIN Item ON Auction.vin = Item.vin WHERE Auction.vin LIKE '%"+search+"%' OR Item.color LIKE '%"+search+"%' OR Item.model LIKE '%"+search+"%' OR Item.make LIKE '%"+search+"%' OR Item.car_year LIKE '%"+search+"%' OR Item.car_type LIKE '%"+search+"%' OR Item.car_year = "+yearfilter+" HAVING(Item.make LIKE '%"+makefilter+"%' AND Item.color LIKE '%"+colorfilter+"%' AND Item.model LIKE '%"+modelfilter+"%' AND Item.car_type LIKE '%"+typefilter+"%' AND Item.car_year LIKE '%"+yearfilter+"%' AND Auction.close_date < '"+closefilter+"') ORDER BY Auction.initial_bidding_price ASC  LIMIT "+startIndex+","+pageLimit+";";	
						}
						else{
							str = "SELECT * FROM Auction LEFT JOIN Item ON Auction.vin = Item.vin WHERE Auction.vin LIKE '%"+search+"%' OR Item.color LIKE '%"+search+"%' OR Item.model LIKE '%"+search+"%' OR Item.make LIKE '%"+search+"%' OR Item.car_year LIKE '%"+search+"%' OR Item.car_type LIKE '%"+search+"%' OR Item.car_year = "+yearfilter+" HAVING(Item.make LIKE '%"+makefilter+"%' AND Item.color LIKE '%"+colorfilter+"%' AND Item.model LIKE '%"+modelfilter+"%' AND Item.car_type LIKE '%"+typefilter+"%' AND Item.car_year LIKE '%"+yearfilter+"%' ) ORDER BY Auction.initial_bidding_price ASC  LIMIT "+startIndex+","+pageLimit+";";		
						}
					}
				}	
				if(highfilter!=null){
					if(yearfilter.equals("0")){
						if(startfilter.equals("") == false){
							
							if(closefilter.equals("") == false){
								str = "SELECT * FROM Auction LEFT JOIN Item ON Auction.vin = Item.vin WHERE Auction.vin LIKE '%"+search+"%' OR Item.color LIKE '%"+search+"%' OR Item.model LIKE '%"+search+"%' OR Item.make LIKE '%"+search+"%' OR Item.car_year LIKE '%"+search+"%' OR Item.car_type LIKE '%"+search+"%' OR Item.car_year = "+yearfilter+" HAVING(Item.make LIKE '%"+makefilter+"%' AND Auction.close_date > '"+startfilter+"' AND Item.color LIKE '%"+colorfilter+"%' AND Item.model LIKE '%"+modelfilter+"%' AND Auction.close_date < '"+closefilter+"') ORDER BY Auction.initial_bidding_price DESC LIMIT "+startIndex+","+pageLimit+";";
							}
							else{
								str = "SELECT * FROM Auction LEFT JOIN Item ON Auction.vin = Item.vin WHERE Auction.vin LIKE '%"+search+"%' OR Item.color LIKE '%"+search+"%' OR Item.model LIKE '%"+search+"%' OR Item.make LIKE '%"+search+"%' OR Item.car_year LIKE '%"+search+"%' OR Item.car_type LIKE '%"+search+"%' OR Item.car_year = "+yearfilter+" HAVING(Item.make LIKE '%"+makefilter+"%' AND Auction.close_date > '"+startfilter+"' AND Item.color LIKE '%"+colorfilter+"%' AND Item.model LIKE '%"+modelfilter+"%') ORDER BY Auction.initial_bidding_price DESC LIMIT "+startIndex+","+pageLimit+";";
							}
						}
						else{
							if(closefilter.equals("") == false){
								str = "SELECT * FROM Auction LEFT JOIN Item ON Auction.vin = Item.vin WHERE Auction.vin LIKE '%"+search+"%' OR Item.color LIKE '%"+search+"%' OR Item.model LIKE '%"+search+"%' OR Item.make LIKE '%"+search+"%' OR Item.car_year LIKE '%"+search+"%' OR Item.car_type LIKE '%"+search+"%' OR Item.car_year = "+yearfilter+" HAVING(Item.make LIKE '%"+makefilter+"%' AND Item.color LIKE '%"+colorfilter+"%' AND Item.model LIKE '%"+modelfilter+"%' AND Auction.close_date < '"+closefilter+"') ORDER BY Auction.initial_bidding_price DESC LIMIT "+startIndex+","+pageLimit+";";
							}
							else{
								str = "SELECT * FROM Auction LEFT JOIN Item ON Auction.vin = Item.vin WHERE Auction.vin LIKE '%"+search+"%' OR Item.color LIKE '%"+search+"%' OR Item.model LIKE '%"+search+"%' OR Item.make LIKE '%"+search+"%' OR Item.car_year LIKE '%"+search+"%' OR Item.car_type LIKE '%"+search+"%' OR Item.car_year = "+yearfilter+" HAVING(Item.make LIKE '%"+makefilter+"%' AND Item.color LIKE '%"+colorfilter+"%' AND Item.model LIKE '%"+modelfilter+"%') ORDER BY Auction.initial_bidding_price DESC LIMIT "+startIndex+","+pageLimit+";";	
							}
						}
					}
					else{
						if(startfilter.equals("") == false){
							if(closefilter.equals("") == false){
								str = "SELECT * FROM Auction LEFT JOIN Item ON Auction.vin = Item.vin WHERE Auction.vin LIKE '%"+search+"%' OR Item.color LIKE '%"+search+"%' OR Item.model LIKE '%"+search+"%' OR Item.make LIKE '%"+search+"%' OR Item.car_year LIKE '%"+search+"%' OR Item.car_type LIKE '%"+search+"%' OR Item.car_year = "+yearfilter+" HAVING(Item.make LIKE '%"+makefilter+"%' AND Item.color LIKE '%"+colorfilter+"%' AND Item.model LIKE '%"+modelfilter+"%' AND Auction.close_date > '"+startfilter+"' AND Item.car_type LIKE '%"+typefilter+"%' AND Item.car_year LIKE '%"+yearfilter+"%' AND Auction.close_date < '"+closefilter+"') ORDER BY Auction.initial_bidding_price DESC  LIMIT "+startIndex+","+pageLimit+";";	
							}
							else{
								str = "SELECT * FROM Auction LEFT JOIN Item ON Auction.vin = Item.vin WHERE Auction.vin LIKE '%"+search+"%' OR Item.color LIKE '%"+search+"%' OR Item.model LIKE '%"+search+"%' OR Item.make LIKE '%"+search+"%' OR Item.car_year LIKE '%"+search+"%' OR Item.car_type LIKE '%"+search+"%' OR Item.car_year = "+yearfilter+" HAVING(Item.make LIKE '%"+makefilter+"%' AND Item.color LIKE '%"+colorfilter+"%' AND Item.model LIKE '%"+modelfilter+"%' AND Auction.close_date > '"+startfilter+"' AND Item.car_type LIKE '%"+typefilter+"%' AND Item.car_year LIKE '%"+yearfilter+"%' ) ORDER BY Auction.initial_bidding_price DESC  LIMIT "+startIndex+","+pageLimit+";";
							}
						}
						else{
							if(closefilter.equals("") == false){
								str = "SELECT * FROM Auction LEFT JOIN Item ON Auction.vin = Item.vin WHERE Auction.vin LIKE '%"+search+"%' OR Item.color LIKE '%"+search+"%' OR Item.model LIKE '%"+search+"%' OR Item.make LIKE '%"+search+"%' OR Item.car_year LIKE '%"+search+"%' OR Item.car_type LIKE '%"+search+"%' OR Item.car_year = "+yearfilter+" HAVING(Item.make LIKE '%"+makefilter+"%' AND Item.color LIKE '%"+colorfilter+"%' AND Item.model LIKE '%"+modelfilter+"%' AND Item.car_type LIKE '%"+typefilter+"%' AND Item.car_year LIKE '%"+yearfilter+"%' AND Auction.close_date < '"+closefilter+"' ) ORDER BY Auction.initial_bidding_price DESC  LIMIT "+startIndex+","+pageLimit+";";
							}
							else{
								str = "SELECT * FROM Auction LEFT JOIN Item ON Auction.vin = Item.vin WHERE Auction.vin LIKE '%"+search+"%' OR Item.color LIKE '%"+search+"%' OR Item.model LIKE '%"+search+"%' OR Item.make LIKE '%"+search+"%' OR Item.car_year LIKE '%"+search+"%' OR Item.car_type LIKE '%"+search+"%' OR Item.car_year = "+yearfilter+" HAVING(Item.make LIKE '%"+makefilter+"%' AND Item.color LIKE '%"+colorfilter+"%' AND Item.model LIKE '%"+modelfilter+"%' AND Item.car_type LIKE '%"+typefilter+"%' AND Item.car_year LIKE '%"+yearfilter+"%' ) ORDER BY Auction.initial_bidding_price DESC  LIMIT "+startIndex+","+pageLimit+";";
							}
						}
					}
				}
				ResultSet result = stmt.executeQuery(str);
				
				int i = 0;
				%>
				<script>
					var modalArray = [];
					var buttonArray = [];
					var spanArray = [];
				</script>
				<%
				String val = (String) request.getParameter("Make filter");
				while(result.next()){
					String make = result.getString("make");
					String model = result.getString("model");
					String car_type = result.getString("car_type");
					String color = result.getString("color");
					String car_year = result.getString("car_year");
					String increment = result.getString("lbound_increment");
					String vin = result.getString("vin");
					String initial_bid = "$"+ result.getString("initial_bidding_price");
					String close_date = result.getString("close_date");
					String closed_auction = result.getString("closed");	
				%>
					<div class="itemBox" id=<% out.print(vin); %>>
					<div class="items">
					<div class = "headers">
					<table>
					  	<tr>
						    <th>VIN</th>
						    <th>Make</th>
						    <th>Model</th>
						    <th>Car Type</th>
						    <th>Color</th>
						    <th>Car Year</th>	  
						    <th>Current Bid</th>
						    <th>Increment</th>
						    <th>Close Date</th>
					  	</tr>
					<%	
						out.print("<tr>");	
					    	out.print("<td><a href=\"Details.jsp?id="+vin+"\">"+vin+"</a></td>"); 
							out.print("<td>"+make+"</td>");
							out.print("<td>"+model+"</td>");
							out.print("<td>"+car_type+"</td>");
							out.print("<td>"+color+"</td>");
							out.print("<td>"+car_year+"</td>");
							out.print("<td>"+initial_bid+"</td>");
							out.print("<td>"+increment+"</td>");
							out.print("<td>"+close_date+"</td>");	
						out.print("</tr>");
						out.print("</table>");
					%>
					</div>
						<%	
						if(closed_auction!=null){
						%>
						
						<h1 class = "closedauction "> This Auction Is Closed </h1>
						
							
							<%if(sessType!=null && !sessType.equals("Regular")){%>	
								<form method="get" action= DeleteAuction.jsp >
								<input type="hidden" name="vin" value="<% out.print(vin); %>"/>
									<input class="bb_red" type="submit" value="Delete Auction"/>
								</form>	
							<%}%>
							</div>
						<%
						}else{
						%>
							<button class ="bb_blue" id='<% out.print("Button"+vin); %>'>Bid For Item</button>
							<%if(sessType!=null && !sessType.equals("Regular")){%>	
								<form method="get" action= DeleteAuction.jsp >
								<input type="hidden" name="vin" value="<% out.print(vin); %>"/>
									<input class="bb_red" type="submit" value="Delete Auction"/>
								</form>	
							<%}%>
							<div class="modal" id='<% out.print("Modal"+vin); %>'>
		             <!-- Modal content -->a
			             <div class="modal-content">
			                 <span class="close" id='<% out.print("Close"+vin); %>'>&times;</span>
			                 <h3>Place Bid For Item</h3>
   
			             	<form class = "modalq" id='<% out.print("Form"+vin); %>' method="post" action= Bidlogic.jsp >
			             		<input type="checkbox" id = "Auto_bid" name="AB" value="True" >Automatic Bidding<br>
			             		<label for="bidPrice">Bid Price:</label><br>   						
			             		<input type="number" id="bidPrice" name="bidPrice" size="75" maxLength="150" placeholder="Bid Price"/><br>
			             		<label for="increment">Increment:</label><br>
			             		<input type="number" id="increment" name="Increment" size="75" maxLength="150" placeholder="Price Increment "/><br>
			             		<label for="upperLimit">Max:</label><br>
			             		<input type="number" id="upperLimit" name="upper_limit" size="75" maxLength="150" placeholder="Max Amount For Item"/><br>
			             		<input type="hidden" name="vin" value=<% out.print(vin); %> />
			             		<input type="hidden" name="prev" value="<% out.print(prevPath); %>"/>
			                 	<input id = "bidsubmit" type="submit" value="Place Bid"/>
							</form>						
			            </div>
			         	</div>
							<script>
								modalArray.push(document.getElementById("Modal"+<%out.print(vin);%>));
								// Get the button that opens the modal
								buttonArray.push(document.getElementById("Button"+<%out.print(vin);%>));
								spanArray.push(document.getElementById("Close"+<%out.print(vin);%>));
								
								buttonArray[parseInt(<% out.print(i); %>)].onclick = function() {
									modalArray[parseInt(<% out.print(i); %>)].style.display = "block";
								}
								// When the user clicks on <span> (x), close the modal
								spanArray[parseInt(<% out.print(i); %>)].onclick = function() {
									modalArray[parseInt(<% out.print(i); %>)].style.display = "none";
								}
								// When the user clicks anywhere outside of the modal, close it
								window.onclick = function(event) {
									if (event.target == modalArray[parseInt(<% out.print(i); %>)]) {
										modalArray[parseInt(<% out.print(i); %>)].style.display = "none";
									}
								}
							</script>				
						</div>
						<% 
						}
						%>			
					</div>		
				<%
				i++;
				//Automatic Bidding
				Statement bs = con.createStatement();
				Statement ua = con.createStatement();
				String findmax= "select max(Bids.bidding_price) as maxbid , buyer_username FROM Bids WHERE(Bids.vin = '"+vin+"') GROUP BY buyer_username ORDER BY maxbid DESC LIMIT 1"; 

				ResultSet bq = bs.executeQuery(findmax);
				ResultSet person=null;
				if(bq.next()){
					
					int maxbid=0;

					String userauto = "SELECT * FROM Auto_bids WHERE Auto_bids.buyer_username = '"+(String)session.getAttribute("username")+"';";
					person = ua.executeQuery(userauto);
					int person_increment=0;
					int upper_limit=0;
					if(person.next()){
						person_increment = Integer.parseInt(person.getString("increment"));
						upper_limit = Integer.parseInt(person.getString("upper_limit"));
					}
					
					if(bq.getString("maxbid")!=null && bq.getString("buyer_username").equals((String)session.getAttribute("username")) == false){
						maxbid =Integer.parseInt(bq.getString("maxbid"));
						
						if(maxbid<upper_limit && maxbid+person_increment<upper_limit){
							int newbid = maxbid+person_increment;
							String Bidding= "INSERT INTO Bids(buyer_username, vin, bidding_price) VALUES(?,?,?)";
						   	String update = "UPDATE Auction SET initial_bidding_price= '"+newbid+"'WHERE Auction.vin= '"+vin+"';";
						   	PreparedStatement ps= con.prepareStatement(Bidding);
						   	Statement up= con.createStatement();
						   	ps.setString(1, (String)session.getAttribute("username"));
							ps.setString(2, vin);
							ps.setInt(3, newbid);
							ps.executeUpdate();
							up.executeUpdate(update);
						}
						
					}
					bq.close();
					bs.close();
					person.close();
					ua.close();
					}
				}
				//close the connection.
				result.close();
				stmt.close();
				con.close();
				if(i==0){
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
						out.print("<a class=\"pageNum\" href=\"Search.jsp?key="+key+"&page="+(pagenumber-1)+"\">previous</a>");
					}
					out.print("<a class=\"pageNum\" href=\"Search.jsp?key="+key+"&page="+(pagenumber)+"\">"+pagenumber+"</a>");
					if(pagenumber < (int)((numRows-1)/pageLimit)){
						out.print("<a class=\"pageNum\" href=\"Search.jsp?key="+key+"&page="+(pagenumber+1)+"\">next</a>");
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