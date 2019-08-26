<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<form action ="fileUpload.jsp" name="frmName" method="post"                      
     enctype="multipart/form-data">
    <input type="text" name="name">  
    <input type="file" name="fileName"> 
    <input type="submit" name="OK">   
</form>
</body>
</html>