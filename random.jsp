<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*" %>
<%@ page import="javax.servlet.*,java.text.*" %>
<%@ page import ="java.sql.*" %>
<%@ page import ="java.util.Date" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Hello World</title>
</head>
<body>
<%-- This is a JSP Comment before JSP Scriplet --%>
<%
    //Prints out to console
SimpleDateFormat format = new SimpleDateFormat("yyyyMMddhhmm");
java.util.Date date = new java.util.Date();
String str = format.format(date);
out.println(str);

SimpleDateFormat f1 = new SimpleDateFormat("yyMMddhhmmss");
java.util.Date d1 = new java.util.Date();
String hid = f1.format(d1);
out.println(hid);

SimpleDateFormat f2 = new SimpleDateFormat("yyyyMMddhhmmss");
java.util.Date d2 = new java.util.Date();
String uid = f2.format(d2);
out.println(uid);
%>
</body>
</html>
