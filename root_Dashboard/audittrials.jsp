<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page import ="java.util.Date" %>
<%@ page import="java.io.*,java.util.*" %>
<%@ page import="javax.servlet.*,java.text.*" %>

<%
String str=request.getParameter("str");
//String client_id = "test"; 
String driverName = "com.mysql.jdbc.Driver";
String connectionUrl = "jdbc:mysql://localhost:3306/";
String dbName = "hik";
String userId = "root";
String password = "root";
Long id=0L;
if(session.getAttribute("uid")!=null)
{
	id=(Long)session.getAttribute("uid");
}
else
{
	response.sendRedirect("../User/Login.html");  	
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
<html>
<head>
  <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
  <title>Manage Hospital</title>
  <link href="http://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
  <!--<link href="css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" type="text/css" href="css/bootstrap.css">-->
  <link rel="stylesheet" type="text/css" href="css/style.css">
  <link href="css/simple-sidebar.css" rel="stylesheet">
  <link type="text/css" rel="stylesheet" href="css/materialize.min.css"  media="screen,projection"/>


</head>
<body>
  
    <div id="wrapper">

        <!-- Sidebar -->

        <!-- /#sidebar-wrapper -->

        <!-- Page Content -->
        <div id="page-content-wrapper" style="padding-top: 20px;">
            <div class="container-fluid">

                <div class="row">
                    <div class="col s12 m12 l12">
                        <table class="centered striped">
                            <thead>
                              <tr>
                              <th>#</th>
                              <th>Action</th>
                              <th>Action Time</th>
                              <th>Action Creator</th>
                              </tr>
                            </thead>
                            <tbody>
							<% 
							  try
								{ 
								connection = DriverManager.getConnection(connectionUrl+dbName, userId, password);
							    String sql = "Select * from root_log where actionpage='"+str+"'";
								System.out.println(sql);
							    prs = connection.prepareStatement(sql);
								resultSet = prs.executeQuery();
								int f=1;
								while(resultSet.next())
								{
							%>
                              <tr>
                                <td><%=f++ %></td>
                                <td><%=resultSet.getString("action") %></td>
                                <td><%=resultSet.getString("actiontime") %></td>
                                <td><%=resultSet.getString("actioncreator") %></td>
                              </tr>
							 <%
								}
								}
								catch(Exception e)
								{
									e.printStackTrace();
								}
							 %>
                            </tbody>
                        </table>
                    </div>
                </div>                        
            </div>
        </div>
        <!-- /#page-content-wrapper -->

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
<script src="js/jquery.js"></script>  

<script type="text/javascript" src="js/materialize.min.js"></script>
</body>
</html>