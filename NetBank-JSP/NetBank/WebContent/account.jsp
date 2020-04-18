<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.sql.*,bankingsystem.netbank" errorPage=""%>
 <%
//java Code
java.util.Random r = new java.util.Random();
int accNo = r.nextInt(10000000);
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
  	<div class="menutitle"><center>Account Operations</center></div>
  	<ul>
    	<li><a href="main.jsp">Welcome,&nbsp;<%= (String)session.getAttribute("cust_name")%></a></li>
    	<li><a href="account.jsp">Create Account</a></li>
		<li><a href="deposit.jsp">Deposit</a></li>
    	<li><a href="withdraw.jsp">Withdrawal</a></li>
    	<li><a href="get-balance.jsp">Balance</a></li>
		<li><a href="view-reports.jsp">View Transactions</a></li>
		<li><a href="logOff.jsp">LogOut</a></li>
  </ul>
</td>
    <h2><font color="#FF0000">Net Banking</font></h2>
	<br/>
	<td>
	<form id="form1" name="form1" method="post" action="finalaccount.jsp">
	  <table>
        <tr>
          <th>Create Bank Account</font></th>
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
            <input name="accno" type="text" id="accno"  readonly="true" value="<%=accNo%>"/>
          </label></td>
        </tr>
        <tr>
          <td><div align="right">Account Type </div></td>
          <td>:</td>
          <td><select name="acc_type">
		  <option value="CURRENT"> Current Account</option>
		  <option value="SAVING"> Saving Account</option>
		  <option value="STUDENT"> Student Account</option>
		  </select></td>
        </tr>
        <tr>
          <td><div align="right">Account Details</div></td>
          <td>:</td>
          <td><label>
            <textarea name="details" cols="30" rows="3" id="details"></textarea>
          </label></td>
        </tr>
        <tr>
          <td><label>
            <input type="submit" name="Submit" value="Create Account" />
          </label></td>
        </tr>
      </table>
      </form>
	</td>
  </tr>
</table>
</body>
</html>