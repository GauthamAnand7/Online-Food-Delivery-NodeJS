<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*,java.util.*,bankingsystem.netbank" errorPage="" %>
<%
//java Code

String uname = (String)session.getAttribute("cust_name");
String sql = "SELECT acc_no, operation, amt, balance, time1 FROM tx_details WHERE uname='"+uname+"'";
//System.out.println(sql);
ArrayList one = netbank.getAccountDetailsByName(sql);
//System.out.println(one);
int size = one.size();
if(size < 1) {
	response.sendRedirect("noAcc.jsp");
}
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
  <div class="menutitle">&nbsp;</div>
</div>
</td>
    <td>
	<div>
	<h2><font color="#FF0000">Net Banking</font></h2>
	</div>
	<br/>
	<br/>
	<form id="form1" name="form1" method="post" action="get-balance-fanal.jsp">
	  <table>
        <tr>
          <th><font color="#FFFFFF">Report of your Account: </font></th>
        </tr>
        <tr>
          <td colspan="5">&nbsp;</td>
          </tr>
        <tr>
          <td bgcolor="#2175BC"><div align="center" class="style2">Acc No. </div></td>
          <td bgcolor="#2175BC"><div align="center" class="style2">Operation</div></td>
          <td bgcolor="#2175BC"><div align="center" class="style2">Amt</div></td>
          <td bgcolor="#2175BC"><div align="center" class="style2">Balance</div></td>
          <td bgcolor="#2175BC"><div align="center" class="style2">Date - Time </div></td>
        </tr>
		<%
		for(int i=0;i<one.size();i++) {
		ArrayList o = (ArrayList)one.get(i); 
		%>
        <tr>
          <td><div align="center"><%=(String)o.get(0)%></div></td>
          <td><div align="center"><%=(String)o.get(1)%></div></td>
          <td><div align="center"><%=(String)o.get(2)%></div></td>
          <td><div align="center"><%=(String)o.get(3)%></div></td>
          <td><div align="center"><%=(String)o.get(4)%></div></td>
        </tr>
		<% } %>
      </table>
      </form>
	</td>
  </tr>
</table>
</body>

</html>
