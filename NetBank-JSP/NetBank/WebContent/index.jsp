<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE>
<html>
<head>
<meta charset=iso-8859-1>
<title>Net Banking</title>
<script type="text/JavaScript">
</script>
</head>
<body>

<table >
  <tr>
    <td>
    <table>
      <tr>
        <th><form id="form1" name="form1" method="post" action="finallogin.jsp">
          <table>
            <tr>
              <th>Customer Login</th>
              </tr>
            <tr>
              <td width="24%">Username:</td>
              <td width="48%"><label>
                <input name="username" type="text" id="username" />
              </label></td>
            </tr>
            <tr>
              <td>Password:</td>
              <td><label>
                <input name="password" type="password" id="password" />
              </label></td>
            </tr>
            <tr>
              <td><label>
                <div align="center">
                      <input name="Submit" type="submit"  value="Submit" />
                    </div>
                  </label></td>
              </tr>
            <tr>
              <td colspan="3">Want to Create a New Account? <a href="register.jsp">Click Here</a> </td>
              </tr>
          </table>
                </form>        </th>
        <th><p>This is a project to allow the customer(s) to service virtually using the Internet with out going to the bank and allow customers to open new account, withdraw, deposit, getting balance and viewing transactions using this banking service. The information pertaining to the customers is stored on an RDBMS at the  server side (BANK). The Bank services  the customers according to the customers intention and it updates and backups of each customer transaction accordingly.</p></th>
      </tr>
    </table></td>
  </tr>
</table>
</body>
</html>
