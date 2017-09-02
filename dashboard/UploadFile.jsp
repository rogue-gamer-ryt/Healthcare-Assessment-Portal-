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
<%
String nurse = new String();
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
<head>
<meta http-equiv="refresh" content="0; url=ReadSheet.jsp">
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
   if ((contentType.indexOf("multipart/form-data") >= 0)) {

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
            String name  = (String)fi.getFieldName();
                if(name.equalsIgnoreCase("nursename"))
                {
                    nurse=(String)fi.getString();
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
            file = new File(request.getServletContext().getRealPath("")+ filePath + fileName.substring( fileName.lastIndexOf("\\"))) ;
            }
			else
			{
            file = new File(request.getServletContext().getRealPath("")+ filePath + fileName.substring(fileName.lastIndexOf("\\")+1)) ;
            }
            fi.write( file );
            String path=  request.getServletContext().getRealPath("")+"/Upload/" + fileName.substring(fileName.lastIndexOf("\\")+1);
            String sql="Select id from nurse_detail where username='"+nurse+"'";
            prs=connection.prepareStatement(sql);
            resultSet=prs.executeQuery();
            while(resultSet.next())
            {
         	   		id=resultSet.getLong("id");
         			session.setAttribute("nurseid",id);
            }
            request.setAttribute("path",path);
            RequestDispatcher rd = request.getRequestDispatcher("ReadSheet.jsp");
            rd.forward(request, response);
            }
         }
      }
      catch(Exception ex) 
      {
         System.out.println(ex);
      }
   }
%>