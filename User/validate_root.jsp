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
			String sql="Select * from root_admin where username='"+user+"' and password='"+password+"'";
			pst = conn.prepareStatement(sql);
			 
			rs = pst.executeQuery();                        
			if(rs.next())           
			{ 
			out.println("Done");
			out.println("Valid login credentials");
			response.sendRedirect("../root_Dashboard/root_dashboard.jsp");  
			session.setAttribute("uid",rs.getLong("id"));
			session.setAttribute("create",rs.getString("name"));
			} 
			else
			{
        	
           //response.sendRedirect("login.html");
            session.invalidate();
           	response.sendRedirect("Login_root.html"); 
			}
				}
			catch(Exception e)
			{       
			out.println("Something went wrong !! Please try again  "+e);   
     
			}      
%>