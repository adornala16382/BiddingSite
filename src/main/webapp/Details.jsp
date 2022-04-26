<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Profile</title>
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
	<form method="get" action="Search.jsp">
			<input class="searchBar" type="text" name="key" placeholder="Search for items..">
			<input class="searchButton" type="submit" value="Search" />
			<input type="hidden" name="page" value="0" />
	</form>
	<div class="padding20"></div>
	<div class="detailBox">
	<%
		String id = request.getParameter("id");
		out.print(id);
	%>
	</div>
         <!-- Trigger/Open The Modal -->
         <button id="myBtn">Ask a question</button>

         <!-- The Modal -->
         <div id="myModal" class="modal">

             <!-- Modal content -->
             <div class="modal-content">
                 <span class="close">&times;</span>
                 <h3>Type question below</h3>
             	<form method="post" action="AddQuestion.jsp">
             		<input type="text" name="question" size="75" maxLength="150" placeholder="type here"/><br>
             		<input type="hidden" name="id" value="<%out.print(id);%>"/>
             		<input type="hidden" name="prev" value="<%out.print(prevPath);%>"/>
                 	<input type="submit" value="Submit" />
				</form>
             </div>
         </div>
         <script>
             var modal = document.getElementById("myModal");

             // Get the button that opens the modal
             var btn = document.getElementById("myBtn");

             // Get the <span> element that closes the modal
             var span = document.getElementsByClassName("close")[0];

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
	<%
	try {
		
		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();	
		
		//Create a SQL statement
		Statement stmt = con.createStatement();
		String str = "SELECT * FROM Question WHERE vin='"+id+"';";
		//Run the query against the database.
		ResultSet result = stmt.executeQuery(str);
		while(result.next()){
			String question = result.getString("question");
			String username = result.getString("username");
			
			out.print("<div>");
			out.print("<p>Q: "+question+"</p>");
			out.print("<p>By: "+username+"</p>");
			out.print("</div>");
		}
		//close the connection.
		result.close();
		stmt.close();
		con.close();
	}catch (Exception ex) {
		out.print("Something went wrong");
		out.print(ex);
	}
	%>
</body>
</html>