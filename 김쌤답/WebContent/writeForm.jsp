<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="color.jspf" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 새글쓰기</title>
<link href="style.css" rel="stylesheet" type="text/css">
<script src="script.js" type="text/javascript"></script>
</head>
<body bgcolor="<%=bodyback_c%>">

<% 
  int num = 0, ref = 1, reStep = 0, reLevel = 0;
  String strV = "";
  try{
    if(request.getParameter("num")!=null){
     num=Integer.parseInt(request.getParameter("num"));
     ref=Integer.parseInt(request.getParameter("ref"));
     reStep=Integer.parseInt(request.getParameter("reStep"));
     reLevel=Integer.parseInt(request.getParameter("reLevel"));
     strV="[답변]";
     %>
      <p>답글쓰기</p>
      <%
    }
    else{
    %>
    	<p>글쓰기</p>
    	<%
    }
%>

<form action="writePro.jsp" method="post" name="writeform" enctype="multipart/form-data" onsubmit="return writeSave()">
	<input type="hidden" name="num" value="<%=num%>">
	<input type="hidden" name="ref" value="<%=ref%>">
	<input type="hidden" name="reStep" value="<%=reStep%>">
	<input type="hidden" name="reLevel" value="<%=reLevel%>">
<table>
<tr>
  <th align="right" colspan="2" bgcolor="<%=value_c%>">
    <a href="list.jsp">글목록</a>
  </th>
</tr>
<tr>
	<th bgcolor="<%=value_c%>" >이름</th>
	<td align="left"><input type="text" size="10" maxlength="10" name="writer"
	  ></td>
</tr>
<tr>
  <th bgcolor="<%=value_c%>">제목</th>
  <td align="left">
  <input type="text" size="40" maxlength="50" name="subject"
    value="<%=strV %>"></td>
</tr>
<tr>
  <th bgcolor="<%=value_c%>">email</th>
  <td align="left"><input type="text" size="40" maxlength="30" name="email"
   style="ime-mode:inactive;"></td>
</tr>
<tr>
  <th bgcolor="<%=value_c%>">내용</th>
  <td align="left"><textarea rows="13" cols="40" style="resize:none" name="content"></textarea></td>
</tr>
<tr>
  <th bgcolor="<%=value_c%>">파일추가</th>
  <td align="left"><input type="file" name="filename">
  </td>
</tr>
<tr>
  <th bgcolor="<%=value_c%>">비밀번호</th>
  <td align="left"><input type="password" size="8" maxlength="12" name="passwd"></td>
</tr>
<tr>
  <th colspan="2" bgcolor="<%=value_c%>">
    <input type="submit" value="글쓰기">
    <input type="reset" value="다시작성">
    <input type="button" value="목록보기" onClick="window.location='list.jsp'">
  </th>
</tr>
</table>
</form>

<p> <%=request.getRemoteAddr() %></p>
<%
  } catch(Exception e) {
	  
  }
%>
</body>
</html>












