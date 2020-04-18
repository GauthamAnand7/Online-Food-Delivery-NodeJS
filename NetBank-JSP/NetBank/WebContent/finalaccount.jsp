<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*,bankingsystem.netbank" errorPage="" %>
 <%
//java Code
String uname = request.getParameter("uname");
int accno = Integer.parseInt(request.getParameter("accno"));
String acc_type = request.getParameter("acc_type");
String details = request.getParameter("details");
String sql = "INSERT INTO acc_details VALUES ("+accno+",'"+uname+"','"+acc_type+"','"+details+"')";
//System.out.println(sql);
int update = netbank.update(sql);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Net Banking</title>
</head>
<body>
<table>
<tr>
<td width="160" >
<div id="ddblueblockmenu">
  <div class="menutitle">Account Operations</div>
  <ul>
    <li><a href="main.jsp">Welcome,&nbsp;<%= (String)session.getAttribute("cust_name")%></a></li>
    <li><a href="account.jsp">Create Account</a></li>
	<li><a href="deposit.jsp">Deposit</a></li>
    <li><a href="withdraw.jsp">Withdrawal</a></li>
    <li><a href="get-balance.jsp">Balance</a></li>
	<li><a href="view-reports.jsp">View Transactions</a></li>
	<li><a href="logOff.jsp">LogOut</a></li>
  </ul>
  <div class="menutitle">&nbsp;</div>
</div>
</td>
    <td>
	<div>
    <h2><font color="#FF0000">Online Bank.</font></h2>
	</div>
	<br/>
	<br/>
	<div class="box2">
	Your account has been successfully created and the Account No. is <%=accno%>.<br/>
	To Deposit amount to your account <a href="deposit.jsp">Click Here</a><br/>
	To Withdraw from your account <a href="withdraw.jsp">Click Here</a>
	</div>
	</td>
  </tr>
</table>
</body>
</html>