<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>

<%
String id = request.getParameter("id");
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
Connection connection = null;
PreparedStatement prs;
ResultSet resultSet = null;
%>
<head>
<meta http-equiv="refresh" content="0; url=confirm_patient.jsp">
</head>
<%
try
{ 
connection = DriverManager.getConnection(connectionUrl+dbName, userId, password);
//out.println(uname);
String sql="Select * from patient_detail where pid"+id;
prs=connection.prepareStatement(sql);
resultSet=prs.executeQuery();
String name="";
while(resultSet.next())
	name=resultSet.getString("name");
sql ="Delete from patient_detail where pid="+id+"";
System.out.println(sql);
prs = connection.prepareStatement(sql);
prs.executeUpdate();
String action="Delete ";
action=action.concat(name);
sql="Insert into log(action,actioncreator,actionpage,hospitalID) values('"+action+"','"+creator+"','Nurse','"+hosid+"')";
prs=connection.prepareStatement(sql);
prs.executeUpdate();
//sql="delete from assigned_surveys where srusername='"+uname+"'";
//prs = connection.prepareStatement(sql);
//prs.executeUpdate();

connection.close();
}
catch (Exception e) 
{
e.printStackTrace();
}

%>

              