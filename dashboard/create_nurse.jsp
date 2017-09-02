<%@page import="java.sql.*"%>
<%@page import="java.lang.*"%>
<html>
<head>
  <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
  <title>Create Nurse</title>
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
                   <h4>Create Nurse</h4>
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
					<form class="col s12" name="myForm" id="myForm" method="POST" action="create_nurse_back.jsp">
					  <div class="row">
						<div class="input-field col s4">
								<select id="salutation" name="salutation" required>
								  <option value="" disabled selected>Choose your Salutation</option>
								  <option value="Mr.">Mr.</option>
								  <option value="Mrs.">Mrs.</option>
								  <option value="Ms.">Ms.</option>
								  <option value="Dr.">Dr.</option>
								  <option value="Prof.">Prof.</option>
								  <option value="Rev.">Rev.</option>
								  <option value="Other">Other</option>
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
						  <input name="pwd" id="password" type="password" onchange="myFunc(1)" class="validate">
						  <label for="password">Password</label>
						</div>
					  </div>
					  <div class="row">
						 <div class="input-field col s12">
							<div class="input-field col s6">
								<select id="gender" name="gender" required>
								  <option value="" disabled selected>Choose your Gender</option>
								  <option value="Male">Male</option>
								  <option value="Female">Female</option>
								  <option value="Others">Others</option>
								</select>
								<label>Gender</label>
							  </div>
						  </div>
					  </div>
					  <br>
					  <h4>Or</h4>					  
	                  <div class="row">
	                    <div class="file-field input-field">
	                      <div class="btn">
	                        <span>File</span>
	                        <input id=file name="file" onchange="myFunc(2)" type="file">
	                      </div>
	                    <div class="file-path-wrapper">
	                      <input class="file-path validate" type="text">
	                    </div>
	                  	</div>
	                  	<a href="../Upload/upload_nurse.xlsx" style="text-decoration:none" download>Dummy File for Nurse Excel</a>
	                  </div>						  
					   <button class="btn waves-effect waves-light" onclick="chkSubmit()">Submit
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
var x;
function myFunc(val)
{
	if(val==1)
	{
		document.getElementById("file").disabled = true;
		x=1;
	}
	else if(val==2)
	{
		document.getElementById("fname").disabled = true;
		document.getElementById("mname").disabled = true;
		document.getElementById("lname").disabled = true;
		document.getElementById("gender").disabled = true;
		document.getElementById("salutation").disabled = true;
		document.getElementById("username").disabled = true;
		document.getElementById("password").disabled = true;
		document.getElementById("myForm").enctype="multipart/form-data";
		x=2;
	}
}
function chkSubmit()
{
		if(x==1)
			{
				document.myForm.action="create_nurse_back.jsp";
				document.myForm.method="POST";
				document.myForm.submit();
			}
		else if(x==2)
			{
				document.myForm.action="create_nurse_read.jsp";
				document.myForm.method="POST";
				document.myForm.submit();
			}
}
</script>
</body>
</html>