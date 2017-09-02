<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page import ="java.util.Date" %>
<%@ page import="java.io.*,java.util.*" %>
<%@ page import="javax.servlet.*,java.text.*" %>

<%
//String did = request.getParameter("did");
//String dname =  request.getParameter("dname");
//String client_id = "test"; 
String driverName = "com.mysql.jdbc.Driver";
String connectionUrl = "jdbc:mysql://localhost:3306/";
String dbName = "hik";
String userId = "root";
String password = "root";
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
  <title>Manage Survey</title>
  <link href="http://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
  <!--<link href="css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" type="text/css" href="css/bootstrap.css">-->
  <link rel="stylesheet" type="text/css" href="css/style.css">
  <link href="css/simple-sidebar.css" rel="stylesheet">
  <link type="text/css" rel="stylesheet" href="css/materialize.min.css"  media="screen,projection"/>

<%
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
%>
</head>
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
                   <h4>Manage Survey</h4>
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
                    <a href="create_survey.jsp" class="waves-effect waves-light btn">Add</a>
                  </div>
                   <div class="push-s7 push-m10 push-l6 col s4 m3 l2">
                    <a target="_blank" href="audittrials.jsp?str=Survey" class="waves-effect waves-light btn">Audit Trials</a>
                  </div>                   
                </div>
                <div class="row">
                    <div class="col s12 m12 l12">
                        <table class="highlight centered striped">
                            <thead>
                              <tr>
                              <th>Survey Name</th>
                              <th>View Questions</th>
                              <th>Edit</th>
                              <th>Enable/Disable</th>
                              <th>Created By</th>
                              <th>Assign Survey</th>
                              <th>Illness Assigned</th>
                              <th>Status</th>
                              <th>Created Date</th>
                              <th>Expiry Date</th>
                              </tr>
                            </thead>
                            <tbody>
							<% 
							  try
								{ 
								sql = "Select * from survey";
								prs = connection.prepareStatement(sql);
								resultSet = prs.executeQuery();
								int f=1;
								while(resultSet.next())
								{
								%>
                              <tr>
                                <td><%=resultSet.getString("name") %></td>
                                <td><a href="manage_questions.jsp?id=<%=resultSet.getString("id") %>" class="waves-effect waves-light btn red">View Questions</a></td>
                                <td><a class="waves-effect waves-light btn red" onclick="setValue1(<%=resultSet.getString("id") %>)" href="#modal1">Edit</a></td>
                                <td><a class="waves-effect waves-light btn red" onclick="setValue2(<%=resultSet.getString("id") %>)" href="#modal2">Enable/Disable</a></td>
                                <td><%=resultSet.getString("creator") %></td>
                                <td><a class="waves-effect waves-light btn red" href="assign_survey.jsp?sid=<%=resultSet.getString("id")%>"> Assign</a></td>
                                <td><%=resultSet.getString("assigned") %></td>
                                <td><%=resultSet.getString("status") %></td>
                                <td><%=resultSet.getString("startdate") %></td>
                                <td><%=resultSet.getString("expirydate") %></td>
                              </tr>
                              <%
								}
								connection.close();
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
          <input id="userid" name="surveyid" class="uid" type="uid" class="validate">
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
          <input id="userid" name="surveyid" class="uid" type="uid" class="validate">
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
    <!-- /#wrapper -->

    <!-- jQuery -->
    <script src="js/jquery.js"></script>

    <!-- Bootstrap Core JavaScript -->
    <script src="js/bootstrap.min.js"></script>

    <!-- Menu Toggle Script -->
<script src="js/jquery.js"></script>  
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
			document.editForm.action="edit_survey.jsp";
			document.editForm.submit();
		}
	if(val==2)
		{
			document.toggleForm.action="POST";
			document.toggleForm.action="toggle_survey.jsp";
			document.toggleForm.submit();
		}
}
</script>
<script type="text/javascript" src="js/materialize.min.js"></script>
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
</body>
</html>