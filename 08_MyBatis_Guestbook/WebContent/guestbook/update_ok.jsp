<%@page import="com.mystudy.mybatis.DBService"%>
<%@page import="org.apache.ibatis.session.SqlSession"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%--(실습) 전달받은 데이터 사용 DB 데이터 수정(UPDATE) 처리후 화면전환
	수정성공 : 상세화면으로 이동(또는 전체목록페이지로 이동)
	예외발생 : 예외메시지 표시 후 이전화면(수정페이지) 이동
--%>
<%
	//0. 한글처리
	request.setCharacterEncoding("UTF-8");
	
	//1. 파라미터 값 확인(추출) - VO에 저장
%>
	<jsp:useBean id="vo" class="com.mystudy.mybatis.GuestbookVO" />
	<jsp:setProperty property="*" name="vo"/>
<%
	System.out.println("> update_ok.jsp vo : " + vo);

	//2. DB 데이터 수정처리(SqlSession 객체 사용 DB UPDATE)
	SqlSession ss = DBService.getFactory().openSession(true);
	
	try {
		ss.update("guestbook.update", vo);
		//3. 화면전환 - 정상처리시
		//response.sendRedirect("list.jsp");
		response.sendRedirect("onelist.jsp?idx=" + vo.getIdx());
	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		ss.close();
	}
	
	//3. 화면전환 예외발생시
%>
	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>예외발생</title>
<script>
	alert("[예외발생] 수정되지 않습니다");
	//history.back(); //이전페이지(수정화면)
	history.go(-2); //상세화면으로 이동
</script>
</head>
<body>

</body>
</html>