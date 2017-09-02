<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page import ="java.util.Date" %>
<%@ page import="java.io.*,java.util.*" %>
<%@ page import="javax.servlet.*,java.text.*" %>

<%
String fname = request.getParameter("fname");
String lname =  request.getParameter("lname");
String username = request.getParameter("uname");
String pwd = request.getParameter("pwd");
String hname = request.getParameter("hname");
fname=fname.concat(" ");
fname=fname.concat(lname);
//String client_id = "test"; 
String driverName = "com.mysql.jdbc.Driver";
String connectionUrl = "jdbc:mysql://localhost:3306/";
String dbName = "hik";
String userId = "root";
String password = "root";

Long uid=0L;
String hosid=new String();
String creator=new String();
String madmin=request.getParameter("madmin");
String mnurse=request.getParameter("mnurse");
String msurvey=request.getParameter("msurvey");
String massign=request.getParameter("massign");
String millness=request.getParameter("millness");
System.out.println(madmin);
String off="";
if(madmin==null)
{
	off=off.concat("1,");
}
if(mnurse==null)
{
	off=off.concat("2,");
}
if(msurvey==null)
{
	off=off.concat("3,");	
}
if(massign==null)
{	
	off=off.concat("4,");
}
if(millness==null)
{
	off=off.concat("5,");
}
else
{
	if(off.length()==0)
		off=off.concat("All");
}
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

try 
{
Class.forName(driverName);
} 
catch (ClassNotFoundException e) {
e.printStackTrace();
}

Connection connection = null;
PreparedStatement prs;
ResultSet resultSet = null;
%>
<head>
<meta http-equiv="refresh" content="0; url=manage_admin.jsp">
</head>

<%
try
{ 
	connection = DriverManager.getConnection(connectionUrl+dbName, userId, password);

	SimpleDateFormat f2 = new SimpleDateFormat("yyyyMMddhhmmss");
	java.util.Date d2 = new java.util.Date();
	String userid = f2.format(d2);
	String sql = "Insert into administrator(name,hospitalID,uid,username,password,creator,noaccess) values ('"+fname+"',"+hosid+","+userid+",'"+username+"','"+pwd+"','"+creator+"','"+off+"')";
    out.println(sql);
	prs = connection.prepareStatement(sql);
	prs.executeUpdate();
    String action="Create ";
    action=action.concat(fname);
    sql="Insert into log(action,actioncreator,actionpage,hospitalID) values('"+action+"','"+creator+"','Admin','"+hosid+"')";
    prs=connection.prepareStatement(sql);
    prs.executeUpdate();
	connection.close(); 
			request.setAttribute("message", "User created sucessfully");
				//RequestDispatcher rd = request.getRequestDispatcher("manage_admin.jsp");
				//rd.forward(request, response);
}
catch (Exception e) 
{
e.printStackTrace();
}
%>