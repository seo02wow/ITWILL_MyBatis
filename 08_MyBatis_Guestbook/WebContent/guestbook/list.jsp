<%@page import="com.mystudy.mybatis.GuestbookVO"%>
<%@page import="java.util.List"%>
<%@page import="org.apache.ibatis.session.SqlSession"%>
<%@page import="com.mystudy.mybatis.DBService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- DB에서 전체 데이터 조회 후 화면 출력  --%>
<%
	//DB에서 전체 데이터 조회 후 화면 출력
	// openSession(), openSession(false) : Auto Commit 해제 상태(트랜잭션 처리 필요)
	// openSession(true) : 자동 커밋 상태로 세션 객체 생성(SQL 실행 후 자동 커밋)
	//1. SqlSession 객체 생성 
	SqlSession ss =  DBService.getFactory().openSession();
	
	//2. 매퍼(mapper)의 SQL 실행해서 데이터 가져오기
	// SqlSession selectList(매퍼정보) : select 결과를 List 형태로 받기
	// SqlSession selectOne(매퍼정보) : select 결과가 하나인 경우
	List<GuestbookVO> list = ss.selectList("guestbook.all"); //id 명 or namespace.id명
	ss.close();

	System.out.println("list : " + list);
	//3. SQL문 실행 후 받은 데이터 화면 출력 
	pageContext.setAttribute("attr_list", list);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>전체목록</title>
<style>
	#container {
		width: 512px; margin: auto;
		/* border: 1px solid blue;  */
	}
	#container h2 { text-align: center;}
	#container p { text-align: center;}
	#container table {
		width: 100%;
		border-collapse: collapse;
	}
	#container th { background-color: #9cf; }
	#container th, #container td {
		border: 1px solid black; height: 1.5em;
	}
	.center { text-align: center; }
</style>
</head>
<body>

<div id="container">
	<h2>방명록</h2>
	<hr>
	<p><a href="write.jsp">[방명록 쓰기]</a></p>
	<table>
		<colgroup>
			<col width="10%">
			<col width="50%">
			<col width="20%">
		</colgroup>
		<thead>
			<tr>
				<th>번호</th>
				<th>제목</th>
				<th>작성자</th>
				<th>작성일</th>
			</tr>
		</thead>
		<tbody>
			<!-- <tr>
				<td class="center">1-샘플</td>
				<td>제목1</td>
				<td class="center">홍일동</td>
				<td class="center">2023-10-10</td>
			</tr> -->
		<%-- SQL 실행 후 결과 List 사용 tr 태그 만들기(EL,JSTL 사용) --%>	
		<c:forEach var="vo" items="${attr_list }"> 
			<tr>
				<td class="center">${vo.idx }</td>
				<td>
					<!-- idx=${vo.idx}" : 파라미터 값 전달 -->
					<a href="onelist.jsp?idx=${vo.idx}">${vo.subject }</a>
				</td>
				<td class="center">${vo.name }</td>
				<td class="center">${vo.regdate }</td>
			</tr>
		</c:forEach>
		<!-- 데이터가 없을 때 -->
		<c:if test="${empty attr_list }">
			<tr> 
				<td colspan="4">검색된 데이터가 없습니다</td>
			</tr>
		</c:if>
	
			
		
		</tbody>
	</table>
</div>
	
</body>
</html>