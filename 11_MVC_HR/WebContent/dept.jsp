<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>부서코드검색</title>
</head>
<body>
	<h1>부서코드검색[ dept.jsp ]</h1>
	<form action="deptList" method="get">
		부서코드 : <input type="text" name="deptno">
		<input type="submit" value="부서코드로 검색">
	</form>
</body>
</html>