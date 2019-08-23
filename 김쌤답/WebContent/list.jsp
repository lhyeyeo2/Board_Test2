<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="board.*" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ include file="color.jspf"  %>
<%!
int pageSize = 10;
int pageBlock = 3;
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
%>
<% 
String pageNum=request.getParameter("pageNum");
if(pageNum==null){
	pageNum="1";
}
int currPage=Integer.parseInt(pageNum);
int startRow = (currPage-1)*pageSize + 1;
int endRow = currPage*pageSize;
int count=0;
int number=0;
List<BoardDataBean> articleList = null;

BoardDBBean dbPro = BoardDBBean.getInstance();
count = dbPro.getArticleCount();
if (count>0) {
	articleList = dbPro.getArticles(startRow, endRow);
}
number=count-(currPage-1)*pageSize;
%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판리스트</title>
<link href="style.css" rel="stylesheet" type="text/css">
</head>
<body bgcolor="<%=bodyback_c%>">
<p>글목록(전체 글:<%=count %>)</p>
<table>
	<tr>
		<td align="right" bgcolor="<%=value_c %>">
		  <a href="writeForm.jsp">글쓰기</a>
		</td>
	</tr>
</table>
<% if (count == 0) { %>
<table>
	<tr>
	    <td align="center">게시판에 저장된 글이 없습니다.</td>
	</tr>
</table>
<% } else {%>
<table> 
    <tr height="30" bgcolor="<%=value_c%>"> 
      <th align="center"  width="50"  >번 호</th> 
      <th align="center"  width="250" >제   목</th> 
      <th align="center"  width="100" >작성자</th>
      <th align="center"  width="150" >작성일</th> 
      <th align="center"  width="50" >조 회</th> 
      <th align="center"  width="100" >IP</th>    
    </tr>
<%
for(int i=0; i<articleList.size(); i++){ 
	  BoardDataBean article = articleList.get(i);
%>    
 <tr height="30">
  <td width="50"><%=number--%></td>
  <td width="250" align="left">
  <%
  int wid=0;
  if(article.getReLevel()>0){
	  wid= 15*(article.getReLevel());
	  %>
	  <img src="image/level.png" width="<%=wid%>" height="16">
	  <img src="image/re.png">
	  <%
  } else {
	  %>
    <img src="image/level.png" width="<%=wid%>" height="16">
    <%
  }
  %>
    <a href="content.jsp?num=<%=article.getNum() %>&pageNum=<%=currPage%>">
    <%=article.getSubject() %>
    </a>
  </td>
  <td><%=article.getWriter() %></td>
  <td><%=sdf.format(article.getRegDate())%></td> 
  <td><%=article.getReadCount() %></td>
  <td><%=article.getIp() %></td>
 </tr>   
<% } %>  
</table>
<%
  int pageCount= count/pageSize +(count % pageSize == 0 ? 0 : 1);
  
  int startPage = 1;  // 일단 시작 페이지를 1로 초기화
  if(currPage % pageBlock != 0 ) 
    startPage = (int)(currPage/pageBlock)*pageBlock+1;
  else
    startPage = ((int)(currPage/pageBlock)-1)*pageBlock+1;
  
  %> <p><%=startPage%></p> <p><%=currPage%></p><%
  
		  int endPage = startPage + pageBlock - 1;  // 10개 단위로 더해서  endpage
  if (endPage > pageCount)   //  그 값이 총페이지 보다 크면 endpage를 총 페이지로 바꿈.
    endPage = pageCount;
  
  if(startPage > pageBlock){
	  %>
	   <a href="list.jsp?pageNum=<%=startPage - pageBlock%>">[이전]</a>
	   <%
  }
  for(int i=startPage; i<=endPage; i++) {
	  %>
	  <a href="list.jsp?pageNum=<%= i %>">[<%= i %>]</a>
    <%
  }
  if(endPage < pageCount) {
	  %>
     <a href="list.jsp?pageNum=<%=startPage + pageBlock%>">[다음]</a>
     <%
  }
%>

<% } %>


</body>
</html>




















