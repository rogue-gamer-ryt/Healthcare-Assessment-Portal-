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
String driverName = "com.mysql.jdbc.Driver";
String connectionUrl = "jdbc:mysql://localhost:3306/";
String dbName = "hik";
String userId = "root";
String password = "root";

String number=request.getParameter("num");
int num=Integer.parseInt(number);
String opscore="";
for (int i=1;i<=num;i++)
{
	if(restype.equals("5"))
	{
		opscore=opscore.concat(request.getParameter("ll"));
		opscore=opscore.concat(",");
		opscore=opscore.concat(request.getParameter("hl"));
		opscore=opscore.concat(";");
	}
    opscore=opscore.concat(request.getParameter("option_"+i));
    opscore=opscore.concat(",");
    opscore=opscore.concat(request.getParameter("score_"+i));
    opscore=opscore.concat(";");
}    

try {
Class.forName(driverName);
} 
catch (ClassNotFoundException e) {
e.printStackTrace();
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
    if((restype.equals("1"))||(restype).equals("5"))
    {
    sql = "Update question  set qdesc='" + qdesc + "',restype='"+restype+"',num=null,opscore=null where qid="+cidx;
    }
    else if((restype.equals("2"))||(restype.equals("3"))||(restype.equals("4")))
    {
    sql = "Update question  set qdesc='" + qdesc + "',restype='"+restype+"',num="+num+",opscore='"+opscore+"' where qid="+cidx;
    }
    System.out.println(sql);
    prs=connection.prepareStatement(sql);
    prs.executeUpdate();
    connection.close();
} catch (Exception e) {
    e.printStackTrace();
}
%>