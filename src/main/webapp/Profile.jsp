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
	        	out.print("<a href=\"Alerts.jsp?prev="+prevPath+"\">Alerts</a>");
	        	out.print("<a href=\"Sellitem.jsp?prev="+prevPath+"\">Sell Car</a>");
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
	<% 	
	    if(session.getAttribute("username")!=null){  
	        String username=(String)session.getAttribute("username");
	        out.print("<h3>Username: "+username+"</h3>");
	        String type = (String)session.getAttribute("type");
	        if(type!=null){
	        	out.print("<h4>Account type: "+type+"</h4>");
	        	if(type.equals("Admin")){
	        		out.print("<form method=\"post\" action=\"CreateAcc.jsp\" />");
	        		out.print("<input type=\"submit\" value=\"Create Customer Representative\" />");
	        		out.print("<input type=\"hidden\" name=\"CustomerRep\" value=\"True\" /></form>");
	        	}
	        }
	      %>
	      <div class="padding20"></div>
	      	<form method="get" action="ViewAccountActivity.jsp">
	      	<input class="bb_blue" type="submit" value="View Account Activity">
	      	<input type="hidden" name="username" value="<%out.print(username);%>"></form>
	      	<div class="padding10"></div>
            <!-- Trigger/Open The Modal -->
            <button id="myBtn" class="bb_red">Delete Account</button>

            <!-- The Modal -->
            <div id="myModal" class="modal">

                <!-- Modal content -->
                <div class="modal-content">
                    <span id="close" class="close">&times;</span>
                    <h3>Are you sure you want to delete your account?</h3>
                	<form method="post" action="DeleteAcc.jsp">
                    	<input class="bb_red" type="submit" value="Confirm" />
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
	    <% }
	    else{  
        	out.print("<a href=\"Login.jsp\">Sign In</a>"); 
        }  
	%>
</body>
</html>