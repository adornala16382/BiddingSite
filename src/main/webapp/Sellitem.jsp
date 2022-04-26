<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>SellItem</title>
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
<h1>Enter Item Information To Sell</h1>

<form class= "iteminputs" action="SellitemLogic.jsp">
  <label for="Car_Make">Car Make:</label><br>
  <input type="text" id="Car_make" name="Car Make"><br>
  <label for="Car_Model">Car Model:</label><br>
  <input type="text" id="Car_model" name="Car Model"><br>
  <label for="Car_Type">Car Type:</label><br>
  <input type="text" id="Car_type" name="Car Type"><br>
  <label for="Car_Year">Car Year:</label><br>
  <input type="number" id="Car_Year" name="Car Year"><br>
  <label for="Car_Color">Car Color:</label><br>
  <input type="text" id="Car_Color" name="Car Color"><br>
  <label for="Vin">Car Vin:</label><br>
  <input type="text" id="Vin" name="Car Vin"><br>
  <label for="Close_date">Close Date:</label><br>
  <input type="datetime-local" id="Close_date" name="Close Date"><br>
  <label for="Start_Bid">Starting Bid:</label><br>
  <input type="number" id="Start_Bid" name="Starting Bid"><br>
   <label for="Lower_Increment">Lower Increment Bound:</label><br>
  <input type="number" id="Lower_Increment" name="Lower Increment Bound"><br>
  <label for="Start_Min">Secret Min:</label><br>
  <input type="number" id="Start_Min" name="Secret Min"><br>
  <input type="submit" value="Sell Item" />
</form>


</body>
</html> 