<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>파일 업로드</title>
</head>
<body>
<%-- 파일업로드 : cos.jar (http://www.servlets.com/cos)
	0. 사용할 라이브러리 파일 cos.jar 빌드패스 등록
		(WebContent > WEB-INF > lib > cos.jar)
	1. form 태그 : method="post" 설정(POST 방식만 가능)
	2. form 태그 : enctype="multipart/form-data" 설정
	3. form input 태그 : <input type="file" ...>
--%>
	<form action="ex01_result_cos.jsp" method="post" enctype="multipart/form-data">
		<p>올린 사람 : <input type="text" name="name"></p>
		<p>제목 : <input type="text" name="title"></p>
		
		<p>파일 : <input type="file" name="filename"></p>
		
		<input type="submit" value="파일업로드">
	</form>

</body>
</html>