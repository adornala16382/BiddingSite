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
      <form method="post" action="LoginLogic.jsp">
      <label for="username">Username:</label><br>
      <input type="text" id="username" name="login username"><br>
      <label for="password">Password</label><br>
      <input type="text" id="password" name="login password"> <br>
      <input type="submit" value="Sign In" />
      </form>
       
    </div>

  
    <p>Not Registered? <a href="CreateAcc.jsp">Create Account</a></p>
    </form>
    
</body>
</html>