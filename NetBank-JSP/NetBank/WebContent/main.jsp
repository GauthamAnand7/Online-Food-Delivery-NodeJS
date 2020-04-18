<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*,bankingsystem.netbank" errorPage="" %>
<%
//java Code
%>
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
    <li><a href="main.jsp">Welcome,&nbsp;<%=(String)session.getAttribute("cust_name")%></a></li>
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
	<br/><p>This is a project to allow the customer(s) to service virtually using the Internet with out going to the bank and allow customers to open new account, withdraw, deposit, getting balance and viewing transactions using this banking service. The information pertaining to the customers is stored on an RDBMS at the  server side (BANK). The Bank services  the customers according to the customers intention and it updates and backups of each customer transaction accordingly.</p>
	</td>
  </tr>
</table>
</body>
</html>
