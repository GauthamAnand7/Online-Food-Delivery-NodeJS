<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*,java.util.*,bankingsystem.netbank" errorPage="" %>
<%
//java Code

String uname = (String)session.getAttribute("cust_name");
int accNo = Integer.parseInt(request.getParameter("accNo"));
String sql = "SELECT acc_no, acc_type FROM acc_details WHERE uname='"+uname+"'";
//System.out.println(sql);
String bal_sql = "SELECT balance FROM tx_details WHERE uname='"+uname+"' AND acc_no = "+accNo+" AND isnew = 'YES'";
//System.out.println(bal_sql);
int bal = netbank.getBalance(bal_sql);
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
    <li><a href="main.jsp">Welcome,&nbsp;<%= (String)session.getAttribute("cust_name")%></a></li>
    <li><a href="account.jsp">Create Account</a></li>
	<li><a href="deposit.jsp">Deposit</a></li>
    <li><a href="withdraw.jsp">Withdrawal</a></li>
    <li><a href="get-balance.jsp">Balance</a></li>
	<li><a href="view-reports.jsp">View Transactions</a></li>
	<li><a href="logOff.jsp">LogOut</a></li>
  </ul>
</div>
</td>
    <td>
	<br/>
	<br/>
	<form id="form1" name="form1" method="post" action="">
	  <table>
        <tr>
          <td><div align="right"><strong>Customer Name </strong></div></td>
          <td><div align="right"><strong>:</strong></div></td>
          <td><%=uname%></td>
        </tr>
        <tr>
          <td><div align="right"><strong>Account No. </strong></div></td>
          <td><div align="right"><strong>:</strong></div></td>
          <td>&nbsp;<%=accNo%></td>
        </tr>
        <tr>
          <td><div align="right"><strong>Current Balance </strong></div></td>
          <td><div align="right"><strong>:</strong></div></td>
          <td>Rs.<%=bal%></td>
        </tr>
        <tr>
          <td>If you want to deposit to your account then <a href="deposit.jsp">Click Here</a><br/> Or if you want to withdraw from your account <a href="withdraw.jsp">Click here</a></td>
          </tr>
      </table>
      </form>
	</td>
  </tr>
</table>
</body>
</html>
