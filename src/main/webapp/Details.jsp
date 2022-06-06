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
			String sessType = (String)session.getAttribute("type");
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
	        	out.print("<a href=\"Sellitem.jsp?prev="+prevPath+"\">Sell Vehicle</a>");
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
		ApplicationDB db3 = new ApplicationDB();	
		Connection con3 = db3.getConnection();
		String id = request.getParameter("id");
		String curr_auction = "SELECT * FROM Auction WHERE Auction.vin = '"+id+"';";
        String maxbid = "SELECT buyer_username as name ,vin,  MAX(bidding_price) as maxb FROM Bids WHERE Bids.vin = '"+id+"' GROUP BY Bids.buyer_username,Bids.vin; ";
        Statement cs = con3.createStatement();
        ResultSet cd = cs.executeQuery(curr_auction);
        Statement ms = con3.createStatement();
        ResultSet md = ms.executeQuery(maxbid);
        String closed=  "";

        int secretmin =0;
        while(cd.next()){
             closed=  cd.getString("closed");
             secretmin = cd.getInt("secret_min");

        }
        String winner = "";
        int finalbid =0;
        if(md.next()){
             winner = md.getString("name");
             finalbid = md.getInt("maxb");

        }
        if(finalbid>=secretmin){
            out.print("<h1>"+winner+" Has Won The Auction With a Final Bid of $"+finalbid+" </h1>");
        }
        else{
        	out.print("<h1> No Winner</h1>");
        }
        cs.close();
        cd.close();
        ms.close();
        md.close();
        con3.close();
		%>
	</div>
        <!-- Trigger/Open The Modal -->
        <button class="bb_blue" id="historyBtn">History of Bids</button>

        <!-- The Modal -->
        <div id="historyModal" class="modal">

            <!-- Modal content -->
            <div class="modal-content">
                <span id="historyClose" class="close">&times;</span>
                <h3>History</h3>
                <div class="historyDiv">
	                <table class="historyTable">
					  <tr>
					    <th>Bidder Username</th>
					    <th>Price($)</th>
					    <th>Time</th>
					    <%if(sessType!=null && !sessType.equals("Regular")){
					    	out.print("<th>Action</th>");
					    }
					    %>
					  </tr>
					  <%
						//Get the database connection
						ApplicationDB db2 = new ApplicationDB();	
						Connection con2 = db2.getConnection();	
						
						//Create a SQL statement
						Statement historyStmt = con2.createStatement();
						String historyStr = "SELECT * FROM Bids WHERE vin='"+id+"'";
						
						ResultSet historyResult = historyStmt.executeQuery(historyStr);
						while(historyResult.next()){
							String buyer_username = historyResult.getString("buyer_username");
							String bidding_price = historyResult.getString("bidding_price");
							String bidding_time = historyResult.getString("bidding_time");
							String vin = historyResult.getString("vin");
							out.print("<tr><td>"+buyer_username+"</td>");
							out.print("<td>"+bidding_price+"</td>");
							out.print("<td>"+bidding_time+"</td>");
							if(sessType!=null && !sessType.equals("Regular")){
							out.print("<td><button class='remove'><a href='removeBid.jsp?username="+buyer_username+"&vin="+id+"&price="+bidding_price+"'>Remove</a></button></td></tr>");
							}
						}
						//close the connection.
						historyResult.close();
						historyStmt.close();
						con2.close();
					  %>
					</table>
				</div>
            </div>
        </div>
        <script>
            var historyModal = document.getElementById("historyModal");

            // Get the button that opens the modal
            var historyBtn = document.getElementById("historyBtn");

            // Get the <span> element that closes the modal
            var historySpan = document.getElementById("historyClose");

            // When the user clicks on the button, open the modal
            historyBtn.onclick = function() {
            	historyModal.style.display = "block";
            }

            // When the user clicks on <span> (x), close the modal
            historySpan.onclick = function() {
            	historyModal.style.display = "none";
            }

            // When the user clicks anywhere outside of the modal, close it
            window.onclick = function(event) {
	             if (event.target == historyModal) {
	                 historyModal.style.display = "none";
	             }
            }
        </script>			
	<% 
	if(sessType!=null && sessType.equals("Regular")){ %>
         <!-- Trigger/Open The Modal -->
         <button class="bb_blue" id="myBtn">Ask a question</button>

         <!-- The Modal -->
         <div id="myModal" class="modal">

             <!-- Modal content -->
             <div class="modal-content">
                 <span id="close" class="close">&times;</span>
                 <h3>Type question below</h3>
             	<form method="post" action="AddQuestion.jsp">
             		<input type="text" name="question" size="75" maxLength="150" placeholder="type here"/><br>
             		<input type="hidden" name="id" value="<%out.print(id);%>"/>
             		<input type="hidden" name="prev" value="<%out.print(prevPath);%>"/>
                 	<input class="bb_blue" type="submit" value="Submit" />
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
     <%} %>
     <div class="padding20"> </div>
     <div class="QnAouter">
	 <h3>Customer questions & answers</h3>
	 <form method="get" action="Details.jsp?">
		<% String search = request.getParameter("key"); 
			if(search==null){
				search = "";
			}
			out.print("<input class=\"searchBar\" type=\"text\" value=\""+search+"\" name=\"key\" placeholder=\"Search for questions and answers...\">");
		%>
		<input class="searchButton" type="submit" value="Search" />
		<input type="hidden" name="id" value="<%out.print(id);%>" />
	</form>
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
		Statement newStmt = con.createStatement();
		String str = "CREATE TEMPORARY TABLE T("
                + "select q.question,q.vin,q.qid,a.answer,q.qUsername,a.aUsername from question q "
                + "left outer join answer a "
                + "on q.qid = a.qid "
                + "union all "
                + "(select q.question,q.vin,q.qid,a.answer,q.qUsername,a.aUsername from answer a "
                + "left outer join question q "
                + "on a.qid = q.qid "
                + "where q.qid IS NULL)"
                + ");";
        String newStr = "select * from t "
                + "where t.vin="+id+" and (t.question LIKE '%"+search+"%' or t.answer LIKE '%"+search+"%');";
        stmt.executeUpdate(str);
        ResultSet result = newStmt.executeQuery(newStr);
        int count = 0;
        HashSet<Integer> set = new HashSet<>();
        while(result.next()){
            String question = result.getString("question");
            String username = result.getString("qUsername");
            int qid = Integer.parseInt(result.getString("qid"));
            boolean added = set.add(qid);
            if(!added) { continue; }
			out.print("<div class=\"QnAquestion\"><h4>Q: "+question+"</h4>");
			out.print("<div class=\"qBy\"><p>By: "+username+"</p></div>");
			if(sessType!=null && !sessType.equals("Regular")){
			%>
			<form method="get" action="DeleteQuestion.jsp">
				<input type="hidden" name="qid" value="<%out.print(qid);%>"/>
				<input type="hidden" name="id" value="<%out.print(id);%>"/>
				<input class="bb_red" type="submit" value="DELETE" />
			</form>
			<%
			}
			out.print("</div>");
			Statement stmt2 = con.createStatement();
			String str2 = "SELECT * FROM Answer WHERE qid='"+qid+"';";
			//Run the query against the database.
			ResultSet result2 = stmt2.executeQuery(str2);
			while(result2.next()){
				String answer = result2.getString("answer");
				String CRusername = result2.getString("aUsername");
				out.print("<div class=\"QnAanswer\"><h4>A: "+answer+"</h4>");
				out.print("<p>By: "+CRusername+"</p></div>");
			}
			result2.close();
			stmt2.close();
			if(sessType!=null && !sessType.equals("Regular")){ %>
	         <!-- Trigger/Open The Modal -->
	         <div class="qButtonDiv"><button class="bb_blue" id=<%out.print("myBtn"+count);%>>Reply</button></div>

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
	                 	<input class="bb_blue" type="submit" value="Submit" />
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
		Statement finalStmt = con.createStatement();
		String finalStr = "DROP TABLE T;";
		finalStmt.executeUpdate(finalStr);
		
		if(count==0){
			out.print("No questions and answers");
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