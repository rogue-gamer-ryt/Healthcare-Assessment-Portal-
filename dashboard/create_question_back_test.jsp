<%@page import="java.sql.*"%>
<%@page import="java.lang.*"%>
<%@ page import ="java.util.Date" %>
<%@ page import="java.io.*,java.util.*" %>
<%@ page import="javax.servlet.*,java.text.*" %>

<%

String qdesc = request.getParameter("quedesc");
String restype = request.getParameter("restype");
String cidx = request.getParameter("cid");
String did= (String)session.getAttribute("did");
int num=0;
System.out.println(restype);
String driverName = "com.mysql.jdbc.Driver";
String connectionUrl = "jdbc:mysql://localhost:3306/";
String dbName = "hik";
String userId = "root";
String password = "root";

String number=request.getParameter("num");
String opscore="";
if((restype.equals("2"))||(restype.equals("3"))||(restype.equals("4"))||(restype.equals("5")))
{
	num=Integer.parseInt(number);
	if(restype.equals("5"))
	{
		opscore=opscore.concat(request.getParameter("ll"));
		opscore=opscore.concat(",");
		opscore=opscore.concat(request.getParameter("hl"));
		opscore=opscore.concat(";");
	}
for (int i=1;i<=num;i++)
{
    opscore=opscore.concat(request.getParameter("option_"+i));
    opscore=opscore.concat(",");
    opscore=opscore.concat(request.getParameter("score_"+i));
    opscore=opscore.concat(";");
}    
}
try {
Class.forName(driverName);
} 
catch (ClassNotFoundException e) {
e.printStackTrace();
}
%>
<%
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
<meta http-equiv="refresh" content="0; url=manage_questions.jsp">
</head>


<%
Connection connection = null;
PreparedStatement prs,prs2;
ResultSet resultSet = null;

try {
    connection = DriverManager.getConnection(connectionUrl + dbName, userId, password);
    String sql=new String();
    if((restype.equals("1"))||(restype).equals("6"))
    {
    sql = "Insert into question values ('" + cidx + "','" + did + "','" + qdesc + "','"+restype+"',null,null,null,null)";
    }
    else if((restype.equals("2"))||(restype.equals("3"))||(restype.equals("4")))
    {
    	sql = "Insert into question values ('" + cidx + "','" + did + "','" + qdesc + "','"+restype+"',"+num+",'"+opscore+"',null,null)";
    }
    else if((restype.equals("5")))
    {
    	String hl=request.getParameter("hl");
    	String ll=request.getParameter("ll");
    	sql = "Insert into question values ('" + cidx + "','" + did + "','" + qdesc + "','"+restype+"',"+num+",'"+opscore+"','"+ll+"','"+hl+"')";
    }
    System.out.println(sql);
    prs=connection.prepareStatement(sql);
    prs.executeUpdate();
    connection.close();
} catch (Exception e) {
    e.printStackTrace();
}
%>