<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="board.*" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ include file="color.jspf" %>
<%!
int pageSize=10;
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
//전자를  import 해온다.
%>

<% 
String pageNum=request.getParameter("pageNum");
if(pageNum==null){
	pageNum="1";
	
}
int currPage=Integer.parseInt(pageNum);
int startRow = (currPage-1) *pageSize +1;
int endRow = currPage*pageSize;
int count=0;
int number=0;
//List라는 자료형?은 <%@ page import="java.util.List"  관련있음
List<BoardDataBean> articleList = null;

BoardDBBean dbPro = BoardDBBean.getInstance();
count = dbPro.getArticleCount();
if (count>0) {
	dbPro.getArticles(startRow, endRow);
	//오라클이라 endRow씀
}
number=count-(currPage-1)*pageSize;
%>



<!-- currPage 뭐다? 오타조심.. 그줄이 뭐랑 닮았다?
짜놨던코드를 가져올꺼임 내용 놓쳤다(-) -->
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
//for(articleList)
for(int i=0; i<articleList.size(); i++){ 
	  BoardDataBean article=articleList.get(i);
%>    
 <tr height="30">
  <td width="50"><%=number--%></td>
  <td width="250" align="left"> 
  <% //요기서 6줄이상은 %태그 잘 끊어야함. html이냐 아니냐 따라서
  int wid=0;
  if(article.getReLevel()>0){
	  wid= 5*(article.getReLevel());
	  %>
	  <img src="image/level.png" width="<%=wid%>" height="16">
	  <img src="image/re.png">
	  <% 
	  } else {
		%>
	  <img src="image/lavel.png" width="<%=wid %>" height= "16">
	  <% 
  }
  
  %>
  <%=article.getSubject() %>
  </td>
  <td><%=article.getWriter() %></td>
   <td><%=article.getRegDate() %></td>
    <td><%=article.getReadCount() %></td>
    <td><%=article.getIp() %></td>
        
  
 </tr>   
<% } %>  
<% } %>
<!-- /td 앞에 %태그 있단거 -->
<!-- 전자의 number-- 는 후위감소 이고 이유는 놓침. 2가 순서상 제목이란거랑 상관있나? -->

</body>
</html>