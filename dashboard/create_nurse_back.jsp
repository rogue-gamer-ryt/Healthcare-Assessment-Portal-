<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page import ="java.util.Date" %>
<%@ page import="java.io.*,java.util.*" %>
<%@ page import="javax.servlet.*,java.text.*" %>

<%
String username = request.getParameter("uname");
String nrpassword = request.getParameter("pwd");

String fname = request.getParameter("fname");
String mname = request.getParameter("mname");
String lname = request.getParameter("lname");
String salutation = request.getParameter("salutation");
String qualification="";
if(request.getParameter("qualification")!=null)
{
	qualification=request.getParameter("qualification");
}
String name=salutation+" "+fname+" "+mname+" "+lname+" "+qualification;
String gender = request.getParameter("gender");
System.out.println(name+" "+gender);
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
<meta http-equiv="refresh" content="0; url=manage_nurse.jsp">
</head>

<%
Connection connection = null;
PreparedStatement prs;
ResultSet resultSet = null;

try {
    Date dNow = new Date();
    SimpleDateFormat ft = new SimpleDateFormat("yyyyMMddHHmmssSSS");
    String cid = "" + ft.format(dNow);
  //out.println(cid);
    connection = DriverManager.getConnection(connectionUrl + dbName, userId, password);
    String sql = "Insert into nurse_detail(name,id,hid,username,password,gender,creator) values ('" + name + "','" + cid + "','"+hosid+"','"+username+"','"+ nrpassword +"','"+ gender +"','"+creator+"')";
    out.println(sql);
    prs = connection.prepareStatement(sql);
    prs.executeUpdate();
    String action="Create ";
    action=action.concat(name);
    sql="Insert into log(action,actioncreator,actionpage,hospitalID) values('"+action+"','"+creator+"','Nurse','"+hosid+"')";
    prs=connection.prepareStatement(sql);
    prs.executeUpdate();
    connection.close();
} catch (Exception e) {
    e.printStackTrace();
}
%>