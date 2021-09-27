<%@page import="java.io.PrintWriter"%>
<%@page import="mybatis.dao.MemoDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	// 삭제 버튼을 눌렀을때 오는 페이지이다.
	
	// 요청시 한글처리
	request.setCharacterEncoding("utf-8");
	
	// 파라미터 값 받기!
	String idx = request.getParameter("idx");
	
	// 응답을 위한 스트림 준비!
	//PrintWriter outs = response.getWriter();
	
	// 받은 인자값을 DAD에 exit메서드를 호출할때 넣어준다.
	int cnt = MemoDAO.exit(idx); // 이 메서드를 호출할때는 삭제된 갯수를 반환을 해준다.
	
	// 응답처리를 하고 가면 삭제의 실패 했으면 0 성공했으면 1이 간다.
	//outs.println(cnt);
	
	// 그리고 사용한 스트림은 꼭 닫아주자!
	//outs.close();
%>
<%-- jsp에서 값을 보냈때 out.print를 해도 되지만 
	html에서 값을 받을때는 <%=%> 을 사용해도 전달되기 때문에
	<%=cnt%>을 하면 원하는 값을 보내줄수가 있다!!!
 --%>
<%=cnt%>