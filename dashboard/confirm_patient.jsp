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
String name=new String();
Long nid =(Long)session.getAttribute("nurseid");
Long uid=0L;
String hosid=new String();
String create=new String();
if((session.getAttribute("uid")!=null)&&(session.getAttribute("hid")!=null))
{
	uid=(Long)session.getAttribute("uid");
	hosid=(String)session.getAttribute("hid");
	create=(String)session.getAttribute("uname");
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
  <title> Confirm Patient</title>
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
               <%
               sql="Select * from nurse_detail where id="+nid+"";
               connection = DriverManager.getConnection(connectionUrl+dbName, userId, password);
               prs=connection.prepareStatement(sql);
               resultSet=prs.executeQuery();
               while(resultSet.next())
               {
            	   name = resultSet.getString("name");
               }
               %>
                <div class="row">
                   <div class="push-s7 push-m10 col s4 m3 l4">
                    <h4>Nurse : <%=name%></h4>
                  </div>
                </div>
                <div class="row">
                    <div class="col s12 m12 l12">
                        <table class="centered striped">
                            <thead>
                              <tr>
                              <th>Name</th>
                              <th>Gender</th>
							  <th>DOB</th>
                              <th>Illness ID</th>
                              <th>Report Date</th>
                              <th> Contact Number </th>
                              <th> Email Address</th>
                              <th> Address </th>
                              <th>Delete</th>
                              </tr>
                            </thead>
                            <tbody>
							<% 
							  try
								{ 
								connection = DriverManager.getConnection(connectionUrl+dbName, userId, password);
							    sql = "Select * from patient_detail where nurseid="+nid+"";
								prs = connection.prepareStatement(sql);
								resultSet = prs.executeQuery();
								while(resultSet.next())
								{
							%>
                              <tr>
                                <td><%=resultSet.getString("name") %></td>
                                <td><%=resultSet.getString("gender") %></td>
                                <td><%=resultSet.getDate("dob") %></td>
                                <td><%=resultSet.getString("illnessID") %></td>
                                <td><%=resultSet.getDate("appdate") %></td>
                                <td><%=resultSet.getString("contact") %></td>
                                <td><%=resultSet.getString("email") %></td>
                                <td><%=resultSet.getString("address") %></td>
                                <td><a onclick="confirmDelete('<%=resultSet.getString("pid") %>')" class="btn-floating waves-effect waves-light red"><i class="material-icons">delete</i></a></td>
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
                <div class="row">
                   <div class="push-s7 push-m10 push-l10 col s4 m3 l2">
                    <a onclick="confirmAdd()"  class="waves-effect waves-light btn">Confirm</a>
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
    
    </script>

<script src="js/jquery.js"></script>  

<script type="text/javascript" src="js/materialize.min.js"></script>

<script>
function confirmDelete(id) {
    var test = confirm("Are you sure you want to delete this patient details ?");
    if(test==true)
        window.location = 'delete_patient.jsp?id='+id;
        }
function confirmAdd() {
    var test = confirm("Confirm Assigning these Patients to the Nurse ?");
    if(test==true)
        window.location = 'dashboard.jsp';
        }
 </script>
</body>
</html>