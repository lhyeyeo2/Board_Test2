<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="board.*" %>
<%@ include file="color.jspf" %>
<%
int num=Integer.parseInt(request.getParameter("num"));
String pageNum= request.getParameter("pageNum");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글삭제</title>
<link href="style.css" rel="stylesheet" type="text/css">
<script src="script.js" type="text/javascript">
</script>
</head>
<body bgcolor="<%=bodyback_c%>">
<p>글삭제</p>
<form method="post" action="deletePro.jsp?pageNum=<%=pageNum%>" name="delFom" onsubmit="return deleteSave()">
<table>
<tr height="30">
<td align="center" bgcolor="<%=value_c%>"><b>비밀번호를 입력해 주세요.</b></td>
<tr height="30">
  <td align="center" bgcolor="<%=value_c%>">비밀번호 :
  <input type="password" size="8" maxlength="12" name="passwd">
	<input type="hidden" name ="num" value="<%=num%>">
	</td>
</tr>
<tr>
  <td align="center" bgcolor="<%=value_c%>">
    <input type="submit" value="글삭제">

    <input type="button" value="목록보기" onClick="window.location.href='list.jsp?pageNum=<%=pageNum%>'">
  </td>
</tr>

</table>


</form>

</body>
</html>






