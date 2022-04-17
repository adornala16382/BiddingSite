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
	<input type="text" id="myInput" onkeyup="myFunction()" placeholder="Search for items..">
		<table id="myTable">
		  <tr class="header">
		    <th style="width:30%;">Name</th>
		    <th style="width:60%;">Current Bid</th>
		  </tr>
		  <%
		  	try {

				//Get the database connection
				ApplicationDB db = new ApplicationDB();	
				Connection con = db.getConnection();	
				
				//Create a SQL statement
				Statement stmt = con.createStatement();
				//Get the combobox from the index.jsp
				//Make a SELECT query from the sells table with the price range specified by the 'price' parameter at the index.jsp
				String str = "SELECT model FROM Test;";
				//Run the query against the database.
				ResultSet result = stmt.executeQuery(str);
				
				while(result.next()){
					String model = result.getString("model");
					//String id = result.getString("id");
					//String curBid = result.getString("curBid");
					//String seller = result.getString("seller");
					%>
					<tr>
						<td>
						<% out.print("<a href=\"Details.jsp?id="+model+"\">"); %>
						<% out.print(model); %>
						</a>
						</td>
						<td>
						<% out.print("<button>Place Bid</button>"); %>
						</td>
						<td>
						<% out.print("Seller"); %>
						</td>
					<tr>
				<%
				}
				//close the connection.
				result.close();
				stmt.close();
				con.close();
			}catch (Exception ex) {
				out.print(ex);
			}	  
		  %>
		</table>
	<script>
		function myFunction() {
		  // Declare variables
		  var input, filter, table, tr, td, i, txtValue;
		  input = document.getElementById("myInput");
		  filter = input.value.toUpperCase();
		  table = document.getElementById("myTable");
		  tr = table.getElementsByTagName("tr");
		
		  // Loop through all table rows, and hide those who don't match the search query
		  for (i = 0; i < tr.length; i++) {
		    td = tr[i].getElementsByTagName("td")[0];
		    if (td) {
		      txtValue = td.textContent || td.innerText;
		      if (txtValue.toUpperCase().indexOf(filter) > -1) {
		        tr[i].style.display = "";
		      } else {
		        tr[i].style.display = "none";
		      }
		    }
		  }
		}
	</script>
</body>
</html>