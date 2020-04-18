<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*,java.util.*,bankingsystem.netbank" errorPage="" %>
<%
//java Code
String uname = (String)session.getAttribute("cust_name");
String sql = "SELECT acc_no FROM acc_details WHERE uname ='"+uname+"'";// AND upass = '"+password+"'";
//System.out.println(sql);
ArrayList one = netbank.getAccountNoByName(sql);
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
<script type="text/JavaScript">
function withdraw() {
	
}
</script>
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
	<form id="form1" name="form1" method="post" action="finalwithdraw.jsp">
	  <table>
        <tr>
          <th><font color="#FFFFFF">Withdraw Amount From Account</font></th>
        </tr>
        <tr>
          <td><div align="right">Account Holder Name </div></td>
          <td>:</td>
          <td><label>
            <input name="uname" type="text" id="uname"  readonly="true" value="<%= (String)session.getAttribute("cust_name")%>"/>
          </label></td>
        </tr>
        <tr>
          <td><div align="right">Account Number </div></td>
          <td>:</td>
          <td><label>
            <select name="accNo">
			<%
			for(int i=0; i<size; i++) {
			%>
			<option value="<%=(String)one.get(0)%>">Acc No : <%=(String)one.get(0)%>&nbsp;&nbsp;</option>
			<% } %>
			</select>
          </label></td>
        </tr>
        <tr>
          <td><div align="right">Withdraw Amount </div></td>
          <td>:</td>
          <td>Rs.<input name="Amount" type="text" id="Amount" size="10" />  
            </td>
        </tr>
        <tr>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td><label>
            <input name="Submit" type="submit" onclick="withdraw()" value="Withdraw Amount" />
          </label></td>
        </tr>
      </table>
      </form>
	</td>
  </tr>
  </tr>
</table>
</body>
</html>
