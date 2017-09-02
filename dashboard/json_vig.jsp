<%@page import="java.sql.*"%>
<%@page import="javax.swing.JTextField" %>
<%@page import="java.io.*,java.util.*,javax.servlet.*,java.text.*" %>
<%@ page import="org.json.simple.*"%>
<%
String driverName = "com.mysql.jdbc.Driver";
String connectionUrl = "jdbc:mysql://localhost:3306/";
String dbName = "hik";
String userId = "root";
String password = "root";

try {
Class.forName(driverName);
} 
catch (ClassNotFoundException e) {
e.printStackTrace();
}
Connection connection = null;
PreparedStatement prs;
ResultSet resultSet = null;
	JSONObject obj = new JSONObject();
	try
	{
	connection = DriverManager.getConnection(connectionUrl+dbName, userId, password);
	String sql="Select * from patient_detail where nurseid=20170322110413929";
	prs=connection.prepareStatement(sql);
	resultSet=prs.executeQuery();
	while(resultSet.next())
	{
      obj.put("name", resultSet.getString("fname"));
      obj.put("num", resultSet.getString("pid"));
      System.out.print(obj);
	
	}
	connection.close();
	}
	catch(Exception e)
	{
		e.printStackTrace();
	}
	%>