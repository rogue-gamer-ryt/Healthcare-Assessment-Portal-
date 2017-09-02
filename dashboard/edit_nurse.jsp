<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page import ="java.util.Date" %>
<%@ page import="java.io.*,java.util.*" %>
<%@ page import="javax.servlet.*,java.text.*" %>

<%
String nid=request.getParameter("userid");
session.setAttribute("nurseid",nid);
String usr=request.getParameter("username");
String pss=request.getParameter("password");

String str[]=new String[10];
//String client_id = "test"; 
String driverName = "com.mysql.jdbc.Driver";
String connectionUrl = "jdbc:mysql://localhost:3306/";
String dbName = "hik";
String userId = "root";
String password = "root";
Long uid=0L;
String hosid=new String();
String create=new String();
if((session.getAttribute("uid")!=null)||(session.getAttribute("hid")!=null))
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
<%
try
{
	connection = DriverManager.getConnection(connectionUrl+dbName, userId, password);
	String sql="Select * from administrator where uid='"+uid+"'";
	prs=connection.prepareStatement(sql);
	resultSet=prs.executeQuery();
	while(resultSet.next())
	{
		if(usr.equals(resultSet.getString("username"))==false || pss.equals(resultSet.getString("password"))==false)
		{
			response.sendRedirect("manage_nurse.jsp");
		}
	}
	connection.close();
}
catch(Exception e)
{
	e.printStackTrace();
}
                try
                {
                	connection=DriverManager.getConnection(connectionUrl+dbName, userId, password);
                	String sql="Select * from nurse_detail where id='"+nid+"'";
                	prs=connection.prepareStatement(sql);
                	resultSet=prs.executeQuery();
                	while(resultSet.next())
                	{
                		String name=resultSet.getString("name");
                		int count=0;
                		while(count!=5)
                		{
                		if(name.indexOf(" ")!=-1)
                		{
                			int loc=name.indexOf(" ");
                			str[count]=name.substring(0,loc);
                			name=name.substring(loc+1);
                		}
                		else
                		{
                			str[count]=name;
                		}
                		count++;
                		}
                		str[5]=resultSet.getString("username");
                		str[6]=resultSet.getString("password");
                		str[7]=resultSet.getString("gender");
                	}
                	connection.close();
                }
				 catch(Exception e)
				{
					  e.printStackTrace();
				}
              	%>
<html>
<head>
  <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
  <title>Edit Nurse</title>
  <link href="http://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
  <!--<link href="css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" type="text/css" href="css/bootstrap.css">-->
  <link rel="stylesheet" type="text/css" href="css/style.css">
  <link href="css/simple-sidebar.css" rel="stylesheet">
  <link type="text/css" rel="stylesheet" href="css/materialize.min.css"  media="screen,projection"/>
<script>
window.onload=function()
{
  $(document).ready(function() {
    $('select').material_select();
  });
};      
</script>
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
                   <h4>Edit Nurse</h4>
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
				<div class="row">
				<div class="col s12 m6 push-l3 push-m3">
				 <div class="row">
					<form class="col s12" method="POST" action="edit_nurse_back.jsp">
					  <div class="row">
						<div class="input-field col s4">
								<select name="salutation" required>
								  <option value="" disabled selected>Choose your Salutation</option>
								  <option id="mr" value="Mr.">Mr.</option>
								  <option id="mrs" value="Mrs.">Mrs.</option>
								  <option id="ms" value="Ms.">Ms.</option>
								  <option id="dr" value="Dr.">Dr.</option>
								  <option id="prof" value="Prof.">Prof.</option>
								  <option id="rev" value="Rev.">Rev.</option>
								  <option id="other" value="Other">Other</option>
								</select>
								<label>Salutation</label>
						</div>		
					  </div>
					  <div class="row">			  
						<div class="input-field col s3">
						  <input name="fname" id="fname" type="text" class="validate">
						  <label for="first_name">First Name</label>
						</div>
						<div class="input-field col s3">
						  <input name="mname" id="mname" type="text" class="validate">
						  <label for="middle_name">Middle Name</label>
						</div>
						<div class="input-field col s3">
						  <input name="lname" id="lname" type="text" class="validate">
						  <label for="last_name">Last Name</label>
						</div>
						<div class="input-field col s3">
						  <input name="qual" id="qual" type="text" class="validate">
						  <label for="qual">Qualification</label>
						</div>						
					  </div>
					  <div class="row">
						<div class="input-field col s6">
						  <input name="uname" id="username" type="text" class="validate">
						  <label for="username">Username</label>
						</div>
						<div class="input-field col s6">
						  <input name="pwd" id="password" type="password" class="validate">
						  <label for="password">Password</label>
						</div>
					  </div>
					  <div class="row">
						 <div class="input-field col s12">
							<div class="input-field col s6">
								<select name="gender" required>
								  <option value="" disabled selected>Choose your Gender</option>
								  <option  id="male" value="Male">Male</option>
								  <option id=female" value="Female">Female</option>
								  <option id="other" value="Other">Others</option>
								</select>
								<label>Gender</label>
							  </div>
						  </div>
					  </div>
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
    
    </script>

<script src="js/jquery.js"></script>  
<script type="text/javascript" src="js/jquery-3.1.1.min.js"></script>
<script type="text/javascript" src="js/materialize.min.js"></script>
<script>
window.onload=edit;
function edit()
{
	var salutation="<%=str[0]%>";
	var fname="<%=str[1]%>";
	var mname="<%=str[2]%>";
	var lname="<%=str[3]%>";
	var qual="<%=str[4]%>";
	var username="<%=str[5]%>";
	var password="<%=str[6]%>";
	var gender="<%=str[7]%>";
	if(salutation=="Mr.")
		{
			document.getElementById("mr").selected=true;
			$('select').material_select();
		}
	else if(salutation=="Mrs.")
		{
			document.getElementById("mrs").selected=true;
			$('select').material_select();			
		}
	else if(salutation=="Rev.")
		{
		document.getElementById("rev").selected=true;
		$('select').material_select();
		}
	else if(salutation=="Dr.")
		{
		document.getElementById("dr").selected=true;
		$('select').material_select();
		}
	else if(salutation=="Ms.")
		{
		document.getElementById("ms").selected=true;
		$('select').material_select();
		}
	else if(salutation=="Prof")
		{
		document.getElementById("prof").selected=true;
		$('select').material_select();
		}
	else if(salutation=="Others")
		{
		document.getElementById("others").selected=true;
		$('select').material_select();
		}
	document.getElementById("fname").value=fname;
	document.getElementById("mname").value=mname;
	document.getElementById("lname").value=lname;
	document.getElementById("qual").value=qual;
	document.getElementById("username").value=username;
	document.getElementById("password").value=password;
	if(gender=="Male")
		{
		document.getElementById("male").selected=true;
		$('select').material_select();
		}
	else if(gender=="Female")
		{
		document.getElementById("female").selected=true;
		$('select').material_select();		
		}
	else if(gender="Others")
		{
		document.getElementById("other").selected=true;
		$('select').material_select();
		}
}
</script>
</body>
</html>