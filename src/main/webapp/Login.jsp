<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<title>Sign In</title>
	<link href="styles.css" rel="stylesheet">
</head>
<body>
    <h1>Sign in</h1>
    <div class="sign_in">
    <% 
    	String prevPage = request.getParameter("prev");
		String prevPath;
		if(prevPage==null){
			prevPath = "";
		}
		else{
			prevPath = prevPage;
		}
		out.print("<form method=\"post\" action=\"LoginLogic.jsp?prev="+prevPage+"\">");
	%>
      <label for="username">Username:</label><br>
      <input type="text" id="username" name="login username"><br>
      <label for="password">Password</label><br>
      <input type="text" id="password" name="login password"><br>
      <input type="submit" value="Sign In" />
      <%
      	String displayMessage = request.getParameter("displayMessage");
    	if(displayMessage!=null){
    		out.print("<h5>Username or password is incorrect</h5>");
    	}
      %>
      </form>
       
    </div>

  
    <p>Not Registered? <a href="CreateAcc.jsp">Create Account</a></p>
    </form>
    
</body>
</html>