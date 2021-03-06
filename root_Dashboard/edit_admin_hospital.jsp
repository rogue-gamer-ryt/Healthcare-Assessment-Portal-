<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page import ="java.util.Date" %>
<%@ page import="java.io.*,java.util.*" %>
<%@ page import="javax.servlet.*,java.text.*" %>

<%
String username=request.getParameter("username");
String pwd=request.getParameter("password");
String userid=request.getParameter("userid");
session.setAttribute("userid",userid);
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
String practice=new String();
Connection connection = null;
PreparedStatement prs;
ResultSet resultSet = null;
%>
<html>
<head>
   <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
  <title>Create Admin</title>
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
        </div>        <!-- /#sidebar-wrapper -->

        <!-- Page Content -->
        <div id="page-content-wrapper" style="padding-top: 20px;">
            <div class="container-fluid">
                  <div class="row">
                  <div class="col s1" >
                   <a href="#menu-toggle" class="btn-floating btn-large waves-effect waves-light red" id="menu-toggle"><i class="material-icons">menu</i></a>
                   </div>
                   <div class="push-s3 push-l4 col s4 l4">
                   <h4>Create Hospital Admin</h4>
                  </div>
                   <div class="col s1 push-s3 push-l4" >
                   <a href="root_dashboard.jsp" class="btn-floating btn-large waves-effect waves-light red"><i class="material-icons">home</i></a>
                   </div>                    
                </div>
                </div>
                <%
                connection=DriverManager.getConnection(connectionUrl+dbName, userId, password);
                String sql="Select * from root_admin where username='"+username+"' and password='"+pwd+"'";
                prs=connection.prepareStatement(sql);
                resultSet=prs.executeQuery();
                int count=0;
                while(resultSet.next())
                {
                	count=1;
                }
                if(count==0)
                {
                	response.sendRedirect("../User/Login.html");  
                }
                %>
				<div class="row">
				<div class="col s12 m6 push-l3">
				 <div class="row">
					<form class="col s12" method="POST" action="edit_admin_hospital_back.jsp">
					  <div class="row">
						<div class="input-field col s6">
						  <select name="hospital" id="hospital">
							<option value="" disabled selected>Select Hospital</option>
							<%
							sql="Select * from root_hospital";
							connection=DriverManager.getConnection(connectionUrl+dbName, userId, password);
							prs=connection.prepareStatement(sql);
							resultSet=prs.executeQuery();
							while(resultSet.next())
							{
								
							%>
							<option id=<%=resultSet.getString("hospitalID") %> value=<%=resultSet.getString("hospitalID") %>><%=resultSet.getString("name") %></option>
							<%
							}
							%>
						</select>
						</div>
					  </div>	
					  <%
					  sql="Select * from root_hosadmin where uid="+userid;
					  System.out.println(sql);
					  String fname="",lname="";
					  String hospital="";
					  prs=connection.prepareStatement(sql);
					  resultSet=prs.executeQuery();
					  while(resultSet.next())
					  {
						  	hospital=resultSet.getString("hospitalID");
		                	fname=resultSet.getString("name");
		                	int loc=fname.indexOf(" ");
		                	lname=fname.substring(loc+1);
		                	fname=fname.substring(0,loc);
		                	
					  %>				  
					  <div class="row">
						<div class="input-field col s6">
						  <input name="fname" id="first_name" value=<%=fname %>  type="text" class="validate">
						  <label for="first_name">First Name</label>
						</div>
						<div class="input-field col s6">
						  <input name="lname" id="last_name" value=<%=lname %> type="text" class="validate">
						  <label for="last_name">Last Name</label>
						</div>
					  </div>
					  <div class="row">
						<div class="input-field col s6">
						  <input name="uname" id="username" value=<%=resultSet.getString("username") %> type="text" class="validate">
						  <label for="username">Username</label>
						</div>
						<div class="input-field col s6">
						  <input name="pwd" id="password" value=<%=resultSet.getString("password") %> type="password" class="validate">
						  <label for="password">Password</label>
						</div>
					  </div>
					  <%
					  }
					  %>
					   <button class="btn waves-effect waves-light" type="submit" name="action">Submit
						<i class="material-icons right">send</i>
					   </button> 
					</form>
				  </div> 
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
    $(document).ready(function() {
        $('select').material_select();
    });
    </script>

<script src="js/jquery.js"></script>  

<script type="text/javascript" src="js/materialize.min.js"></script>
<script>
window.onload=edit;
function edit()
{
	var id =<%=hospital%>;
	document.getElementById(id).selected=true;
	 $('select').material_select();
}
</script>
</body>
</html>