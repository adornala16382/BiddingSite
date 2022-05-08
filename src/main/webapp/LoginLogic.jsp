<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Login Logic</title>
	<link href="styles.css" rel="stylesheet">
</head>
<body>
	<% 
		try {

			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();	
			
			//Create a SQL statement
			Statement stmt = con.createStatement();
			//Get the combobox from the index.jsp
			String username = request.getParameter("login username");
			String password = request.getParameter("login password");
			//Make a SELECT query from the sells table with the price range specified by the 'price' parameter at the index.jsp
			String str = "SELECT COUNT(*) FROM Account WHERE username='"+username+"' AND password='"+password+"'";
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);
			
			if(result.next()){
				String prevPage = request.getParameter("prev");
				if(result.getString("COUNT(*)").equals("1")==true){
					String type = "Regular";
			        request.getSession();  
			        session.setAttribute("username",username);
			        session.setAttribute("visits","0");
					result.close();
					stmt.close();
					
					Statement stmt3 = con.createStatement();
					String str3 = "SELECT type FROM Account WHERE username='"+username+"';";
					ResultSet result3 = stmt3.executeQuery(str3);
					if(result3.next()){
						if(result3.getString("type")!=null){
							if(result3.getString("type").equals("CustomerRep")==true){
								type = "Customer Representative";
							}
							else if(result3.getString("type").equals("Admin")==true){
								type = "Admin";
							}
						}
					}
					result3.close();
					stmt3.close();
					
					session.setAttribute("type",type);
					
					if(prevPage==null){
						out.print("<meta http-equiv='Refresh' content='0; url=\"Home.jsp\"' />");
					}
					else{
						String pageNum = request.getParameter("page");
						String id = request.getParameter("id");
						if(pageNum==null && id==null){
							out.print("<meta http-equiv='Refresh' content='0; url=\""+prevPage+"\"' />");
						}
						else if(pageNum==null && id!=null){
							out.print("<meta http-equiv='Refresh' content='0; url=\""+prevPage+"&id="+id+"\"' />");
						}
						else{
							out.print("<meta http-equiv='Refresh' content='0; url=\""+prevPage+"&page="+pageNum+"\"' />");
						}

					}
				}
				else{
		        	String prevParam = request.getQueryString();
		        	String prevPath;
		        	if(prevParam==null){
		        		prevPath = "";
		        	}
		        	else{
		        		prevPath = "Login.jsp?"+prevParam;
		        	}
					out.print("<meta http-equiv='Refresh' content='0; url=\""+prevPath+"&displayMessage=true\"' />");
				}
			}
			else{
				out.print("Something went wrong");
			}

			//close the connection.
			con.close();
			
		} catch (Exception ex) {
			out.print(ex);
		}
	%>

</body>
</html>