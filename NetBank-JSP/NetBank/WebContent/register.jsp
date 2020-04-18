<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*,bankingsystem.netbank" errorPage="" %>
<!DOCTYPE>
<html>
<head>
<meta charset=iso-8859-1>
<title>Net Banking</title>
</head>
<body>
<%
	Connection conn = netbank.prepareConn();
	if(conn == null)
	{
		out.print("connection failed");
	}
	else
		out.print("connection success");

%>

<table>
  <tr>
    <td>
    <table>
      <tr>
        <th>
		<div>
	<h2><font color="#FF0000">Net Banking</font></h2>
	</div>
	<br/>
	<br/>
		</th>
      </tr>
      <tr> 
        <th><form id="form1" name="form1" method="post" action="finalregister.jsp">
          <table>
            <tr>
              <th><font color="#FFFFFF">Customer Registration For new Account</font></th>
              </tr>
            <tr>
              <td width="24%"><div align="left">Username:</div></td>
              <td width="48%"><label>
                <div align="left">
                  <input name="username" type="text" id="username" />
                  </div>
              </label></td>
            </tr>
            <tr>
              <td><div align="left">Password:</div></td>
              <td><div align="left">
                <input name="password" type="password" id="password" />
              </div></td>
            </tr>
            <tr>
              <td><div align="left">Security Question: </div></td>
              <td><div align="left">
                <select name="question">
                  <option value="Your First School Name">What is your pet's name?</option>
                  <option value="Your Car Number">Which was your first car?</option>
                  <option value="Your Mothers Name">What is your mother's name?</option>
                  <option value="Favorite Color">Which is your favourite website?</option>
                </select>
              </div></td>
            </tr>
            <tr>
              <td><div align="left">Answer:</div></td>
              <td><div align="left">
                <input name="answer" type="text" id="answer" size="30" />
              </div></td>
            </tr>
            <tr>
              <td><div align="left">Address:</div></td>
              <td><div align="left">
                <textarea name="address" id="address"></textarea>
              </div></td>
            </tr>
            <tr>
              <td><div align="left">E-mail:</div></td>
              <td><div align="left">
                <input name="email" type="text" id="email" />
              </div></td>
            </tr>
            <tr>
              <td><div align="left">Mobile:</div></td>
              <td><div align="left">
                <input name="mobile" type="text" id="mobile" />
              </div></td>
            </tr>
            <tr>
              <td><label>
                <div align="right">
                  <input type="reset" name="Submit2" value="Reset" />
                  </div>
              </label></td>
              <td colspan="2"><label>                
                    <div align="left">
                      <input name="Submit" type="submit" value="Create Account"  />
                    </div>
                  </label></td>
              </tr>
          </table>
          </form>        
        </th>
        </tr>
    </table></td>
  </tr>
</table>
</body>
</html>
