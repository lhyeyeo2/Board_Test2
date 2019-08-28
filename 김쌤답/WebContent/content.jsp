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
<link href="style.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
  function down(filename){
     document.downForm.filename.value=filename;
     document.downForm.submit();
  }
</script>
</head>
<body bgcolor="<%=bodyback_c%>">
<form name=downForm action="download.jsp" method="post">
  <input type="hidden" name="filename">
</form>
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
		String filename = article.getFilename();
		long filesize = article.getFilesize();
%>
<p>글내용 보기</p>
<form name="bodyForm">
<table>
<tr height="30">
  <td align="center" width="125" bgcolor="<%=value_c%>">글번호</td>
  <td align="center" width="125" > <%= article.getNum() %></td>
  <td align="center" width="125" bgcolor="<%=value_c%>">조회수</td>
  <td align="center" width="125" > <%= article.getReadCount() %></td>
</tr>
<tr height="30">
  <td align="center" bgcolor="<%=value_c%>">작성자</td>
  <td align="center" > <%= article.getWriter() %></td>
  <td align="center" bgcolor="<%=value_c%>">작성일</td>
  <td align="center" > <%= sdf.format(article.getRegDate()) %></td>
</tr>
<tr height="30">
  <td align="center" bgcolor="<%=value_c%>">글제목</td>
  <td align="left" colspan="3" ><%= article.getSubject() %></td>
</tr>
<tr>
  <td align="center" bgcolor="<%=value_c%>">글내용</td>
  <td align="left" colspan="3" ><pre><%= article.getContent() %></pre> </td>
</tr>
<tr>
  <td align="center" bgcolor="<%=value_c%>">첨부파일</td>
  <td align="left" colspan="3" >
  <% if(filename==null || filename.equals("")) { %>등록된 파일이 없습니다. 
	<% } else { %><a href="javascript:down('<%=filename %>')"><%=filename %>&nbsp;&nbsp;&nbsp;&nbsp;(<%=filesize %>bytes)</a>
	<% } %>
  </td>
</tr>
<tr height="30">
  <td colspan="4" bgcolor="<%=value_c%>">
    <input type="button" value="글수정"
     onclick="document.location.href='updateForm.jsp?num=<%= article.getNum() %>&pageNum=<%= pageNum %>'">
    <input type="button" value="글삭제"
     onclick="document.location.href='deleteForm.jsp?num=<%= article.getNum() %>&pageNum=<%= pageNum %>'">
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



















