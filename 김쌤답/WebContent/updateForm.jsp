<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="board.*" %>
<%@ include file="color.jspf" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글수정</title>
<link href="style.css" rel="stylesheet" type="text/css">
<script src="script.js" type="text/javascript"></script>
</head>
<body bgcolor="<%=bodyback_c%>">
<%
int num=Integer.parseInt(request.getParameter("num"));
try {
	BoardDBBean dbPro = BoardDBBean.getInstance();
	BoardDataBean article = dbPro.updateGetArticle(num);
%>

<p>글수정</p>
<form action="updatePro.jsp" method="post" name="writeform" onsubmit="return writeSave()">
     <input type="hidden" name="num" value="<%=article.getNum()%>"></td>
<table>
<tr>
  <td align="right" colspan="2" bgcolor="<%=value_c%>">
    <a href="list.jsp">글목록</a>
  </td>
</tr>
<tr>
  <td bgcolor="<%=value_c%>" >이름</td>
  <td align="left">
    <input type="text" size="10" maxlength="10" name="writer"
      value="<%= article.getWriter() %>">
  </td>
</tr>
<tr>
  <td bgcolor="<%=value_c%>">제목</td>
  <td align="left"><input type="text" size="40" maxlength="50" name="subject"
   value="<%= article.getSubject() %>" ></td>
</tr>
<tr>
  <td bgcolor="<%=value_c%>">email</td>
  <td align="left"><input type="text" size="40" maxlength="50" name="email"
   value="<%= article.getEmail() %>" ></td>
</tr>
<tr>
  <td bgcolor="<%=value_c%>">내용</td>
  <td align="left"><textarea rows="13" cols="40" name="content"><%= article.getContent() %></textarea></td>
</tr>
<tr>
  <td bgcolor="<%=value_c%>">비밀번호</td>
  <td align="left"><input type="password" size="40" maxlength="50" name="passwd"></td>
</tr>
<tr>
  <td colspan="2" bgcolor="<%=value_c%>">
    <input type="submit" value="글수정">
    <input type="reset" value="다시작성">
    <input type="button" value="목록보기" onClick="window.location='list.jsp'">
  </td>
</tr>
</table>
</form>

<% } catch (Exception e) {} %>
</body>
</html>





















