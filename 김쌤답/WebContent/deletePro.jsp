<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="board.BoardDBBean" %>
<% request.setCharacterEncoding("UTF-8"); %>

<%
int num=Integer.parseInt(request.getParameter("num"));
String pageNum=request.getParameter("pageNum");
String passwd=request.getParameter("passwd");

BoardDBBean dbPro = BoardDBBean.getInstance();
int check = dbPro.deleteArticle(num, passwd);

if(check == 1){
	// 글목록으로 이동
//	String url="list.jsp?pageNum"+pageNum;
//	response.sendRedirect(url);
	%>
	<meta http-equiv="Refresh" content="0;url=list.jsp?pageNum=<%=pageNum%>" >
	<%	
} else if(check == 2) {
	  // 경고창 후 비밀번호 입력화면
	  %>
	  <script type="text/javascript" >
	   alert("비밀번호가 입력값을 초과하였습니다.");
	   history.go(-1);
	  </script>
	<%
	} else {
	// 경고창 후 비밀번호 입력화면
  %>
  <script type="text/javascript" >
   alert("비밀번호가 맞지 않습니다.");
   history.go(-1);
  </script>
<%
}
%>























    