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
String hname = request.getParameter("hospital");
String practice= new String();

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
catch (ClassNotFoundException e) {
e.printStackTrace();
}

Long id=0L;
if(session.getAttribute("uid")!=null)
{
	id=(Long)session.getAttribute("uid");
}
else
{
	response.sendRedirect("../User/Login.html");  	
}
Connection connection = null;
PreparedStatement prs;
ResultSet resultSet = null;
%>

<head>
<meta http-equiv="refresh" content="0; url=manage_admin_hospital.jsp">
</head>

<%
try
{ 
	connection = DriverManager.getConnection(connectionUrl+dbName, userId, password);
	String creator=new String();
	String sql="Select * from root_admin where id='"+id+"'";
	prs=connection.prepareStatement(sql);
	resultSet=prs.executeQuery();
	while(resultSet.next())
	{
		creator=resultSet.getString("name");
	}
	sql="Select * from root_hospital where hospitalID='"+hname+"'";
	prs=connection.prepareStatement(sql);
	resultSet=prs.executeQuery();
	while(resultSet.next())
	{
		practice=resultSet.getString("practiceID");
	}
	SimpleDateFormat f2 = new SimpleDateFormat("yyyyMMddhhmmss");
	java.util.Date d2 = new java.util.Date();
	String uid = f2.format(d2);
	fname=fname.concat(" ");
	fname=fname.concat(lname);
	sql = "Insert into root_hosadmin(uid,hospitalID,practiceID,name,username,password,creator) values ('"+uid+"','"+hname+"','"+practice+"','"+fname+"','"+username+"','"+pwd+"','"+creator+"')";
	prs = connection.prepareStatement(sql);
	prs.executeUpdate();
	sql = "Insert into administrator(uid,hospitalID,name,username,password,creator,adminstat) values ('"+uid+"','"+hname+"','"+fname+"','"+username+"','"+pwd+"','"+creator+"','hospitalroot')";
	System.out.println(sql);
	prs = connection.prepareStatement(sql);
	prs.executeUpdate();	
    String action="Create ";
    action=action.concat(fname);
    sql="Insert into root_log(action,actioncreator,actionpage) values('"+action+"','"+creator+"','AdminHospital')";
    prs=connection.prepareStatement(sql);
    prs.executeUpdate();
	connection.close(); 
}
catch (Exception e) 
{
e.printStackTrace();
}
%>