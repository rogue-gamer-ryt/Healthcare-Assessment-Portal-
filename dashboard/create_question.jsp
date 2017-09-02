<%@page import="java.sql.*"%>
<%@page import="java.lang.*"%>
<%@ page import ="java.util.Date" %>
<%@ page import="java.io.*,java.util.*" %>
<%@ page import="javax.servlet.*,java.text.*" %>

<%
Date dNow = new Date();
SimpleDateFormat ft = new SimpleDateFormat("yyyyMMddHHmmssSSS");
String cid = "" + ft.format(dNow);
%>

<html>
<head>
  <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
  <title>Create Question</title>
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
                   <h4>Create Question</h4>
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
                <form class="col s12" method="POST" action="create_question_back_test.jsp">
                  <div class="row">
                    
                      <div class="row">
                        <div class="input-field col s12">
                          <textarea id="textarea1" name="quedesc" class="materialize-textarea" required></textarea>
                          <label for="textarea1">Question</label>
                        </div>
                      </div>
                    
                  </div>
                    
                      <div class="row">
                        
                        <div class="input-field col s6">
                             <label for="textarea3">Question ID<br><%=cid %></label>
                          <textarea id="textarea1" name="cid" class="materialize-textarea" hidden><%=cid %></textarea>
                             
                        </div>
                        
                      </div>
                    
                  
                  <div class="row">

                  <div class="input-field col s12">
                    <select name="restype" onchange="callFunc(this)" required>
                      <option value="" disabled selected>Choose your option</option>
                      <option name="ip" value="1">Textbox</option>
                      <option name="ip" value="2">List</option>
                      <option name="ip" value="3">Checkbox</option>
                      <option name="ip" value="4">Dropdown</option>
                      <option name="ip" value="5">Slider</option>
                      <option name="ip" value="6">Date</option>
                    </select>
                    <label>Select type of answer</label>
                  </div>
                  </div>
                  <div class="row hide" id="limits">
                  <span class="col s8">
                  <input id="ll" type="number" name="ll" placeholder="Enter lower limit " style="color:black" class="col s6" style="display:inline">
                  <input id="hl" type="number" name="hl" placeholder="Enter higher limit" style="color:black" class="col s6" style="display:inline">
                  </span>
                  </div>
                  <div class="row">
                  <span class="myForm hide" id="myForm" style="display:inline">
                  <input id="num" type="number" name="num" placeholder="Enter number of options" style="color:black" class="col s6" style="display:inline">
                  <button class="col s2 push-s2 btn waves-effect waves-light" style="display:inline" onclick="addBoxes()">Add</button>
                  </span>
                  </div>                  
                  <div class="row">
                  <span class="col s8" id="opsc">
                  </span>        
                  </div>
                  <div class="row">
                    <button class="btn waves-effect waves-light" type="submit" name="action">Submit
                    <i class="material-icons right"></i>
                    </button>
                  </div>
                </form>
              </div> 
            </div> 
          </div>       
        </div>
      
        <!-- /#page-content-wrapper -->

    
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

<script src="js/jquery-3.1.1.min.js"></script>  

<script type="text/javascript" src="js/materialize.min.js"></script>
<script>
function addBoxes()
    {
        var count;
        var n=document.getElementById("num").value;
	        for(count=1;count<=n;count++)
	        {
	            
	        var br=document.createElement("br");
	        var x=document.createElement("input");
	        var y=document.createElement("input");    
	        var z=document.createElement("span");
	        
	        x.setAttribute("type","text");
	        x.setAttribute("required","true");
	        x.setAttribute("name","option_"+count);
	        x.setAttribute("Placeholder","Option Name");
	        x.setAttribute("display","inline");
	        x.setAttribute("class","col s5");
	        
	        y.setAttribute("type","number");
	        y.setAttribute("required","true");
	        y.setAttribute("name","score_"+count);
	        y.setAttribute("Placeholder","Score");
	        y.setAttribute("display","inline");    
	        y.setAttribute("class","col s5 push-s2");
	        
	        z.appendChild(x);
	        z.appendChild(y);
	        //z.appendChild(br)
	        z.setAttribute("display","block");
	        z.setAttribute("id","opsc_"+count);
	        
	        document.getElementById("opsc").appendChild(z);
	        }
    }
function callFunc(val)
    {
		var choose=parseInt(val.value);
        switch(choose)
            {
        		case 1:
                    $("#myForm").addClass("hide");
                    $("#limits").addClass("hide");  
                    clearText();
        		break;
        		
                case 2:
                $("#myForm").removeClass("hide");	
                $("#limits").addClass("hide");
                clearText();
                break;
                
                case 3:
                $("#myForm").removeClass("hide");
                $("#limits").addClass("hide");
                clearText();
                break;
                
                case 4:
                $("#myForm").removeClass("hide");
                $("#limits").addClass("hide");
                clearText();
                break;
                
                case 5:
                $("#myForm").removeClass("hide");
                $("#limits").removeClass("hide");
                clearText();
                break;
                
                case 6:
                    $("#myForm").addClass("hide");
                    $("#limits").addClass("hide");  
                    clearText();
        		break;
            }
    }
function clearText()
{
    parentDiv = "opsc";
    var num=document.getElementById("num").value;
    while ( num>= 0)
    {
        childDiv = "opsc_" + num;
        removeElement(parentDiv, childDiv);
        num--;
    }
    document.getElementById("num").value="";
}
function clearAll()
{
    parentDiv = "myForm";
    while (i >= 1)
    {
        childDiv = "id_" + i;
        removeElement(parentDiv, childDiv);
        i--;
    }
    removeElement(parentDiv, 'typeOptions');
    total = 0;
}
function removeElement(parentDiv, childDiv)
{
    if (childDiv === parentDiv)
    {
        alert("The parent div cannot be removed.");
    } 
    else if (document.getElementById(childDiv))
    {
        var child = document.getElementById(childDiv);
        var parent = document.getElementById(parentDiv);
        parent.removeChild(child);
    } 
    else
    {
        //alert("Child div has already been removed or does not exist.");
        return false;
    }
}
</script>
</body>
</html>