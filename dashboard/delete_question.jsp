<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>

<%
String qid = request.getParameter("qid");
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

Connection connection = null;
PreparedStatement prs;
ResultSet resultSet = null;
%>
<head>
<meta http-equiv="refresh" content="0; url=manage_questions.jsp">
</head>
<%
try
{ 
connection = DriverManager.getConnection(connectionUrl+dbName, userId, password);
//out.println(uname);
String sql ="Delete from question where qid='"+qid+"'";
prs = connection.prepareStatement(sql);
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

              