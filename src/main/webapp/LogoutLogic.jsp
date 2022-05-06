<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Logout</title>
	<link href="styles.css" rel="stylesheet">
</head>
<body>
	<% 
	    session.invalidate();
		String prevPage = request.getParameter("prev");
		String pageNum = request.getParameter("page");
		String id = request.getParameter("id");
		if(prevPage==null){
			out.print("<meta http-equiv='Refresh' content='0; url=\"Home.jsp\"' />");
		}
		else if(pageNum==null && id==null){
			out.print("<meta http-equiv='Refresh' content='0; url=\""+prevPage+"\"' />");
		}
		else if(pageNum==null && id!=null){
			out.print("<meta http-equiv='Refresh' content='0; url=\""+prevPage+"&id="+id+"\"' />");
		}
		else{
			out.print("<meta http-equiv='Refresh' content='0; url=\""+prevPage+"&page="+pageNum+"\"' />");
		}

	%>
</body>
</html>