<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*,java.util.*,bankingsystem.netbank" errorPage="" %>
<%
//java Code
String op = "deposit";
java.util.Date date = new java.util.Date();
java.sql.Date sDate = new java.sql.Date(date.getTime());
System.out.println(sDate);
String uname = request.getParameter("uname");
int accno = Integer.parseInt(request.getParameter("accNo"));
int amt = Integer.parseInt(request.getParameter("Amount"));
String bal_sql = "SELECT balance FROM tx_details WHERE uname='"+uname+"' AND acc_no = "+accno+" AND isnew = 'YES'";
int bal = netbank.getBalance(bal_sql);
if(bal == 0){
	System.out.println("Current Balance : "+bal);
	bal = bal + amt;
}else {
	bal = bal + amt;
	String sql_up = "UPDATE tx_details SET isnew = 'NO' WHERE uname='"+uname+"' AND acc_no = "+accno+" AND isnew = 'YES'";
	int up = netbank.update(sql_up);
}
String sql = "INSERT INTO tx_details (uname, acc_no, operation, amt, balance, time1, isnew ) VALUES ('"+uname+"',"+accno+",'deposit',"+amt+","+bal+", '"+sDate+"', 'YES' )";
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
	<h2><font color="#FF0000">Net Banking</font></h2>
	</div>
	<br/>
	<br/>
	<div>
	Your money is successfully deposited into the account. Your current Balance is: <font color="#FF0000">Rs.<%=bal%></font><br/>
	To Deposit amount to your account <a href="deposit.jsp">Click Here</a><br/>
	To Withdraw from account <a href="withdraw.jsp">Click Here</a>
	</div>
	</td>
  </tr>
</table>
</body>
</html>