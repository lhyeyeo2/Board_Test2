<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="board.*" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.FileRenamePolicy" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="java.io.File" %>
<% request.setCharacterEncoding("UTF-8"); %>

<%-- <jsp:useBean id="article" class="board.BoardDataBean">
  <jsp:setProperty name="article" property="*" />
</jsp:useBean>
 --%>
<%
BoardDataBean article = new BoardDataBean();

String saveDirectory = application.getRealPath("/FileUpload");
int maxPostSize = 10 * 1024 * 1024;
String encoding = "utf-8";
FileRenamePolicy policy = new DefaultFileRenamePolicy();      
String fileName = "filename";

MultipartRequest multi = 
    new MultipartRequest(request, saveDirectory, maxPostSize, encoding, policy);      
File file = multi.getFile(fileName);
fileName = file.getName();
long fileSize = file.length();

if(fileName == null){
  out.println("파일 업로드 실패");
}else{
	article.setNum(Integer.parseInt(multi.getParameter("num")));
	article.setWriter(multi.getParameter("writer"));
	article.setContent(multi.getParameter("content"));
	article.setSubject(multi.getParameter("subject"));
	article.setPasswd(multi.getParameter("passwd"));
  article.setFilename(fileName);
  article.setFilesize(fileSize);
}
%>

<%
article.setRegDate(new Timestamp(System.currentTimeMillis()));
article.setIp(request.getRemoteAddr());

BoardDBBean dbPro = BoardDBBean.getInstance();
dbPro.insertArticle(article);

response.sendRedirect("list.jsp");
%>