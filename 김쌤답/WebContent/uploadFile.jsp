<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String saveDirectory = application.getRealPath("/FileUpload");
int maxPostSize = 10 * 1024 * 1024;
String encoding = "utf-8";
FileRenamePolicy policy = new DefaultFileRenamePolicy();      
String fileName = "filename";

MultipartRequest multipartRequest = 
    new MultipartRequest(request, saveDirectory, maxPostSize, encoding, policy);      
File file = multipartRequest.getFile(fileName);
fileName = file.getName();
long fileSize = file.length();

if(fileName == null){
  out.println("파일 업로드 실패");
}else{

}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>