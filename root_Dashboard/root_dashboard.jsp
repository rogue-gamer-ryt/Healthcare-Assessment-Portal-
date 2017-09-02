<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page import ="java.util.Date" %>
<%@ page import="java.io.*,java.util.*" %>
<%@ page import="javax.servlet.*,java.text.*" %>

<%
//String client_id = "test"; 
String driverName = "com.mysql.jdbc.Driver";
String connectionUrl = "jdbc:mysql://localhost:3306/";
String dbName = "hik";
String userId = "root";
String password = "root";
Long uid=0L;
String hosid=new String();
String create=new String();
if((session.getAttribute("uid")!=null))
{
	uid=(Long)session.getAttribute("uid");
	create=(String)session.getAttribute("create");
}
else
{
	response.sendRedirect("../User/Login_root.html");  
}
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
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
  <title>Dashboard</title>
  <link href="http://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
  <!--<link href="css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" type="text/css" href="css/bootstrap.css">-->
  <link rel="stylesheet" type="text/css" href="css/style.css">
  <link href="css/simple-sidebar.css" rel="stylesheet">
  <link type="text/css" rel="stylesheet" href="css/materialize.min.css"  media="screen,projection"/>


</head>
<%
Long id =0L;
if(session.getAttribute("uid")!=null)
{
	id=(Long)session.getAttribute("uid");
}
else
{
	session.invalidate();
	response.sendRedirect("../User/Login_root.html");
}
%>
<body>
  
    <div id="wrapper">

        <!-- Sidebar -->
        <div id="sidebar-wrapper">
                       <ul class="sidebar-nav">
                <li class="sidebar-brand">
                    <a href="#"> Nurse Patient Assesment</a>
                </li>
                <li>
                    <a href="manage_admin_root.jsp">Manage Root Admin</a>
                </li>
                <li>
                    <a href="manage_admin_hospital.jsp">Manage Hospital Admin</a>
                </li>
                <li>
                    <a href="manage_hospital.jsp">Manage Hospital</a>
                </li>
                <li>
                    <a href="manage_practice.jsp">Manage Practice</a>
                </li>
                <li>
                   <a href="logout.jsp">Logout  <i class="fa fa-power-off fa-lg"></i></a>
                </li>
            </ul>
        </div>
        <!-- /#sidebar-wrapper -->

        <!-- Page Content -->
        <div id="page-content-wrapper" style="padding-top: 20px;">
            <div class="container-fluid">
                  <div class="row">
                  <div class="col s1" >
                    <a href="#menu-toggle" class="btn-floating btn-large waves-effect waves-light red" id="menu-toggle"><i class="material-icons">menu</i></a>
                  </div>
                  <div class="col s11">
                      <h2><strong><center>Nurse Patient Assessment Dashboard</center></strong></h2>
                  <br><br>
                </div>
              </div>
              				<div class="row">
                    <div class="col s12 m12 l6 push-l3">
                        <table class="centered striped">
                            <thead>
                              <tr> <th>Total No. Root Admin </th></tr>
                            </thead>
                            <%
                            connection=DriverManager.getConnection(connectionUrl+dbName,userId,password);
                            String sql="Select * from root_admin";
                            prs=connection.prepareStatement(sql);
                            resultSet=prs.executeQuery();
                            int f=0;
                            while(resultSet.next())
                            {
                            	f++;
                            }
                            %>
                            <tr>
                            <td><%=f %></td>
                            </tr>
                         </table>
              	   </div>
              </div>  
              <br>
				<div class="row">
                    <div class="col s12 m12 l6 push-l3">
                        <table class="centered striped">
                            <thead>
                              <tr> <th>Total No. of Practices Created </th></tr>
                            </thead>
                            <%
                            connection=DriverManager.getConnection(connectionUrl+dbName,userId,password);
                            sql="Select * from root_practice";
                            prs=connection.prepareStatement(sql);
                            resultSet=prs.executeQuery();
                            f=0;
                            while(resultSet.next())
                            {
                            	f++;
                            }
                            %>
                            <tr>
                            <td><%=f %></td>
                            </tr>
                         </table>
              	   </div>
              </div>       
              <br>
				<div class="row">
                    <div class="col s12 m12 l6 push-l3">
                        <table class="centered striped">
                            <thead>
                              <tr> <th>No. of Hospitals</th></tr>
                            </thead>
                            <%
                            connection=DriverManager.getConnection(connectionUrl+dbName,userId,password);
                            sql="Select * from root_hospital";
                            System.out.println(sql);
                            prs=connection.prepareStatement(sql);
                            resultSet=prs.executeQuery();
                            f=0;
                            int pending=0;
                            int completed=0;
                            while(resultSet.next())
                            {
                            	f++;
                            }
                            %>
                            <tr>
                            <td><%=f %></td>
                            </tr>
                            <tr>                           
                         </table>
              	   </div>
              </div>     
              				<div class="row">
                    <div class="col s12 m12 l6 push-l3">
                        <table class="centered striped">
                            <thead>
                              <tr> <th>No. of Hospital Admins</th></tr>
                            </thead>
                            <%
                            connection=DriverManager.getConnection(connectionUrl+dbName,userId,password);
                            sql="Select * from root_hosadmin";
                            System.out.println(sql);
                            prs=connection.prepareStatement(sql);
                            resultSet=prs.executeQuery();
                            f=0;
                            while(resultSet.next())
                            {
                            	f++;
                            }
                            %>
                            <tr>
                            <td><%=f %></td>
                            </tr>
                            <tr>                           
                         </table>
              	   </div>
              </div>   
              </div>
            </div>
           </div>
    <!-- /#wrapper -->

    <!-- jQuery -->
    <script src="js/jquery.js"></script>

    <!-- Bootstrap Core JavaScript -->
    <script src="js/bootstrap.min.js"></script>

    <!-- Menu Toggle Script -->
    <script>
    $("#menu-toggle").click(function(e) {
        e.preventDefault();
        $("#wrapper").toggleClass("toggled");
       
    });
    
    </script>


<script type="text/javascript" src="js/materialize.min.js"></script>

</body>
</html>