<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*,bankingsystem.netbank" errorPage="" %>
<%
//java Code
String uname = request.getParameter("username");
String password = request.getParameter("password");
String question = request.getParameter("question");
String answer = request.getParameter("answer");
String address = request.getParameter("address");
String email = request.getParameter("email");
String mobile = request.getParameter("mobile");
String sql = "insert into user_details (uname, upass, sec_question, answer, address, email, mobile ) values ('"+uname+"','"+password+"','"+question+"','"+answer+"','"+address+"','"+email+"','"+mobile+"')";
//System.out.println(sql);
int update = netbank.update(sql);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Online Bank</title>
</head>
<body>
<table>
<tr>
    <td>
	<div>
	<% 
	if(update == 1){
	%>
	Account has successfully been created.<br/><a href="index.jsp">Click Here</a> to Login and Activate Your Account.
	<%
	}else {
	%>
	<font color="#FF0000">Sorry!. Account is not created.<br/>Click Here to <a href="register.jsp">Register Again</a></font>
	<%
	}
	 %>
	</div>
	</td>
  </tr>
</table>
</body>
</html>