<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %>
<%@page import="javax.swing.JTextField" %>
<%@ page import="org.json.simple.*"%>
<%@page import="java.io.*,java.util.*,javax.servlet.*,java.text.*,java.io.PrintWriter" %>
<%
    PrintWriter outn = response.getWriter();
    try{
        String username = request.getParameter("username");   
        String password = request.getParameter("password");
		JSONObject obj = new JSONObject();
        Class.forName("com.mysql.jdbc.Driver");  // MySQL database connection
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hik?" + "user=root&password=root");    
        PreparedStatement pst = conn.prepareStatement("Select * from nurse_detail where username=? and password=?");
	pst.setString(1, username);
        pst.setString(2, password);
        String hid="";
        ResultSet rs = pst.executeQuery();  
        JSONArray ja = new JSONArray();
        JSONObject json = new JSONObject();
        if(rs.next()){
            //PreparedStatement pst2 = conn.prepareStatement("Select * from nurse_detail where username="+username);
            //ResultSet rs2 = pst2.executeQuery();
            json.put("ID", rs.getString("id"));
            json.put("name", rs.getString("name"));
            json.put("gender", rs.getString("gender"));
            hid=rs.getString("hid");
           // if(rs2.next()){
                //json.put("imageURL", rs2.getString("apppath"));
            }
	
        else{
          outn.print("0"); 
        }
         String sql="Select root_practice.*,root_hospital.* from root_practice INNER JOIN root_hospital ON root_practice.practiceID = root_hospital.practiceID where root_hospital.hospitalID='"+hid+"'";
			pst=conn.prepareStatement(sql);
			rs=pst.executeQuery();
			while(rs.next())
			{
				json.put("hosplogo",rs.getString("root_hospital.logo"));
				json.put("practicelogo",rs.getString("root_practice.logo"));
			}
         StringWriter out1 = new StringWriter();
        json.writeJSONString(out1); 
        String jsonText = out1.toString();
        outn.print(jsonText);
   }
   catch(Exception e){       
       outn.print("ERROR:\n"+e);
   }      
%>

