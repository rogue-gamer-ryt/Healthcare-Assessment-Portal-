<%-- 
    Document   : validate
    Created on : Feb 21, 2016, 8:09:31 PM
    Author     : jeyabalaji
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %>
<%
    try{
        String username = request.getParameter("username");   
        String password = request.getParameter("password");
        Class.forName("com.mysql.jdbc.Driver");  // MySQL database connection
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/test2?" + "user=root&password=sjbalaji");    
        PreparedStatement pst = conn.prepareStatement("Select * from client where email=? and password=?");
        pst.setString(1, username);
        pst.setString(2, password);
        ResultSet rs = pst.executeQuery();                        
        if(rs.next())           
        {out.println("Valid login credentials");
           response.sendRedirect("./user/user_index.jsp");  
           session.setAttribute("userid",rs.getLong("user_id"));
         } 
        else
        {out.println("Invalid login credentials"); 
           //response.sendRedirect("index.jsp");
            session.invalidate();
            request.setAttribute("errorMessage", "Invalid user or password");
            RequestDispatcher rd = request.getRequestDispatcher("/index.jsp");
            rd.forward(request, response);}
   }
   catch(Exception e){       
       out.println("Something went wrong !! Please try again");       
   }      
%>

