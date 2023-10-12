<%@page import="java.io.File"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 파일 업로드 처리하고, 파일 정보 화면에 표시 --%>
<%
	//한글처리
	request.setCharacterEncoding("UTF-8");

	//(주의) form 태그에 enctype="multipart/form-data" 설정하면
	String name = request.getParameter("name");
	System.out.println("name : " + name);
	
	//파일을 저장할 경로 지정
	String path = this.getServletContext().getRealPath("/upload");
	System.out.println("> path : " + path);
	
	MultipartRequest mr = new MultipartRequest(
			request, // 요청 객체
			path, // 실제 파일을 저장할 경로
			10 * 1024 * 1024, // 업로드 파일의 최대크기(byte 단위)
			"UTF-8", // 인코딩 형식
			new DefaultFileRenamePolicy()
			);
	
	// DefaultFileRenamePolicy : 동일한 파일명이 존재하면 숫자를 덧붙여서 이름 자동 변경 저장
%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>파일 업로드 결과 보기</title>
</head>
<body>
	<h1>파일 업로드 결과 보기</h1>
	<h2>올린 사람(name) : <%=mr.getParameter("name") %></h2>
	<h2>제목(title) : <%=mr.getParameter("title") %></h2>
	
	<h2>파일(filename) : <%=mr.getParameter("filename") %></h2><!-- null -->
	<hr>
	<h2>원본 파일명 : <%=mr.getOriginalFileName("filename") %></h2>
	<h2>저장 파일명 : <%=mr.getFilesystemName("filename") %></h2>
	<h2>파일타입 : <%=mr.getContentType("filename") %></h2>
<%
	File file = mr.getFile("filename");
	out.println("<h2>" + file.getName() + "</h2>");
	out.println("<h2>" + file.length() + "</h2>");
%>
	<hr>
	<h2>파일 다운로드</h2>
	<a href="download.jsp?path=upload&filename=<%=mr.getFilesystemName("filename") %>">다운로드할 파일(<%=mr.getOriginalFileName("filename") %>)</a>
	
	
	
	
</body>
</html>