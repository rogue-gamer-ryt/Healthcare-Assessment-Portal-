<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page import ="java.util.Date" %>
<%@ page import="java.io.*,java.util.*" %>
<%@ page import="javax.servlet.*,java.text.*" %>

<%
String sname =  request.getParameter("sname");
String sdesc =	request.getParameter("surveydesc");
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
if((session.getAttribute("uid")!=null)||(session.getAttribute("hid")!=null))
{
	uid=(Long)session.getAttribute("uid");
	hosid=(String)session.getAttribute("hid");
	creator=(String)session.getAttribute("uname");
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
    
    SimpleDateFormat f1 = new SimpleDateFormat("yyyyhhhmmssSSS");
	java.util.Date d1 = new java.util.Date();
	String sid = f1.format(d1);
	
	connection = DriverManager.getConnection(connectionUrl+dbName, userId, password);
	String sql = "Insert into survey (id,name,sdesc,creator) values ('"+sid+"','"+sname+"','"+sdesc+"','"+creator+"')";
    System.out.println(sql);
	prs = connection.prepareStatement(sql);
	prs.executeUpdate();
    String action="Create ";
    action=action.concat(sname);
    sql="Insert into log(action,actioncreator,actionpage,hospitalID) values('"+action+"','"+creator+"','Survey','"+hosid+"')";
    prs=connection.prepareStatement(sql);
    prs.executeUpdate();
	connection.close();
}
catch (Exception e) 
{
e.printStackTrace();
}
%>