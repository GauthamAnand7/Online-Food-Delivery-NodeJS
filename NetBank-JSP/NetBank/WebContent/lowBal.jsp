<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*,bankingsystem.netbank" errorPage="" %>
<!DOCTYPE>
<html>
<head>
<meta charset=iso-8859-1>
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
	<h2><font color="#FF0000">Net Banking</font></h2>
	</div>
	<br/><br/>
	<br/>
	<div class="box2">Sorry! 
	You do not have sufficient balance to transfer money. To deposit some money <a href="deposit.jsp">Click Here</a> <br/>
	To create Your Account <a href="account.jsp">Click Here</a><br/>
	Or to Log out <a href="logOff.jsp">Click Here</a>
	</div>
	</td>
  </tr>
</table>
</body>
</html>
