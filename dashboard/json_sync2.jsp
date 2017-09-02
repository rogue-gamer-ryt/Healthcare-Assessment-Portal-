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
JSONObject main =  new JSONObject();
JSONArray array = new JSONArray();
JSONArray array1 = new JSONArray();
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
ResultSet resultSet = null,rs=null;
PreparedStatement prs;
Statement statement2 = null;
ResultSet resultSet2 = null;

try { 
	int count=0;
String illnessname[]=new String[100];
connection = DriverManager.getConnection(connectionUrl+dbName, userId, password);
statement=connection.createStatement();
//statement2=connection.createStatement();
String sql1 ="SELECT * FROM patient_detail where nurseid='"+uidd+"' and status='pending'";
System.out.println(sql1);
resultSet = statement.executeQuery(sql1);
String illness=new String();
while(resultSet.next())
{	
	obj=new JSONObject();
	obj.put("name", resultSet.getString("name"));
	//out.print(resultSet.getString("question"));
	obj.put("pid", resultSet.getString("pid"));
    //out.print("obj"+obj);
    obj.put("gender", resultSet.getString("gender"));
    obj.put("dob", resultSet.getString("dob"));
    obj.put("appdate", resultSet.getString("appdate"));
    obj.put("illnessID", resultSet.getString("illnessID"));
   	illness=resultSet.getString("illnessID");
   	String sq3="Select name from illness where illnessID='"+illness+"'";
   	System.out.println(sq3);
   	prs=connection.prepareStatement(sq3);
   	rs=prs.executeQuery();
   	while(rs.next())
   	{
   		illnessname[count]=rs.getString("name");
   	}
   	sq3="Select * from survey where assigned='"+illnessname[count]+"'";
   	prs=connection.prepareStatement(sq3);
   	rs=prs.executeQuery();
   	System.out.println(sq3);
   	while(rs.next())
   	{
   		obj.put("surveyid",rs.getString("id"));
   		obj.put("surveyname",rs.getString("name"));
   		obj.put("surveydesc",rs.getString("sdesc"));
   	}
   	array.add(obj);
    //out.print("list"+resultSet.getString("fname"));
	count++;
}
for(int i=0;i<count;i++)
{
String sql="Select survey.*,question.* from survey inner join question ON survey.id=question.surveyid where survey.assigned='"+illnessname[i]+"'";
resultSet = statement.executeQuery(sql);
while(resultSet.next())
{
	JSONObject obj2 = new JSONObject();
	obj2.put("surveyid",resultSet.getString("surveyid"));
	obj2.put("qid", resultSet.getString("qid"));
	obj2.put("qdesc", resultSet.getString("qdesc"));
	obj2.put("restype",resultSet.getString("restype"));
	obj2.put("opscore", resultSet.getString("opscore"));
	array1.add(obj2);
}
}
main.put("Questions",array1);
main.put("Patient",array);
String jsonText1 = JSONValue.toJSONString(main); 
	out.print(jsonText1);


connection.close();
}

    catch (Exception e) {
        //out.println(e);
    }


    %>
  