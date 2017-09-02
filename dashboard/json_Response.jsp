<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="javax.swing.JTextField" %>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.io.*,java.util.*,javax.servlet.*,java.text.*" %>
<%@page import="org.json.simple.*"%>
<%@page import="org.json.JSONArray"%>
<%@page import="org.json.JSONObject"%>
<%@page import="java.util.*" %>
<%
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
catch (ClassNotFoundException e) 
{
e.printStackTrace();
}

Connection connection = null;
PreparedStatement prs;
ResultSet resultSet = null;
%>
<%
	 connection=DriverManager.getConnection(connectionUrl+dbName,userId,password);
     String regJson = request.getParameter("Json");
	 JSONObject jsnobject = new JSONObject(regJson);
	 JSONArray jsonArray = jsnobject.getJSONArray("Patient"); 
	 JSONArray js = jsnobject.getJSONArray("Questions"); 
	 String pid="",appdate="",illnessID="",dob="",nurseid="",gender="",name="",repdate="",repmaxscore="",repscore="",status="",surveydesc="",surveyid="",surveyname="";
	 for (int i = 0; i < jsonArray.length(); i++) 
	    {
	        JSONObject obj = jsonArray.getJSONObject(i);
	        pid=(String)obj.get("pid");
	        appdate=(String)obj.get("appdate");
	        illnessID=(String)obj.get("illnessID");
	        dob=(String)obj.get("dob");
	        gender=(String)obj.get("gender");
	        nurseid=(String)obj.get("nurseid");
	        name=(String)obj.get("name");
	        if(obj.has("repdate"))
	        {
	        repdate=(String)obj.get("repdate");
	        repmaxscore=(String)obj.get("repmaxscore");
	        repscore=(String)obj.get("repscore");
	        }
	        else
	        {
	        	repdate="";
	        	repmaxscore="";
	        	repscore="";
	        }
	        status=(String)obj.get("status");
	        surveydesc=(String)obj.get("surveydesc");
	        surveyid=(String)obj.get("surveyid");
	        surveyname=(String)obj.get("surveyname");
	        if(status.equals("completed"))
	        {
	        String sql="Insert into response values('"+pid+"','"+appdate+"','"+illnessID+"','"+dob+"','"+gender+"','"+nurseid+"','"+name+"','"+repdate+"','"+repmaxscore+"','"+repscore+"','"+status+"','"+surveyname+"','"+surveyid+"','"+surveyname+"')";
	    	prs=connection.prepareStatement(sql);
	    	prs.executeUpdate();
	        }
	        else 
	        {
	        	continue;
	        }
	    }
	 String answer="",maxscore="",qdesc="",qid="",score="";
	 for (int i = 0; i < js.length(); i++) 
	    {
	        JSONObject job = js.getJSONObject(i);
	        maxscore=(String)job.get("maxscore");
	        pid=(String)job.get("pid");
	        qdesc=(String)job.get("qdesc");
	        qid=(String)job.get("qid");
	        score=(String)job.get("score");
	        answer=(String)job.get("answer");
	       	String sql="Insert into result values('"+pid+"','"+qid+"','"+qdesc+"','"+answer+"','"+maxscore+"','"+score+"')";
	        prs=connection.prepareStatement(sql);
	    	prs.executeUpdate();
	    	sql="Update patient_detail set status='completed' where pid='"+pid+"'";
	    	prs=connection.prepareStatement(sql);
	    	prs.executeUpdate();
	    }
%>