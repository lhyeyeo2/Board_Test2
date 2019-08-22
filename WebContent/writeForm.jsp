<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file ="color.jspf" %>
\<//%!WebContent.color.jspf로 만듬
//	String bodyback_c="#FFF0B5";
//	String value_c="#FFE271";
//\%//>	

<html>
<head>
<meta charset="UTF-8">
<title>게시판 새글쓰기</title>
<link href="style.css" rel="stylesheet" type="text/css">
<script src="script.js" type ="text/javascript"></script>
</head>
<body>
<%
	int num = 0, ref = 1, reStep = 0, reLevel= 0 ;
String strV = "";
try{
	if(request.getParameter("num") != null){
		num = Integer.parseInt(request.getParameter("num"));
		ref  = Integer.parseInt(request.getParameter("ref"));
		reStep = Integer.parseInt(request.getParameter("reStep"));
		reLevel = Integer.parseInt(request.getParameter("reLevel"));
	
	}
//getParameter 오타조심

%>
<P>글쓰기</P>
<form action="writePro.jsp" method="post" name="writeform" onsubmit="return writeSave()">
	<input type="hidden" name="num" value="<%=num %>">
	<input type="hidden" name="ref" value="<%=ref %>">
	<input type="hidden" name="re_step" value="<%=reStep %>">
	<input type="hidden" name="re_level" value="<%=reLevel %>">

<table>
<tr>
	<td align="right" colspan="2" bgcolor="blue">
	<a href="list.jsp">글목록</a> 
	</td>
</tr>
<tr>
	<td>이름</td>
	<td><input type="text" size="10" maxlength="10" name ="writer"></td>
</tr>	
<tr>
  <td>제목</td>
  <td><input type="password" size="40" maxlength="50" name="passwd"></td>
</tr>
<tr>
  <td>내용</td>
  <td><textarea rows="13" cols="40" name="content"></textarea></td>
</tr>
<tr>
  <td>비밀번호</td>
  <td><input type="password" size="40" maxlength="50" name="passwd"></td>
</tr>
<tr>
  <td colspan="2">
    <input type="submit" value="글쓰기">
    <input type="reset" value="다시작성">
    <input type="button" value="목록보기" onClick="window.location='list.jsp'">
  </td>
</tr>
</table>

</form>

<%
  } catch(Exception e) {
	  
  }
%>
</body>
</html>