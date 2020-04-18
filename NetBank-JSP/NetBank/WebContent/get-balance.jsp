<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*,java.util.*,bankingsystem.netbank" errorPage="" %>
<%
//java Code

String uname = (String)session.getAttribute("cust_name");
String sql = "SELECT acc_no, acc_type FROM acc_details WHERE uname='"+uname+"'";
//System.out.println(sql);
ArrayList one = netbank.getAccountByName(sql);
//System.out.println(one)
int size = one.size();
if(size < 1) {
	response.sendRedirect("noAcc.jsp");
}
%>

<!DOCTYPE>
<html>
<head>
<meta>
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
	<div>
	<h2><font color="#FF0000">Net Banking</font></h2>
	</div>
	<br/>
	<br/>
	<form id="form1" name="form1" method="post" action="get-balance-fanal.jsp">
	  <table>
        <tr>
          <th>Please Select the Account to Check Your Current Balance</th>
        </tr>
        <tr>
          <td><div align="right"><strong>Account Holder Name </strong></div></td>
          <td>:</td>
          <td><%= uname %></td>
        </tr>
        <tr>
          <td width="43%"><div align="right"><strong>Select Account No.</strong></div></td>
          <td width="2%">:</td>
          <td width="55%"><select name="accNo">
              <%
			for(int i=0; i<size; i++){
			ArrayList o = (ArrayList)one.get(i);
			%>
              <option value="<%=(String)o.get(0)%>" ><%=(String)o.get(0)%> ::<%=(String)o.get(1)%></option>
              <% } %>
            </select>          </td>
        </tr>
        <tr>
          <td><label>
          <input type="submit" name="Submit" value="Check Balance" />
          </label></td>
        </tr>
      </table>
      </form>
	</td>
  </tr>
</table>
</body>
</html>
