<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page import ="java.util.Date" %>
<%@ page import="java.io.*,java.util.*" %>
<%@ page import="javax.servlet.*,java.text.*" %>

<%
String iname =  request.getParameter("iname");
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
<meta http-equiv="refresh" content="0; url=manage_illness.jsp">
</head>

<%
try
{ 
    String id=iname.substring(0,3);
	
    SimpleDateFormat f1 = new SimpleDateFormat("mmssSS");
	java.util.Date d1 = new java.util.Date();
	String hid = f1.format(d1);
	id=id.concat(hid);
	
	connection = DriverManager.getConnection(connectionUrl+dbName, userId, password);
	String sql = "Insert into illness(illnessID,name,creator) values ('"+id+"','"+iname+"','"+creator+"')";
    //out.println(sql);
	prs = connection.prepareStatement(sql);
	prs.executeUpdate();
    String action="Create ";
    action=action.concat(iname);
    sql="Insert into log(action,actioncreator,actionpage,hospitalID) values('"+action+"','"+creator+"','Illness','"+hosid+"')";
    prs=connection.prepareStatement(sql);
    prs.executeUpdate();
	connection.close();
}
catch (Exception e) 
{
e.printStackTrace();
}
%>