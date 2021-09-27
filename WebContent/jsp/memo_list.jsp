<%@page import="mybatis.dao.MemoDAO"%>
<%@page import="mybatis.vo.MemoVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
	#list_table{
		border-collapse: collapse;
		width: 500px;
	}
	#list_table th, #list_table td{
		border: 1px solid #27a;
		padding: 3px;
	}
	#list_table thead th{
		background: #5ad;
		color: #fff;
	}
	#list_table caption{
		font-size: 30px;
		font-weight: bold;
		padding-bottom: 20px;
	}
	
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
	
	#list_table thead tr:first-child td{
		border: none;
	}
	#write_win{
		width: 450px;
		position: absolute;
		top: 90px;
		left: 300px;
		border: 2px solid black;
		background-color: #fff;
		display: none;
		border-radius: 7px;
	}
	#write_win tbody>tr:last-child p{
		display: inline-block;
		margin-right: 10px;
	}
	.empty{
		text-align: center;
		height: 40px;
		line-height: 40px;
	}
</style>
</head>
<body>
	<div id="wrap">
		<table id="list_table">
			<caption>메모 리스트</caption>
			<colgroup>
				<col width="50px">
				<col width="*">
				<col width="80px">
				<col width="100px">
				<col width="60px">
			</colgroup>
			<thead>
				<tr>
					<td colspan="5" >
						<p class="btn">
							<a href="javascript:writeMemo()">
								글쓰기
							</a>
						</p>	
					</td>
				</tr>
				<tr>
					<th>번호</th>
					<th>내용</th>
					<th>글쓴이</th>
					<th>등록일</th>
					<th>삭제</th>
				</tr>
			</thead>
			<tbody>
			<%
				// DAO의 함수를 호출하여 목록을 얻어낸다.
				MemoVO[] ar = MemoDAO.getAll();
				if(ar != null){
					for(MemoVO vo : ar){
			%>
				<tr>
					<td><%=vo.getIdx() %></td>
					<td><%=vo.getContent() %></td>
					<td><%=vo.getWriter() %></td>
					<td>
						<% if(vo.getReg_date() != null){ %><!-- if문으로 비교해서 날짜가 들어온 경우에만 subString을 이용해 잘라준다. -->
							<%=vo.getReg_date().substring(0,10) %>
						<%} %>
					</td>
					<td>
						<button type="button" name="idx" onclick="exits(<%=vo.getIdx()%>)">삭제</button>
					</td>
				</tr>
			<%
					}// for의 끝
				}else{// ar이 null인 경우
			%>
			
				<tr>
					<td class="empty" colspan="5">등록된 정보가 없습니다.</td>
				</tr>
			
			<% 	
				
			}// if문의 끝
			%>
			
			</tbody>
		</table>
	</div>
	
	
	<div id="write_win">
		<form action="write_memo.jsp" method="post">
			<table>
				<tbody>
					<tr>
						<td><label for="writer">작성자:</label></td>
						<td>
							<input type="text" id="writer" name="writer"/>
						</td>
					</tr>
					<tr>
						<td><label for="content">내용:</label></td>
						<td>
							<textarea cols="40" rows="6" 
							id="content" name="content"></textarea>
						</td>
					</tr>
					<tr>
						<td colspan="2">
							<p class="btn">
							<!-- a태그에서는 함수는 호출이 가능하지만 a태그가 form태그의 하위가 아니기 때문에 this.form이 적용되지 않는다. -->
								<a href="javascript:exe(this.form)">
									저장
								</a>
							</p>
							<p class="btn">
								<a href="javascript:closedWin()">
									닫기
								</a>
							</p>
						</td>
					</tr>
				</tbody>
			</table>
			<input type="hidden" name="ip" id="ip" value="<%= request.getRemoteAddr()%>"/>
		</form>
	</div>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
	<script>
		function writeMemo(){
			//$("#write_win").css("display","block"); jQuery를 이용한 스타일 변경!!
			document.getElementById("write_win").style.display = "block"; // 자바 스크립트를 이용한 스타일 변경!!!
		}
		function closedWin(){
			//$("#write_win").css("display","none"); 
			document.getElementById("write_win").style.display = "none";
		}
		function exe(frm){
			// writer와 content가 입력되었을 때만 write_memo.jsp로 보낸다.
			var writer = $("#writer").val();
			var content = $("#content").val();
			
			// 유효성 검사부분...
			if(writer.trim().length <=0){
				alert("작성자를 입력해주세요.")
				$("#writer").focus();
				$("#writer").val("");
				return;
			}
			if(content.trim().length <=0){
				alert("작성자를 입력해주세요.")
				$("#content").focus();
				$("#content").val("");
				return;
			}
			// 비동기식 저장하는 부분이다.
			var ip = $("#ip").val(); // 비동기식 통신으로 사용할때는 보낼 데이터는 변수에 담아 줘야 하기때문에 추가로 ip값을 저장했다.
			var param = "writer="+encodeURIComponent(writer)+"&content="+encodeURIComponent(content)+"&ip="+encodeURIComponent(ip);
			$.ajax({
				url: "write_memo.jsp",
				data: param,
			}).done(function(data){
				if(data){
					alert("저장성공!!");
					location.href = "memo_list.jsp";
				}else
					alert("저장실패 다시 시도해주세요.");
			});
			//document.forms[0].submit();   // 이런식으로 폼을 보내 다른페이지에서 구분하고 이동할 수 있게 준비해준 동기식 통신 방법이다.
		}
		// 비동기식 삭제 방법
		function exits(s){ // 인자를 받아 삭제하고자 하는 인덱스 번호를 알아낸다.
			// 인자로 받은 인덱스 번호를 idx라는 이름으로 delete_memo.jsp로 보내주는 방법이다.
			var param = "idx="+encodeURIComponent(s);
		
			// 비동기식 통신을 위한 ajax이다.
			$.ajax({
				url: "delete_memo.jsp",
				data: param,
				type: "post",
			}).done(function(data){
				// data가 1이면 삭제 성공! 그렇지 않으면 실패!
				if(confirm("정말 삭제 하시겠습니까?")){ // confrim()함수는 예 아니오 라는 버튼과 함께 dialog로 띄워주는 함수이다.
					if(data > 0){ // 받은 데이터가 0보다 크면 삭제의 성공한거고 0이면 삭제실패이기 때문에 따로 구분을 해줬다.
						location.href = "memo_list.jsp";
						alert("삭제성공");
					}else{
						alert("삭제실패.");
					}
				}
			});
		}
		// 동기식 삭제방법이다.
		function del(idx){// 삭제 버튼을 클릭할때마다 실행하는 함수
			//alert(idx); // 아니면 console.log(idx);
			
			if(confirm("정말 삭제 하시겠습니까?")){
			
				// 받은 기본키인 idx값을 delete_memo.jsp를 호출하면서 파라미터로 전달하자
				location.href="del.jsp?idx="+idx; // delete_memo.jsp?idx=2
			}// if문의 끝!!!!!!!!!
		}
	</script>
</body>
</html>









    