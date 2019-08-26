<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>    
<%@ page import="com.oreilly.servlet.multipart.FileRenamePolicy"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>

<!-- import좀 외우자 -->
<html>
<head>
<meta charset="UTF-8">
<title>cos 라이브러리를 이용한 파일 업로드 구현</title>
</head>
<body>
	<h3>cos 라이브러리를 이용한 파일 업로드 구현</h3>
	
	<%
	//전송담당하는 외우거나 검색해보거나
	String saveDirectory = application.getRealPath("/FileUPload");
	//전자 절대경로를 사용하겠다.
	int maxPostSize = 10* 1024 * 1024;
	//전자 이보다 크면 에러를 낸다.
	String encoding = "utf-8";
	//(-) 장소찾는중 filename으로 바꾼다.
	FileRenamePolicy policy = new DefaultFileRenamePolicy();
	
	String fileName = "fileName";
	
	MultipartRequest multipartRequest = new MultipartRequest(request, saveDirectory, maxPostSize, encoding, policy);
	File file = multipartRequest.getFile(fileName);
	
	fileName = file.getName();
	long fileSize = file.length();
	
	if(fileName) == null){
	out.println("파일 업로드 실패");
	}else{
	%>
	
	<table boarder="1">
	<tr>
		<td>올린이</td>
		<td><%=multipartRequest.getParameter("name") %></td>
		</tr>
		<tr>
			<td>저장 디렉터리</td>
			<td><%=saveDirectory %></td>
			</tr>
			<tr>
				<td>파일명</td>
				<td width="10"><%=file.getName*() %></td>
			</tr>
			<tr>
			<td>파일길이</td>
			<td><%=file.length() %></td>
			<tr>
			
	</table>
	
	<%
	}
	
	%>

</body>
</html>

<!-- //파일업로드 안될때 클라이언트가 설정을 철저히 걸어놔서 안되는거임. -->