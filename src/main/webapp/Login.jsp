<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<title>Sign In</title>
	<link href="styles.css" rel="stylesheet">
	<div class="topnav">
		<a class="logo" href="Home.jsp"><img src="BuyMeLogo.png" width = "auto" height = "35"></a>
		<div class="topnav-right">
		</div>
	</div>
</head>
<body>
    <h1>Sign in</h1>
    <div class="sign_in">
    <% 
    	String prevPage = request.getParameter("prev");
		if(prevPage==null){
			out.print("<form method=\"post\" action=\"LoginLogic.jsp?\">");
		}
		else{
			String pageNum = request.getParameter("page");
			String id = request.getParameter("id");
			if(pageNum==null && id==null){
				out.print("<form method=\"post\" action=\"LoginLogic.jsp?prev="+prevPage+"\" />");
			}
			else if(pageNum==null && id!=null){
				out.print("<form method=\"post\" action=\"LoginLogic.jsp?prev="+prevPage+"&id="+id+"\" />");
			}
			else{
				out.print("<form method=\"post\" action=\"LoginLogic.jsp?prev="+prevPage+"&page="+pageNum+"\" />");
			}
		}
	%>
      <label for="username">Username:</label><br>
      <input type="text" id="username" name="login username"><br>
      <label for="password">Password</label><br>
      <input type="password" id="password" name="login password"><br>
      <input class="bb_blue" type="submit" value="Sign In" />
      <%
      	String displayMessage = request.getParameter("displayMessage");
    	if(displayMessage!=null){
    		out.print("<h5>Username or password is incorrect</h5>");
    	}
      %>
      </form>
       
    </div>
  
    <p>Not Registered? <a href="CreateAcc.jsp">Create Account</a></p>
    
</body>
</html>