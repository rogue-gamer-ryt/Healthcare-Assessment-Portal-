<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page import ="java.util.Date" %>
<%@ page import="java.io.*,java.util.*" %>
<%@ page import="javax.servlet.*,java.text.*" %>

<%
String did = request.getParameter("did");
String dname =  request.getParameter("dname");
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
  <title>Manage Practise</title>
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
        </div>
        <!-- /#sidebar-wrapper -->

        <!-- Page Content -->
        <div id="page-content-wrapper" style="padding-top: 20px;">
            <div class="container-fluid">
                <div class="row">
                  <div class="col s1" >
                   <a href="#menu-toggle" class="btn-floating btn-large waves-effect waves-light red" id="menu-toggle"><i class="material-icons">menu</i></a>
                   </div>
                   <div class="push-s3 push-l4 col s4 l4">
                   <h4>Manage Practise</h4>
                  </div>
                 <div class="col s1 push-s3 push-l4" >
                   <a href="root_dashboard.jsp" class="btn-floating btn-large waves-effect waves-light red"><i class="material-icons">home</i></a>
                   </div>                      
                </div>

                <div class="row">
                   <div class="push-s7 push-m10 push-l10 col s4 m3 l2">
                    <a href="create_practice.jsp" class="waves-effect waves-light btn">Add</a>
                  </div>
                   <div class="push-s7 push-m10 push-l6 col s4 m3 l2">
                    <a target="_blank" href="audittrials.jsp?str=Practice" class="waves-effect waves-light btn">Audit Trials</a>
                  </div>                
                </div>
                <div class="row">
                    <div class="col s12 m12 l12">
                        <table class="centered striped">
                            <thead>
                              <tr>
                              <th>#</th>
                              <th>Name</th>
                              <th>City</th>
							  <th>Edit</th>
                              <th>Enable/Disable</th>
                              <th>Status</th>
                              <th>Creator</th>
                              <th>Start Date</th>
                              <th>Expiry Date</th>
                              </tr>
                            </thead>
                            <tbody>
							<% 
							  try
								{ 
								connection = DriverManager.getConnection(connectionUrl+dbName, userId, password);
							    String sql = "Select * from root_practice";
								prs = connection.prepareStatement(sql);
								resultSet = prs.executeQuery();
								int f=1;
								while(resultSet.next())
								{
							%>
                              <tr>
                                <td><%=f++ %></td>
                                <td><%=resultSet.getString("name") %></td>
                                <td><%=resultSet.getString("city") %></td>
								<td><a class="waves-effect waves-light btn red"  onclick="setValue1(<%=resultSet.getString("practiceID") %>)" href="#modal1"> Edit </a></td>
								<td><a class="waves-effect waves-light btn red" onclick="setValue2(<%=resultSet.getString("practiceID") %>)" href="#modal2"> Enable/Disable </a></td>
								<td><%=resultSet.getString("status") %></td>
								<td><%=resultSet.getString("creator") %></td>
								<td><%=resultSet.getString("startdate") %></td>
								<td><%=resultSet.getString("expirydate") %></td>
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
	<div id="modal1" class="modal">
    <div class="modal-content">
      <h4>Authentication</h4>
      <p>Enter credentials to Edit Admin</p>
      <div class="row">
    <form name="editForm" class="editForm col s12">
      <div class="row">
        <div class="input-field col s12">
          <input id="last_name" name="username" type="text" class="validate">
          <label for="last_name">Username</label>
        </div>
      </div>
      <div class="row hide">
        <div class="input-field col s12">
          <input id="userid" name="userid" class="uid" type="uid" class="validate">
          <label for="userid"></label>
        </div>
      </div>
      <div class="row">
        <div class="input-field col s12">
          <input id="password" name="password" type="password" class="validate">
          <label for="password">Password</label>
        </div>
      </div>
    </form>
  </div>
        
    </div>
    <div class="modal-footer">
      <a type="submit" onclick="formSubmit(1)" class="modal-action modal-close waves-effect waves-green btn-flat">Submit</a>
    </div>
  </div>

    <div id="modal2" class="modal">
    <div class="modal-content">
      <h4>Authentication</h4>
      <p>Enter credentials to Enable/Disable Admin</p>
      <div class="row">
    <form name="toggleForm" class="toggleForm col s12">
      <div class="row">
        <div class="input-field col s12">
          <input id="last_name" name="username" type="text" class="validate">
          <label for="last_name">Username</label>
        </div>
      </div>
      <div class="row hide">
        <div class="input-field col s12">
          <input id="userid" name="userid" class="uid" type="uid" class="validate">
          <label for="userid"></label>
        </div>
      </div>      
      <div class="row">
        <div class="input-field col s12">
          <input id="password" name="password" type="password" class="validate">
          <label for="password">Password</label>
        </div>
      </div>
    </form>
  </div>
        
    </div>
    <div class="modal-footer">
      <a  onclick="formSubmit(2)" type="Submit" class="modal-action modal-close waves-effect waves-green btn-flat">Submit</a>
    </div>
  </div>
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
    $(document).ready(function(){
        // the "href" attribute of .modal-trigger must specify the modal ID that wants to be triggered
        $('.modal').modal();
      });
    
    </script>

<script src="js/jquery.js"></script>  

<script type="text/javascript" src="js/materialize.min.js"></script>
<script>
function setValue1(val)
{
	$(".editForm #userid").val(val);
}
function setValue2(val)
{
	$(".toggleForm #userid").val(val);
}
function formSubmit(val)
{
	if(val==1)
		{
			document.editForm.method="POST";
			document.editForm.action="edit_practice.jsp";
			document.editForm.submit();
		}
	if(val==2)
		{
			document.toggleForm.action="POST";
			document.toggleForm.action="toggle_practice.jsp";
			document.toggleForm.submit();
		}
}
</script>
</body>
</html>