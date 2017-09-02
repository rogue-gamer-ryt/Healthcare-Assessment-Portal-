<html>
<head>
   <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
  <title>Manage Nurse</title>
  <link href="http://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
  <!--<link href="css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" type="text/css" href="css/bootstrap.css">-->
  <link rel="stylesheet" type="text/css" href="css/style.css">
  <link href="css/simple-sidebar.css" rel="stylesheet">
  <link rel="stylesheet" href="css/font-awesome.min.css">
  <link type="text/css" rel="stylesheet" href="css/materialize.min.css"  media="screen,projection"/>


</head>

<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page import ="java.util.Date" %>
<%@ page import="java.io.*,java.util.*" %>
<%@ page import="javax.servlet.*,java.text.*" %>

<%
String driverName = "com.mysql.jdbc.Driver";
String connectionUrl = "jdbc:mysql://localhost:3306/";
String dbName = "hik";
String userId = "root";
String password = "root";

          try {
          Class.forName(driverName);
              } 
          catch (ClassNotFoundException e) {
                e.printStackTrace();
                }
          Long uid=0L;
          String hosid=new String();
          String creator=new String();
          if((session.getAttribute("uid")!=null)||(session.getAttribute("hid")!=null))
          {
          	uid=(Long)session.getAttribute("uid");
          	hosid=(String)session.getAttribute("hid");
          	creator=(String)session.getAttribute("uname");
          }
          else
          {
          	response.sendRedirect("../User/Login.html");  
          }
Connection connection = null;
Statement statement = null;
PreparedStatement prs;
ResultSet resultSet = null;
int count=0;
 %>
