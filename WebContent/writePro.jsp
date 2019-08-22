<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="board.BoardDBBean" %>
<% request.setCharacterEncoding("UTF-8"); %>

<jsp:useBean id="article" class="board.BoardDataBean">
  <jsp:setProperty name="article" property="*" />
</jsp:useBean>

<%
//request.setCharacterEncoding("UTF-8");
//위의 %태그  import 쓴 이유 인터넷s(-)
//set(1)과 set(2) 쓴 이유 인터넷s(-)
article.setRegDate(new Timestamp(System.currentTimeMillis()));
article.setIp(request.getRemoteAddr());

BoardDBBean dbPro = BoardDBBean.getInstance();
dbPro.insertArticle(article);

response.sendRedirect("list.jsp");
%>