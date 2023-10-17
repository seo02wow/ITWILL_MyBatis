<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>부서 직원 목록</title>
<!-- 최종적으로 응답될 때 보여지는 View -->
</head>
<body>
	<h1>부서 직원 목록[ deptList.jsp ]</h1>
	<h3>사번, 성명, 직종, 부서코드</h3>
	<ul>
		<c:forEach var="vo" items="${list }">
			<li>
				${vo.employeeId }, ${vo.firstName }, ${vo.jobId }, ${vo.departmentId }
			</li>
		</c:forEach>
	</ul>
</body>
</html>