<body>
  
    <div id="wrapper">

        <!-- Sidebar -->
        <div id="sidebar-wrapper">
            <ul class="sidebar-nav">
                <li class="sidebar-brand">
                    <a href="#"> Nurse Patient Assesment</a>
                </li>
                <%
                String access="";
                connection=DriverManager.getConnection(connectionUrl+dbName,userId,password);
                String sql="Select * from administrator where uid="+uid;
                prs=connection.prepareStatement(sql);
                resultSet=prs.executeQuery();
                while(resultSet.next())
                {
                	access=resultSet.getString("noaccess");
                }
                String str[]=new String[10];
                int loc;
            	for(int i=1;i<=5;i++)
            	{
            		if(access.equals("None")==false)
            		{
                		loc=access.indexOf(",");
                		if(loc!=-1)
                		{
                			str[i]=access.substring(0,loc);
                			access=access.substring(loc+1);
                		}
                		else
                		{
                			str[i]="";
                		}
            		}
            		else
            		{
            			for(i=1;i<=5;i++)
            			{
            				str[i]="";
            			}
            		}
            	}
            	if(access.equals("None")==false)
            	{
	            	if(str[1].equals("1")==false)
	            	{
	                %>
	                <li>
	                    <a href="manage_admin.jsp">Manage Admin</a>
	                </li>
	                <%
	            	}
	            	if(str[1].equals("2")==false&&str[2].equals("2")==false)
	            	{
	                %>
	                <li>
	                    <a href="manage_nurse.jsp">Manage Nurse</a>
	                </li>
	                <%
	            	}
	            	if(str[1].equals("3")==false&&str[2].equals("3")==false&&str[3].equals("3")==false)
	            	{
	                %>
	                <li>
	                    <a href="manage_survey.jsp">Manage Survey</a>
	                </li>
	                <%
	                }
	                if(str[1].equals("4")==false&&str[2].equals("4")==false&&str[3].equals("4")==false&&str[4].equals("4")==false)
	                {
	                %>
	                <li>
	                    <a href="assign_patient.jsp">Assign Patient</a>
	                </li>
	                <%
	                }
	                if(str[1].equals("5")==false&&str[2].equals("5")==false&&str[3].equals("5")==false&&str[4].equals("5")==false&&str[5].equals("5")==false)
	                {
	                %>
	                <li>
	                    <a href="manage_illness.jsp">Manage Illness</a>
	                </li>
	                <%
	                }
            	}
            	else
                {
                %>
                <li>
                    <a href="manage_admin.jsp">Manage Admin</a>
                </li>
                <li>
                    <a href="manage_nurse.jsp">Manage Nurse</a>
                </li>
                <li>
                    <a href="manage_survey.jsp">Manage Survey</a>
                </li>
                <li>
                    <a href="assign_patient.jsp">Assign Patient</a>
                </li>
                <li>
                    <a href="manage_illness.jsp">Manage Illness</a>
                </li>
                <%
                }%>
                <li>
                   <a href="manage_result.jsp">Manage Result  <i class="fa fa-power-off fa-lg"></i></a>
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
                   <h4>Manage Nurse</h4>
                  </div>
                 <div class="col s1 push-s3 push-l4" >
                   <a href="dashboard.jsp" class="btn-floating btn-large waves-effect waves-light red"><i class="material-icons">home</i></a>
                   </div>
                   	                  <%
	                  sql="Select root_hospital.*,root_practice.* from root_hospital INNER JOIN root_practice ON root_practice.practiceID=root_hospital.practiceID where root_hospital.hospitalID='"+hosid+"'";
	                  String logo1="",logo2="";
	                  prs=connection.prepareStatement(sql);
	                  resultSet=prs.executeQuery();
	                  while(resultSet.next())
	                  {
	                	  logo1=resultSet.getString("root_practice.logo");
	                	  logo2=resultSet.getString("root_hospital.logo");
	                  }
	                  %>
                 <div class="col s1 push-s4" >
                   <img src=<%=logo1 %>>
                   </div>
                 <div class="col s1 push-s4" >
                   <img src=<%=logo2 %>>
                   </div>  
                </div>

                <div class="row">
                   <div class="push-s7 push-m10 push-l10 col s4 m3 l2">
                    <a class="waves-effect waves-light btn" href="create_nurse.jsp">Add</a>
                  </div>
                   <div class="push-s7 push-m10 push-l6 col s4 m3 l2">
                    <a target="_blank" href="audittrials.jsp?str=Nurse" class="waves-effect waves-light btn">Audit Trials</a>
                  </div>                   
                </div>
                <div class="row">
                    <div class="col s12 m12 l12">
                    <%
                try{ 
                    connection = DriverManager.getConnection(connectionUrl+dbName, userId, password);
                    statement=connection.createStatement();
                    sql ="SELECT * FROM nurse_detail where creator='"+creator+"'";
                    System.out.println(sql);
                    resultSet = statement.executeQuery(sql);
                    %>
                        <table class="highlight centered striped">
                            <thead>
                              <tr>
                              <th> Full Name</th>
                              <th> Username</th>
                              <th> Edit </th>
                              <th> Enable/Disable </th>
                              <th> Status </th>
                              <th> Created By </th>
                              <th> Start Date</th>
                              <th> Expiry Date</th>
                              </tr>
                            </thead>
                            <tbody>
                            <% while(resultSet.next()){ %>
                              <tr>
                                <td><%= resultSet.getString("name") %></td>
                                <td><%= resultSet.getString("username") %></td>
                                <td><a class="waves-effect waves-light btn red"  onclick="setValue1(<%=resultSet.getString("id") %>)" href="#modal1">Edit</a></td>
                                <td><a class="waves-effect waves-light btn red"  onclick="setValue2(<%=resultSet.getString("id") %>)" href="#modal2">Enable/Disable</a></td>
                                <td><%=resultSet.getString("status") %></td>
                                <td><%=resultSet.getString("creator") %></td>
                                <td><%=resultSet.getString("startdate") %></td>
                                <td><%=resultSet.getString("expirydate") %></td>
                              </tr>
                             </tbody>
                             <%}%>
                        </table>
                    </div>
                </div>                        
            </div>
        </div>
        <!-- /#page-content-wrapper -->
        
<%
				
connection.close();
}
catch (Exception e) 
{
e.printStackTrace();
out.println("error"+e);
}
%>

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
<script>
function confirmDelete(uname) {
    var test = confirm("Are you sure you want to delete this user ?");
    if(test==true)
        window.location = 'delete_nurse.jsp?id='+uname;
        }
 </script>  
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
			document.editForm.action="edit_nurse.jsp";
			document.editForm.submit();
		}
	if(val==2)
		{
			document.toggleForm.action="POST";
			document.toggleForm.action="toggle_nurse.jsp";
			document.toggleForm.submit();
		}
}
</script>
<script type="text/javascript" src="js/materialize.min.js"></script>

</body>
</html>