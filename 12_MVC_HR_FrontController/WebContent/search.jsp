<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>동적검색</title>
</head>
<body>
	<h1>동적검색[ search.jsp ]</h1>
	<!-- method="post" 파라미터값 모두 넘기기 위함 -->
	<!-- get으로 할 경우 type=search이 날라감 -->
	<form action="controller?type=search" method="post">
		<select name="idx">
			<option value="0">사번</option>
			<option value="1">이름</option>
			<option value="2">직종</option>
			<option value="3">부서</option>
		</select>
		<input type="text" name="keyword">
		<input type="submit" value="동적검색">
		<!-- get으로 할 경우 <input type="hidden" name="type" value="search"> 사용 -->
	</form>
</body>
</html>