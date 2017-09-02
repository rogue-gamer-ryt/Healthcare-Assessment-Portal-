<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.lang.*"%>
<html>
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
<%
String username=request.getParameter("username");
String pwd=request.getParameter("password");
String userid=request.getParameter("uid");
session.setAttribute("userid",userid);
//String client_id = "test"; 
String driverName = "com.mysql.jdbc.Driver";
String connectionUrl = "jdbc:mysql://localhost:3306/";
String dbName = "hik";
String userId = "root";
String password = "root";
Long uid=0L;
String create=new String();
String hid=new String();
if((session.getAttribute("uid")!=null))
{
	uid=(Long)session.getAttribute("uid");
	create=(String)session.getAttribute("create");
	hid=request.getParameter("userid");
	session.setAttribute("hid",hid);
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
                   <h4>Edit Hospital</h4>
                  </div>
                 <div class="col s1 push-s3 push-l4" >
                   <a href="root_dashboard.jsp" class="btn-floating btn-large waves-effect waves-light red"><i class="material-icons">home</i></a>
                   </div>                      
                </div>
                </div>
				<div class="row">
				<div class="col s12 m6 push-l3">
				 <div class="row">
					<form class="col s12" method="POST"  enctype="multipart/form-data" action="edit_hospital_back.jsp">
					  <div class="row">
						<div class="input-field col s6">
						  <select name="practice" id="practice">
							<option value="" disabled selected>Select Practice</option>
							<%
							connection = DriverManager.getConnection(connectionUrl+dbName, userId, password);
							String sql="Select * from root_practice";
							prs=connection.prepareStatement(sql);
							resultSet=prs.executeQuery();
							while(resultSet.next())
							{
								
							%>
							<option id=<%=resultSet.getString("practiceID")%> value=<%=resultSet.getString("practiceID") %>><%=resultSet.getString("name") %></option>
							<%
							}
							%>
						</select>
						</div>
					  </div>
		 <%
                connection=DriverManager.getConnection(connectionUrl+dbName, userId, password);
                sql="Select * from root_admin where username='"+username+"' and password='"+pwd+"'";
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
                sql="Select * from root_hospital where hospitalID='"+hid+"'";
                System.out.println(sql);
                String practice="";
                prs=connection.prepareStatement(sql);
                resultSet=prs.executeQuery();
                while(resultSet.next())
                {
                	practice=resultSet.getString("practiceID");
                %>
					  <div class="row">
						<div class="input-field col s6">
						  <input name="hname" value=<%=resultSet.getString("name")%> id="username" type="text" class="validate">
						  <label for="username">Hospital Name</label>
						</div>
						<div class="input-field col s6">
						  <input name="hcity" value=<%=resultSet.getString("city")%> id="password" type="text" class="validate">
						  <label for="password">City</label>
						</div>
					  </div>
					  <div class="row">
						<div class="input-field col s6">
						  <input name="hcontact" value=<%=resultSet.getString("contact")%> id="username" type="text" class="validate">
						  <label for="username">Contact</label>
						</div>
						<div class="input-field col s6">
						  <input name="haddress" value=<%=resultSet.getString("address")%> id="password" type="text" class="validate">
						  <label for="password">Address</label>
						</div>
					  </div>	
			            <div class="row">
			              <div class="file-field input-field">
			                <div class="btn">
			                  <span>File</span>
			                  <input name="file" type="file">
			                </div>
			                <div class="file-path-wrapper">
			                  <input class="file-path validate" type="text">
			                </div>
			              </div>
			            </div>					  										  
					   <button class="btn waves-effect waves-light" type="submit" name="action">Submit
						<i class="material-icons right">send</i>
					   </button> 
					   <%
                		}
					   %>
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
	var id=<%=practice%>;
	document.getElementById(id).selected=true;
	 $('select').material_select();
}
</script>
</body>
</html>