<%@page import="java.sql.*"%>
<%@page import="javax.swing.JTextField" %>
<%@page import="java.io.*,java.util.*,javax.servlet.*,java.text.*" %>
<%@page import="org.json.simple.*"%>
<%
//out.println("Pass");
String nid = request.getParameter("nid");
String driverName = "com.mysql.jdbc.Driver";
String connectionUrl = "jdbc:mysql://localhost:3306/";
String dbName = "hik";
String userId = "root";
String password = "root";
JSONObject obj = new JSONObject();
JSONObject obj2 = new JSONObject();
String jsonText="";
Vector patients = new Vector();
Vector diseases = new Vector();
Vector questions = new Vector();
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

try { 
connection = DriverManager.getConnection(connectionUrl+dbName, userId, password);
statement=connection.createStatement();
String sql1 ="SELECT * FROM patient_detail where nurseid="+nid;
resultSet = statement.executeQuery(sql1);
while(resultSet.next())
{
	obj.put("Desc", resultSet.getString("qdesc"));
	obj.put("Type", resultSet.getString("restype"));
	//out.print(resultSet.getString("question"));
	obj.put("Score", resultSet.getString("score"));
    // out.print("obj"+obj);
StringWriter out1 = new StringWriter();
obj.writeJSONString(out1);
jsonText = out1.toString();
}
PrintWriter out4 = response.getWriter();
if(jsonText!="[]")
{
out4.println(jsonText);
}
connection.close();
}

catch (Exception e) {
        //out.println(e);
  }
    %>
   
