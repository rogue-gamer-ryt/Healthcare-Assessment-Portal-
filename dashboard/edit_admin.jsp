<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.lang.*"%>
<html>
<head>
   <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
  <title>Edit Admin</title>
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
String hosid=new String();
if((session.getAttribute("uid")!=null)||(session.getAttribute("hid")!=null))
{
	uid=(Long)session.getAttribute("uid");
	hosid=(String)session.getAttribute("hid");
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
        </div>        <!-- /#sidebar-wrapper -->

        <!-- Page Content -->
        <div id="page-content-wrapper" style="padding-top: 20px;">
            <div class="container-fluid">
                  <div class="row">
                  <div class="col s1" >
                   <a href="#menu-toggle" class="btn-floating btn-large waves-effect waves-light red" id="menu-toggle"><i class="material-icons">menu</i></a>
                   </div>
                   <div class="push-s3 push-l4 col s4 l4">
                   <h4>Edit Admin</h4>
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
                </div>
                <%
                connection=DriverManager.getConnection(connectionUrl+dbName, userId, password);
                sql="Select * from administrator where username='"+username+"' and password='"+pwd+"'";
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
                sql="Select * from administrator where uid="+userid;
                prs=connection.prepareStatement(sql);
                resultSet=prs.executeQuery();
                while(resultSet.next())
                {
                	String nm=resultSet.getString("name");
                	loc=nm.indexOf(" ");
                	String fname=nm.substring(0,loc);
                	String lname=nm.substring(loc+1);
                	access=resultSet.getString("noaccess");
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
                %>
				<div class="row">
				<div class="col s12 m6 push-l3">
				 <div class="row">
					<form class="col s12" method="POST" action="edit_admin_back.jsp">
					  <div class="row">
						<div class="input-field col s6">
						  <input name="fname" id="first_name" value="<%=fname %>" type="text" class="validate">
						  <label for="first_name">First Name</label>
						</div>
						<div class="input-field col s6">
						  <input name="lname" id="last_name" value="<%=lname %>" type="text" class="validate">
						  <label for="last_name">Last Name</label>
						</div>
					  </div>
					  <div class="row">
						<div class="input-field col s6">
						  <input name="uname" id="username" value="<%=resultSet.getString("username")%>"  type="text" class="validate">
						  <label for="username">Username</label>
						</div>
						<div class="input-field col s6">
						  <input name="pwd" id="password"  value="<%=resultSet.getString("password")%>" type="password" class="validate">
						  <label for="password">Password</label>
						</div>
					  </div>
					  <div class="row">
					  <h5> Access Rights</h5>
					  	<div class="input-field col s3">
					  	  <input type="checkbox" name="madmin" id="test1" <%if(str[1].equals("1")==false) { out.write("checked='checked'");}  %>  />
      					  <label for="test1">Manage Admin</label>							
						</div>
						<div class="input-field col s3">
					  	  <input type="checkbox" name="mnurse" id="test2" <%if(str[2].equals("2")==false) { out.write("checked='checked'");}  %>  />
      					  <label for="test2">Manage Nurse</label>							
						</div>
						<div class="input-field col s3">
					  	  <input type="checkbox" name="msurvey" id="test3" <%if(str[3].equals("3")==false) { out.write("checked='checked'");}  %>  />
      					  <label for="test3">Manage Survey</label>							
						</div>
						<div class="input-field col s3">
					  	  <input type="checkbox" name="massign" id="test4" <%if(str[4].equals("4")==false) { out.write("checked='checked'");}  %>  />
      					  <label for="test4">Assign Patients</label>							
						</div>
						<div class="input-field col s3">
					  	  <input type="checkbox" name="millness" id="test5" <%if(str[5].equals("5")==false) { out.write("checked='checked'");}  %>  />
      					  <label for="test5">Manage Illness</label>							
						</div>
					  </div>
					   <button class="btn waves-effect waves-light" type="submit" name="action">Submit
						<i class="material-icons right">send</i>
					   </button> 
					</form>
				  </div> 
                 </div>	
                 <%
                }
                 %>
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
function chkPass(val)
{
		
}
</script>
</body>
</html>