<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Alerts</title>
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
	<div class="padding50"></div>
	<button id="myBtn" class="bb_red">Create Alert</button>

          <!-- The Modal -->
          <div id="myModal" class="modal">

              <!-- Modal content -->
              <div class="modal-content">
                  <span id="close" class="close">&times;</span>
                  <h3>Create an Alert for a vehicle</h3>
              	<form method="post" action="createAlert.jsp">
              	<label for="Car_Make">Car Make:</label><br>
				  <input type="text" id="Car_make" name="Car Make"><br>
				  <label for="Car_Model">Car Model:</label><br>
				  <input type="text" id="Car_model" name="Car Model"><br>
				  <label for="Car_Type">Car Type:</label><br>
				  <input type="text" id="Car_type" name="Car Type"><br>
				  <label for="Car_Color">Car Color:</label><br>
				  <input type="text" id="Car_Color" name="Car Color"><br>
                  	<input class="bb_blue" type="submit" value="Confirm" />
			</form>
              </div>
          </div>
          <script>
              var modal = document.getElementById("myModal");

              // Get the button that opens the modal
              var btn = document.getElementById("myBtn");

              // Get the <span> element that closes the modal
              var span = document.getElementById("close");

              // When the user clicks on the button, open the modal
              btn.onclick = function() {
              modal.style.display = "block";
              }

              // When the user clicks on <span> (x), close the modal
              span.onclick = function() {
              modal.style.display = "none";
              }

              // When the user clicks anywhere outside of the modal, close it
              window.onclick = function(event) {
              if (event.target == modal) {
                  modal.style.display = "none";
              }
          }
          </script>
<div class="padding20"></div>
<br>
<button id="myBtn2" class="bb_blue">Edit Alerts</button>

          <!-- The Modal -->
          <div id="myModal2" class="modal">

              <!-- Modal content -->
              <div class="modal-content">
                  <span id="close2" class="close">&times;</span>
				<div class="alertDiv">
				<h3>Edit Alerts</h3>
			       <table class="alertTable">
					  <tr>
					    <th>Username</th>
					    <th>Color</th>
					    <th>Make</th>
					    <th>Model</th>
					    <th>Vehicle Type</th>
					    <th>Action</th>
					  </tr>
					<%
					try {
						//Get the database connection
						ApplicationDB db = new ApplicationDB();	
						Connection con = db.getConnection();
				
						//Create a SQL statement
						Statement stmt = con.createStatement();
						String username= (String)session.getAttribute("username");
						//Make an insert statement for the Account table:
						String str = "SELECT * FROM Alert WHERE alert_username='"+username+"'";
						
						//Create a Prepared SQL statement allowing you to introduce the parameters of the query
						ResultSet result = stmt.executeQuery(str);
						//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
						while(result.next()){
							String alert_username = result.getString("alert_username");
							String model = result.getString("model");
							String make = result.getString("make");
							String car_type = result.getString("car_type");
							String color = result.getString("color");
							out.print("<tr><td>"+alert_username+"</td>");
							out.print("<td>"+color+"</td>");	
							out.print("<td>"+make+"</td>");
							out.print("<td>"+model+"</td>");
							out.print("<td>"+car_type+"</td>");
							out.print("<td><button class='remove'><a href='removeAlert.jsp?username="+alert_username+"&model="+model+"&make="+make+"&car_type="
									+car_type+"&color="+color+"'>Remove</a></button></td></tr>");
						}
				
						//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
						result.close();
						stmt.close();
						con.close();					
					} catch (Exception ex) {
						out.print("Something went wrong: ");
						out.print(ex);
					}
					%>
					</table>
				</div>
              </div>
          </div>
          <script>
              var modal2 = document.getElementById("myModal2");

              // Get the button that opens the modal
              var btn2 = document.getElementById("myBtn2");

              // Get the <span> element that closes the modal
              var span2 = document.getElementById("close2");

              // When the user clicks on the button, open the modal
              btn2.onclick = function() {
              modal2.style.display = "block";
              }

              // When the user clicks on <span> (x), close the modal
              span2.onclick = function() {
              modal2.style.display = "none";
              }

              // When the user clicks anywhere outside of the modal, close it
              window.onclick = function(event) {
              if (event.target == modal2) {
                  modal2.style.display = "none";
              }
          }
          </script>
          <%
          try {
				//Get the database connection
				ApplicationDB db = new ApplicationDB();	
				Connection con = db.getConnection();	
				String username=(String)session.getAttribute("username");
				//Create a SQL statement
				Statement stmt = con.createStatement();
				String str = "SELECT * FROM Alert WHERE alert_username='"+username+"';";
				ResultSet result = stmt.executeQuery(str);
				while(result.next()){
					String alert_username = result.getString("alert_username");
					String model = result.getString("model");
					String make = result.getString("make");
					String car_type = result.getString("car_type");
					String color = result.getString("color");
					String name = color+" "+model+" "+make+" "+car_type;
					//
					out.print("<h3>Alerts for "+name+"</h3>");
					%> <table class="alertTable2">
						<tr>
					    <th>Seller Name</th>
					    <th>VIN</th>
					    <th>Make</th>
					    <th>Model</th>
					    <th>Color</th>
					    <th>Vehicle Type</th>
					    <th>Current Price</th>
					  </tr><%
						Statement stmt2 = con.createStatement();
						String str2 = "SELECT MAX(bidding_price) AS curPrice, Auction.vin, Auction.seller_name,Item.model, Item.make, Item.color, Item.car_type, Item.car_year, Auction.initial_bidding_price FROM Auction"
								+" JOIN Item"
								+" ON Auction.vin=Item.vin"
								+" LEFT JOIN Bids"
								+" ON Auction.vin=Bids.vin"
								+" WHERE Item.model LIKE '%"+model+"%' AND Item.make LIKE '%"+make+"%' AND Item.car_type LIKE '%"+car_type+"%' AND Item.color LIKE '%"+color+"%';";
						ResultSet result2 = stmt2.executeQuery(str2);
						while(result2.next()){
							String vin = result2.getString("vin");
							if(vin!=null){
								String seller_name = result2.getString("seller_name");
								String curPrice = result2.getString("curPrice");
								if(curPrice==null){
									curPrice = result2.getString("initial_bidding_price");
								}
								String model2 = result.getString("model");
								String make2 = result.getString("make");
								String car_type2 = result.getString("car_type");
								String color2 = result.getString("color");	
								out.print("<tr>");
								out.print("<td>"+seller_name+"</td>");
								out.print("<td><a href=Details.jsp?id="+vin+">"+vin+"</a></td>");
								out.print("<td>"+make2+"</td>");
								out.print("<td>"+model2+"</td>");
								out.print("<td>"+color2+"</td>");
								out.print("<td>"+car_type2+"</td>");
								out.print("<td>"+curPrice+"</td>");
								out.print("</tr>");
							}
						}
						%></table><div class="padding50"></div><%
					result2.close();
					stmt2.close();
				}
				result.close();
				stmt.close();
				con.close();				
			} catch (Exception ex) {
				out.print("Something went wrong: ");
				out.print(ex);
			}
			%>
</body>
</html>