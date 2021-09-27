<%@page import="mybatis.dao.MemoDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%
    String idx = request.getParameter("idx");
    
    int cnt = 0;
    
    if(idx != null){
    	//
    	cnt = MemoDAO.exit(idx);
    }
    %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<style>
			.btn{
		width: 70px;
		height: 20px;
		text-align: center;
		padding:0px;		
	}
	
	.btn a{
		display: block;
		width: 100%;
		padding: 4px;
		height: 20px;
		line-height: 20px;
		background: #27a;
		color: #fff;
		border-radius: 3px;
		text-decoration: none;
		font-size: 12px;
		font-weight: bold;
	}
	.btn a:hover{
		background: #fff;
		color: #27a;
		border: 1px solid #27a;
	}
	
	</style>
</head>
<body>

<%
	if(cnt == 1){
%>
		<p>삭제 성공!!</p>
<%
	}else{
%>
		<p>삭제 실패 다시시도하세요!</p>
<%} %>
		<p class="btn">
			<a href="memo_list.jsp">목록</a>
		</p>

</body>
</html>