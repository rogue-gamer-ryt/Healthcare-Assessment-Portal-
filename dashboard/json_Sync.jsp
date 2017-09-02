<%@page import="java.sql.*"%>
<%@page import="javax.swing.JTextField" %>
<%@page import="java.io.*,java.util.*,javax.servlet.*,java.text.*" %>
<%@ page import="org.json.simple.*"%>
<%
//out.println("Pass");
String uidd = request.getParameter("nid");
String driverName = "com.mysql.jdbc.Driver";
String connectionUrl = "jdbc:mysql://localhost:3306/";
String dbName = "hik";
String userId = "root";
String password = "root";
JSONObject obj = new JSONObject();
LinkedList list = new LinkedList();
//Vector disid=new Vector();
int ct=0;

try 
{
Class.forName(driverName);
} 
catch (ClassNotFoundException e)
{
    //out.println(e);
}

Connection connection = null;
Statement statement = null;
ResultSet resultSet = null;

Statement statement2 = null;
ResultSet resultSet2 = null;

try { 

connection = DriverManager.getConnection(connectionUrl+dbName, userId, password);
statement=connection.createStatement();
//statement2=connection.createStatement();
String sql1 ="SELECT * FROM patient_detail where nurseid=20170322110413929";
System.out.println(sql1);
resultSet = statement.executeQuery(sql1);
while(resultSet.next())
{	
	
	obj.put("fname", resultSet.getString("fname"));
	obj.put("lname", resultSet.getString("lname"));
	//out.print(resultSet.getString("question"));
	obj.put("pid", resultSet.getString("pid"));
    //out.print("obj"+obj);
    obj.put("gender", resultSet.getString("gender"));
    obj.put("dob", resultSet.getString("dob"));
    obj.put("appdate", resultSet.getString("appdate"));
    System.out.print(obj);
    list.add(obj);
    //out.print("list"+resultSet.getString("fname"));
}

String jsonText1 = JSONValue.toJSONString(list); 
	out.print(jsonText1);


connection.close();
}

    catch (Exception e) {
        //out.println(e);
    }


    %>
   
