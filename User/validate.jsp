<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.lang.*" %>
<%@ page import="javax.servlet.*,java.text.*" %>
<%@ page import ="java.sql.*" %>
<%@ page import ="java.util.Date" %>
<%
			String user = request.getParameter("username");
			String password = request.getParameter("password");	
			
			Connection conn = null;
			PreparedStatement pst;
			ResultSet rs;
			
			try
			{
				Class.forName("com.mysql.jdbc.Driver");  // MySQL database connection
			}
			
			catch(Exception e)
			{
		      out.println("Something went wrong !! Please try again  "+e);  
			}
		    try{
        
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hik?" + "user=root&password=root");    
			String sql="Select * from administrator where username='"+user+"' and password='"+password+"'";
			pst = conn.prepareStatement(sql);
			rs = pst.executeQuery();                        
			if(rs.next())           
			{
			out.println("Done");
			out.println("Valid login credentials");
			response.sendRedirect("../Dashboard/dashboard.jsp");  
			session.setAttribute("uid",rs.getLong("uid"));
			session.setAttribute("hid",rs.getString("hospitalID"));
			session.setAttribute("uname",rs.getString("name"));
			} 
			else
			{
        	out.println("Invalid login credentials"); 
           //response.sendRedirect("login.html");
            out.println(sql);
           	session.invalidate();
           	response.sendRedirect("../Dashboard/dashboard.jsp"); 
			}
				}
			catch(Exception e)
			{       
			out.println("Something went wrong !! Please try again  "+e);   
     
			}      
%>

