<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page import ="java.util.Date" %>
<%@ page import="java.io.*,java.util.*" %>
<%@ page import="javax.servlet.*,java.text.*" %>

<%
String username =  request.getParameter("username");
String pwd =  request.getParameter("password");
out.println(username+" "+pwd);
String userid=request.getParameter("userid");
out.println(userid);
String status=new String();

System.out.println(userid);
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
<meta http-equiv="refresh" content="0; url=manage_admin.jsp">
</head>

<%
try
{ 
    
	connection = DriverManager.getConnection(connectionUrl+dbName, userId, password);
	String sql="Select * from administrator where uid="+uid;
	prs=connection.prepareStatement(sql);
	resultSet=prs.executeQuery();
	while(resultSet.next())
	{
		if((username.equals(resultSet.getString("username"))==false)&&(pwd.equals(resultSet.getString("password"))==false))
		{
			response.sendRedirect("manage_admin.jsp"); 
		}
	}
	sql="Select status from administrator where uid="+userid;
	out.println(sql);
	String fname="";
	prs=connection.prepareStatement(sql);
	resultSet=prs.executeQuery();
	while(resultSet.next())
	{
		status=resultSet.getString("status");
		fname=resultSet.getString("name");
	}
	System.out.println(status);
	if(status.equals("Enabled"))
	{
		status="Disabled";
	}
	else if(status.equals("Disabled"))
	{
		status="Enabled";
	}
	System.out.println(status);
	sql = "Update administrator set status='"+status+"' where uid="+userid;
	System.out.println(sql);
    //out.println(sql);
	prs = connection.prepareStatement(sql);
	prs.executeUpdate();
    String action=status+" ";
    action=action.concat(fname);
    sql="Insert into log(action,actioncreator,actionpage,hospitalID) values('"+action+"','"+creator+"','Admin','"+hosid+"')";
    prs=connection.prepareStatement(sql);
    prs.executeUpdate();
	connection.close();
}
catch (Exception e) 
{
e.printStackTrace();
}
%>