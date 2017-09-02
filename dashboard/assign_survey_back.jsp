<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page import ="java.util.Date" %>
<%@ page import="java.io.*,java.util.*" %>
<%@ page import="javax.servlet.*,java.text.*" %>

<%
String id =  request.getParameter("sname");
//String client_id = "test"; 
String driverName = "com.mysql.jdbc.Driver";
String connectionUrl = "jdbc:mysql://localhost:3306/";
String dbName = "hik";
String userId = "root";
String password = "root";
try 
{
Class.forName(driverName);
} 
catch (ClassNotFoundException e) 
{
e.printStackTrace();
}

Connection connection = null;
PreparedStatement prs;
ResultSet resultSet = null;


Long uid=0L;
String hosid=new String();
String creator=new String();
String sid=new String();
if((session.getAttribute("uid")!=null)||(session.getAttribute("hid")!=null))
{
	uid=(Long)session.getAttribute("uid");
	hosid=(String)session.getAttribute("hid");
	creator=(String)session.getAttribute("uname");
	sid=(String)session.getAttribute("sid");
}
else
{
	response.sendRedirect("../User/Login.html");  
}
%>
<head>
<meta http-equiv="refresh" content="0; url=manage_survey.jsp">
</head>
<%
try
{ 
	String aname= new String();
	connection = DriverManager.getConnection(connectionUrl+dbName, userId, password);
	String sql="Select name from illness where name='"+id+"'";
	System.out.println(sql);
	prs=connection.prepareStatement(sql);
	resultSet=prs.executeQuery();
	while(resultSet.next())
	{
		aname=resultSet.getString("name");
	}
	sql = "Update survey set assigned='"+aname+"' where id="+sid;
	System.out.println(sql);
	prs = connection.prepareStatement(sql);
	prs.executeUpdate();
	connection.close();
}
catch (Exception e) 
{
e.printStackTrace();
}
%>