<%@page import="java.sql.*"%>
<%@page import="java.lang.*"%>
<%@ page import ="java.util.Date" %>
<%@ page import="java.io.*,java.util.*" %>
<%@ page import="javax.servlet.*,java.text.*" %>

<%
long client_id = (Long)session.getAttribute("userid");

String qdesc = request.getParameter("quedesc");
String restype = request.getParameter("restype");
String cidx = request.getParameter("cid");
String did= (String)session.getAttribute("did");
   
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
%>



<%
Connection connection = null;
PreparedStatement prs,prs2;
ResultSet resultSet = null;

try {
    connection = DriverManager.getConnection(connectionUrl + dbName, userId, password);
    String sql = "Insert into question values ('" + cidx + "','" + did + "','" + qdesc + "','"+restype+"')";
    prs = connection.prepareStatement(sql);
   out.println(sql);
    prs.executeUpdate();
    
    if((restype.equals("2"))||(restype.equals("3"))||(restype.equals("4")))
    {   out.print("HI");
    	String number=request.getParameter("num");
    	int num=Integer.parseInt(number);
    	System.out.println(num);
    	String option[]=new String[20];
    	String score[]=new String[20];
    	for(int i=1;i<=10;i++)
    	{
    		option[i]="NULL";
    		score[i]="NULL";
    	}
    	out.println("hii");
        for (int i=1;i<=10;i++)
        {
            option[i]=request.getParameter("option_"+i);
            score[i]=request.getParameter("score_"+i);
            out.println("\n1\n");
        }
        out.println("Hi");
        String sq2="Insert into opscore values ('"+cidx+"',"+num+",'"+option[1]+"','"+score[1]+"','"+option[2]+"','"+score[2]+"','"+option[3]+"','"+score[3]+"','"+option[4]+"','"+score[4]+"','"+option[5]+"','"+score[5]+"','"+option[6]+"','"+score[6]+"','"+option[7]+"','"+score[7]+"','"+option[8]+"','"+score[8]+"','"+option[9]+"','"+score[9]+"','"+option[10]+"','"+score[10]+"')";
        out.println(sq2);
        prs2=connection.prepareStatement(sq2);
        prs2.executeUpdate();
        out.println(sq2);
        connection.close();                        
    }
} catch (Exception e) {
    e.printStackTrace();
}
%>