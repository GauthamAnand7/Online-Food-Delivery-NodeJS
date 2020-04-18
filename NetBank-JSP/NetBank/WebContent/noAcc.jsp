<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*,bankingsystem.netbank" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
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
    <li><a href="get-balance.jsp">Get Balance</a></li>
	<li><a href="view-reports.jsp">View Transactions</a></li>
	<li><a href="logOff.jsp">LogOut</a></li>
  </ul>
  <div class="menutitle">&nbsp;</div>
</div>
</td>
    <td colspan="2" style="padding:20px;line-height:20px;">
	<div class="box1">
	<h2><font color="#FF0000">Net Banking</font></h2>
	</div>
	<br/><br/>
	<br/>
	<div class="box2">
	You have not created an account.<br/>
	To create an account <a href="account.jsp">Click Here</a><br/>
	Or to Log out <a href="logOff.jsp">Click Here</a>
	</div>	
	</td>
  </tr>
</table>
</body>
</html>
