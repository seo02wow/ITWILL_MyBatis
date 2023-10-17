<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이름으로검색</title>
</head>
<body>
	<h1>이름으로 검색 [ fullname.jsp ]</h1>
	<form action="controller" method="post">
		성명 : <input type="text" name="name">
		<input type="submit" value="이름으로 검색">
		<input type="hidden" name="type" value="fullname">
	</form>
</body>
</html>