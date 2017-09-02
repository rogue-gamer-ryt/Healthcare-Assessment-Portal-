<%@page import="java.sql.*"%>
<%@page import="javax.swing.JTextField" %>
<%@page import="java.io.*,java.util.*,javax.servlet.*,java.text.*" %>
<%@ page import="org.json.simple.*"%>
<%
//out.println("Pass");
String uidd = request.getParameter("uid");
String driverName = "com.mysql.jdbc.Driver";
String connectionUrl = "jdbc:mysql://localhost:3306/";
String dbName = "hik";
String userId = "root";
String password = "root";
JSONObject obj = new JSONObject();
JSONObject obj2 = new JSONObject();
String jsonText="";
try 
{
Class.forName(driverName);
} 
catch (ClassNotFoundException e)
{
    //out.println(e);
}

Connection connection = null;
Statement statement = null;
ResultSet resultSet = null;

try { 

connection = DriverManager.getConnection(connectionUrl+dbName, userId, password);
statement=connection.createStatement();
String sql1 ="SELECT * FROM nurse_detail where id="+uidd;
resultSet = statement.executeQuery(sql1);
while(resultSet.next())
{
	obj.put("FName", resultSet.getString("fname"));
	obj.put("LName", resultSet.getString("lname"));
	obj.put("Username", resultSet.getString("username"));
    obj.put("Gender", resultSet.getString("gender"));
    
StringWriter out1 = new StringWriter();
obj.writeJSONString(out1);
jsonText = out1.toString();
}
PrintWriter out4 = response.getWriter();
out4.println(jsonText);
connection.close();
}

    catch (Exception e) {
        //out.println(e);
    }
    %>
   
