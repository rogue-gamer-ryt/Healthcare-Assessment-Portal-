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
fname=fname.concat(" ");
String name=fname.concat(lname);
String creator=new String();
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

Connection connection = null;
PreparedStatement prs;
ResultSet resultSet = null;
String userid="";
if((session.getAttribute("uid")!=null))
{
	creator=(String)session.getAttribute("create");
	userid=(String)session.getAttribute("userid");
}
else
{
	response.sendRedirect("../User/Login_root.html");  
}
%>
<head>
<meta http-equiv="refresh" content="0; url=manage_admin_root.jsp">
</head>


<%
try
{ 
	connection = DriverManager.getConnection(connectionUrl+dbName, userId, password);


	String sql = "Update root_admin set name='"+fname+"',username='"+username+"',password='"+password+"' where id="+userid;
    out.println(sql);
	prs = connection.prepareStatement(sql);
	prs.executeUpdate();
    String action="Edit ";
    action=action.concat(fname);
    sql="Insert into root_log(action,actioncreator,actionpage) values('"+action+"','"+creator+"','AdminHospital')";
    prs=connection.prepareStatement(sql);
    prs.executeUpdate();
	connection.close(); 
			request.setAttribute("message", "User created sucessfully");
				RequestDispatcher rd = request.getRequestDispatcher("manage_admin_root.jsp");
				rd.forward(request, response);
}
catch (Exception e) 
{
e.printStackTrace();
}
%>