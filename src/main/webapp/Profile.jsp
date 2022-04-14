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
		<a class="active" href="Home.jsp">Home</a>
		<div class="topnav-right">
			<% 	
		        if(session.getAttribute("username")!=null){  
					String username=(String)session.getAttribute("username");
		        	out.print("<a>Welcome "+username+"</a>"); 
					%>
		        	<a href="LogoutLogic.jsp">Sign Out</a>
					<a href="Profile.jsp">Profile</a>
		        <%}  
		        else{  
		        	out.print("<a href=\"Login.jsp\">Sign In</a>");
		        }    
			%>
		</div>
	</div>
</head>
<body>
	<% 	
	    if(session.getAttribute("username")!=null){  
	        String username=(String)session.getAttribute("username");
	        out.print("<h3>Username: "+username+"</h3>");
	      %>
            <!-- Trigger/Open The Modal -->
            <button id="myBtn">Delete Account</button>

            <!-- The Modal -->
            <div id="myModal" class="modal">

                <!-- Modal content -->
                <div class="modal-content">
                    <span class="close">&times;</span>
                    <h3>Are you sure you want to delete your account?</h3>
                    <button><a href="DeleteAcc.jsp">Confirm</a></button>
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
	    <% }
	    else{  
        	out.print("<a href=\"Login.jsp\">Sign In</a>"); 
        }  
        out.close();  
	%>
</body>
</html>