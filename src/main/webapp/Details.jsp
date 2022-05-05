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
	<% 
	String sessType = (String)session.getAttribute("type");
	if(sessType!=null && sessType.equals("Regular")){ %>
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
     <%} %>
     <div class="padding20"> </div>
     <div class="QnAouter">
	 <h3>Customer questions & answers</h3>
	<script>
		var modalArray = [];
		var buttonArray = [];
		var spanArray = [];
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
		int count = 0;
		while(result.next()){
			String question = result.getString("question");
			String username = result.getString("username");
			int qid = Integer.parseInt(result.getString("qid"));
			
			out.print("<div class=\"QnAquestion\"><h4>Q: "+question+"</h4>");
			out.print("<div class=\"qBy\"><p>By: "+username+"</p></div></div>");
			Statement stmt2 = con.createStatement();
			String str2 = "SELECT * FROM Answer WHERE qid='"+qid+"';";
			//Run the query against the database.
			ResultSet result2 = stmt2.executeQuery(str2);
			while(result2.next()){
				String answer = result2.getString("answer");
				String CRusername = result2.getString("username");
				out.print("<div class=\"QnAanswer\"><h4>A: "+answer+"</h4>");
				out.print("<p>By: "+CRusername+"</p></div>");
			}
			result2.close();
			stmt2.close();
			if(sessType!=null && !sessType.equals("Regular")){ %>
	         <!-- Trigger/Open The Modal -->
	         <div class="qButtonDiv"><button class="qButton" id=<%out.print("myBtn"+count);%>>Reply</button></div>

	         <!-- The Modal -->
	         <div id=<%out.print("modal"+count);%> class="modal">

	             <!-- Modal content -->
	             <div class="modal-content">
	                 <span class="close" id=<%out.print("close"+count);%>>&times;</span>
	                 <h3><%out.print("Q: "+question);%></h3>
	             	<form method="post" id=<%out.print("form"+count);%> action="AddAnswer.jsp">
	             		<input type="text" name="answer" size="75" maxLength="150" placeholder="Your answer"/><br>
	             		<input type="hidden" name="qid" value="<%out.print(qid);%>"/>
	             		<input type="hidden" name="prev" value="<%out.print(prevPath);%>"/>
	                 	<input type="submit" value="Submit" />
					</form>
	             </div>
	         </div>
	         <script>
	             modalArray.push(document.getElementById("modal"+<%out.print(count);%>));

	             // Get the button that opens the modal
	             buttonArray.push(document.getElementById("myBtn"+<%out.print(count);%>));

	             // Get the <span> element that closes the modal
	             spanArray.push(document.getElementById("close"+<%out.print(count);%>));

	             // When the user clicks on the button, open the modal
				buttonArray[parseInt(<% out.print(count); %>)].onclick = function() {
					modalArray[parseInt(<% out.print(count); %>)].style.display = "block";
				}
				// When the user clicks on <span> (x), close the modal
				spanArray[parseInt(<% out.print(count); %>)].onclick = function() {
					modalArray[parseInt(<% out.print(count); %>)].style.display = "none";
				}
				// When the user clicks anywhere outside of the modal, close it
				window.onclick = function(event) {
					if (event.target == modalArray[parseInt(<% out.print(count); %>)]) {
						modalArray[parseInt(<% out.print(count); %>)].style.display = "none";
					}
				}
	         </script>
	     <%}
			count++;
			out.print("<div class=\"padding20\"></div>");
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
	</div>
</body>
</html>