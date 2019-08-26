<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.FileRenamePolicy" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="java.io.File" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h3>cos 라이브러리를 이용한 파일 업로드 구현</h3>
    
    <%
      String saveDirectory = application.getRealPath("/FileUpload");
      int maxPostSize = 10 * 1024 * 1024;
      String encoding = "utf-8";
      FileRenamePolicy policy = new DefaultFileRenamePolicy();      
      String fileName = "fileName";

      MultipartRequest multipartRequest = 
    		  new MultipartRequest(request, saveDirectory, maxPostSize, encoding, policy);      
      File file = multipartRequest.getFile(fileName);
      fileName = file.getName();
      long fileSize = file.length();
      
      if(fileName == null){
        out.println("파일 업로드 실패");
      }else{
    %>
      <table border="1">
        <tr>
          <td>올린이</td>
          <td><%=multipartRequest.getParameter("name")%></td>
        </tr>
        <tr>
          <td>저장 디렉토리</td>
          <td><%=saveDirectory %></td>
        </tr>
        <tr>
          <td>파일명</td>
          <td width="10"><%=file.getName()%></td>
        </tr>
        <tr>
          <td>파일길이</td>
          <td><%=file.length()%></td>
        </tr>
      </table>
    <%
      }
    %>  
</body>
</html>