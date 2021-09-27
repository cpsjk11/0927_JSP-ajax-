<%@page import="java.io.PrintWriter"%>
<%@page import="mybatis.dao.MemoDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// 여기는 memo_list에서 인자 값을 받아 DAO에 넣어서 DB를 호출해보자!
	
	// 먼저 요청시 한글처리
	request.setCharacterEncoding("utf-8");

	// 파라미터를 받자!
	String writer = request.getParameter("writer");
	String content = request.getParameter("content");
	String ip = request.getParameter("ip");
	
	// 받은 인자들을 DAO에 넣어서 DB를 호출하자
	boolean chk = MemoDAO.setAdd(writer, content, ip);
	
	// 응답을 위한 스트림 준비!
	PrintWriter outs = response.getWriter();
	
	outs.println(chk);
	
	outs.close();
	
	
	
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
<!-- 
<%
	//if(chk){
%>
		<p>저장 성공!!</p>
<%
	//}else{
%>
		<p>저장 실패 다시시도하세요!</p>
<%//} %>
		<p class="btn">
			<a href="memo_list.jsp">목록</a>
		</p>
		 -->
</body>
</html>