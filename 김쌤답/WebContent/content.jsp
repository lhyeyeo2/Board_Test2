<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="board.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ include file="color.jspf" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 읽기</title>
<link href="style.css" ref="stylesheet" type="text/css">
</head>
<body>
<%
  SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
  int num = Integer.parseInt(request.getParameter("num"));
  String pageNum = request.getParameter("pageNum");
  try {
	  BoardDBBean dbPro = BoardDBBean.getInstance();
	  BoardDataBean article = dbPro.getArticle(num);
	  int ref=article.getRef();
	  int reStep=article.getReStep();
	  int reLevel=article.getReLevel();
%>
<p>글내용 보기</p>
<form>
<table>
<tr>
  <td align="center" bgcolor="<%=value_c%>">글번호</td>
  <td align="center" > <%= article.getNum() %></td>
  <td align="center" bgcolor="<%=value_c%>">조회수</td>
  <td align="center" > <%= article.getReadCount() %></td>
</tr>
<tr>
  <td align="center" bgcolor="<%=value_c%>">작성자</td>
  <td align="center" > <%= article.getWriter() %></td>
  <td align="center" bgcolor="<%=value_c%>">작성일</td>
  <td align="center" > <%= sdf.format(article.getRegDate()) %></td>
</tr>
<tr>
  <td align="center" bgcolor="<%=value_c%>">글제목</td>
  <td align="center" colspan="3" > <%= article.getSubject() %></td>
</tr>
<tr>
  <td align="center" bgcolor="<%=value_c%>">글내용</td>
  <td align="center" colspan="3" > <pre> <%= article.getContent() %> </pre> </td>
</tr>
<tr>
  <td colspan="4" bgcolor="<%=value_c%>">
    <input type="button" value="글수정"
     onclick="document.location.href='updateForm.jsp?num=<%= article.getNum() %>'">
    <input type="button" value="글삭제"
     onclick="document.location.href='deleteForm.jsp?num=<%= article.getNum() %>'">
    <input type="button" value="답글쓰기"
     onclick="document.location.href='writeForm.jsp?num=<%= article.getNum() %>&ref=<%= ref %>&reStep=<%= reStep %>&reLevel=<%= reLevel %>'">
    <input type="button" value="글목록"
     onclick="document.location.href='list.jsp?pageNum=<%= pageNum %>'">
  </td>
</tr>
</table>








</form>
<%	  
  } catch (Exception e) { }
%>

</body>
</html>



















