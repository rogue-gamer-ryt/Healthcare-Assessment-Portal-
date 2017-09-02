<%@ page import="java.io.*,java.util.*, javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="java.io.File"%>
<%@ page import="org.apache.commons.fileupload.*" %>
<%@ page import="org.apache.commons.fileupload.disk.*" %>
<%@ page import="org.apache.commons.fileupload.servlet.*" %>
<%@ page import="org.apache.commons.io.output.*" %>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page import ="java.util.Date" %>
<%@ page import="java.io.*,java.util.*" %>
<%@ page import="javax.servlet.*,java.text.*" %>
<%
String creator = new String();
//String client_id = "test"; 
String name=new String();
String city=new String();
String path=new String();
String contact=new String();
String address=new String();
String practice=new String();

String driverName = "com.mysql.jdbc.Driver";
String connectionUrl = "jdbc:mysql://localhost:3306/";
String dbName = "hik";
String userId = "root";
String password = "root";
try 
{
Class.forName(driverName);
} 
catch (ClassNotFoundException e) {
e.printStackTrace();
}

Connection connection = null;
PreparedStatement prs;
ResultSet resultSet = null;
if((session.getAttribute("uid")!=null))
{
	creator=(String)session.getAttribute("create");
}
else
{
	response.sendRedirect("../User/Login_root.html");  
}
%>
<head>
<meta http-equiv="refresh" content="0; url=manage_hospital.jsp">
</head>

<%
Long id =0L;
connection= DriverManager.getConnection(connectionUrl+dbName,userId,password);
int maxFileSize = 5000 * 1024;
int maxMemSize = 5000 * 1024;
File file;
ServletContext context = pageContext.getServletContext();
String filePath = "/Upload/";
// Verify the content type
String contentType = request.getContentType();
if ((contentType.indexOf("multipart/form-data") >= 0)) 
{

   DiskFileItemFactory factory = new DiskFileItemFactory();
   // maximum size that will be stored in memory
   factory.setSizeThreshold(maxMemSize);
   // Location to save data that is larger than maxMemSize.
   factory.setRepository(new File("c:\\temp"));

   // Create a new file upload handler
   ServletFileUpload upload = new ServletFileUpload(factory);
   // maximum file size to be uploaded.
   upload.setSizeMax( maxFileSize );
   try
   { 
      // Parse the request to get file items.
      List fileItems = upload.parseRequest(request);
      // Process the uploaded file items
      Iterator i = fileItems.iterator();
      while ( i.hasNext () ) 
      {
         FileItem fi = (FileItem)i.next();
         if(fi.isFormField())
         {
        	 String ntype=(String)fi.getFieldName();
             if(ntype.equals("hname"))
             {
                 name=(String)fi.getString();
             }
             else if(ntype.equals("hcity"))
             {
            	 city=(String)fi.getString();
             }
             else if(ntype.equals("hcontact"))
             {
            	 contact=(String)fi.getString();
             }
             else if(ntype.equals("haddress"))
             {
            	 address=(String)fi.getString();
             }
             else if(ntype.equals("practice"))
             {
            	 practice=(String)fi.getString();
             }
         }
         else if ( !fi.isFormField () )	
         {
        	 
         // Get the uploaded file parameters
         String fieldName = fi.getFieldName();
         String fileName = fi.getName();
         boolean isInMemory = fi.isInMemory();
         long sizeInBytes = fi.getSize();
         // Write the file
         if( fileName.lastIndexOf("\\") >= 0 )
			{
         file = new File( request.getServletContext().getRealPath("")+ filePath + fileName.substring( fileName.lastIndexOf("\\"))) ;
         	}
			else
			{
         file = new File( request.getServletContext().getRealPath("")+ filePath + fileName.substring(fileName.lastIndexOf("\\")+1)) ;
         	}
         fi.write( file );
        path= "../Upload/"+fileName.substring(fileName.lastIndexOf("\\")+1);
        SimpleDateFormat f1 = new SimpleDateFormat("MddhhmmssSS");
     	java.util.Date d1 = new java.util.Date();
     	String hid = f1.format(d1);
         String sql="Insert into root_hospital(hospitalID,practiceID,name,city,contact,address,logo,creator) values ('"+hid+"','"+practice+"','"+name+"','"+city+"','"+contact+"','"+address+"','"+path+"','"+creator+"')";
         prs=connection.prepareStatement(sql);
         prs.executeUpdate();
         String action="Create ";
         action=action.concat(name);
         sql="Insert into root_log(action,actioncreator,actionpage) values('"+action+"','"+creator+"','Hospital')";
         prs=connection.prepareStatement(sql);
         prs.executeUpdate();
      	} 
      	}
      }
   catch(Exception ex) 
   {
      System.out.println(ex);
   }
}
%>