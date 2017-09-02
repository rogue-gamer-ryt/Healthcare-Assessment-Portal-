<%@ page import="java.io.*,java.util.*, javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="org.apache.poi.ss.usermodel.Cell "%>
<%@ page import="org.apache.poi.ss.usermodel.Row "%>
<%@ page import="org.apache.poi.xssf.usermodel.XSSFRow "%>
<%@ page import="org.apache.poi.xssf.usermodel.XSSFSheet "%>
<%@ page import="org.apache.poi.xssf.usermodel.XSSFWorkbook "%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.sql.Statement"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.Connection"%>
<%@ page import ="java.util.Date" %>
<%@ page import="java.text.*" %>
<%@ page import="java.io.File" %>
<%@ page import="java.io.FileInputStream" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="org.apache.poi.ss.usermodel.DateUtil"%>
<%@ page import="org.apache.poi.ss.usermodel.DataFormatter"%>
<head>
<meta http-equiv="refresh" content="0; url=confirm_patient.jsp">
</head>
<%
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
<%
      String path = (String)request.getAttribute("path");
      String[] str=new String[20];
      XSSFRow row;
      int x=0;
      FileInputStream fis = new FileInputStream(new File(path));
      XSSFWorkbook workbook = new XSSFWorkbook(fis);
      XSSFSheet spreadsheet = workbook.getSheetAt(0);
      Iterator < Row > rowIterator = spreadsheet.iterator();
      try
      {
      while (rowIterator.hasNext()) 
      {
         row = (XSSFRow) rowIterator.next();
         Iterator < Cell > cellIterator = row.cellIterator();
         while ( cellIterator.hasNext()) 
         {
            Cell cell = cellIterator.next();
            if(row.getRowNum()!=0)
            {
                switch (cell.getCellType()) 
                {  
                   case Cell.CELL_TYPE_NUMERIC:
                	   if (DateUtil.isCellDateFormatted(cell)) 
                	   {
                		   SimpleDateFormat sdf = new SimpleDateFormat("YYYY/MM/dd");
                		   str[x]=sdf.format(cell.getDateCellValue());
                       } 
                	   else 
                	   {
                    	   str[x]=String.valueOf(cell.getNumericCellValue());
                       }  
                   break;
                   
                   case Cell.CELL_TYPE_STRING:
                   str[x]=cell.getStringCellValue();
                   break;
                   
                   case Cell.CELL_TYPE_BLANK:
                	str[x]="";
                	break;
                }
                x++;
            }
        }
			try
			{
				Long nurse = (Long)session.getAttribute("nurseid");
				
				SimpleDateFormat f1 = new SimpleDateFormat("MMddhhmssSS");
				java.util.Date p1 = new java.util.Date();
				String pid = f1.format(p1);
				
				connection = DriverManager.getConnection(connectionUrl+dbName, userId, password);
				String name=str[0]+" "+str[1]+" "+str[2]+" "+str[3];
				
				String sql="Insert into patient_detail(pid,nurseid,name,gender,dob,illnessID,appdate,creator,contact,email,address) values ("+pid+","+nurse+",'"+name+"','"+str[4]+"','"+str[5]+"','"+str[6]+"','"+str[7]+"','"+creator+"','"+str[8]+"','"+str[9]+"','"+str[10]+"')";
				System.out.println(sql);
				prs=connection.prepareStatement(sql);
				prs.executeUpdate();
			    String action="Create ";
			    action=action.concat(name);
			    sql="Insert into log(action,actioncreator,actionpage,hospitalID) values('"+action+"','"+creator+"','Patient','"+hosid+"')";
			    prs=connection.prepareStatement(sql);
			    prs.executeUpdate();
				x=0;
			}
			catch(Exception e)
			{
				e.printStackTrace();
			}
         System.out.println();
      }
      fis.close();
      }
      catch(Exception ex) 
      {
          System.out.println(ex);
       }
%>