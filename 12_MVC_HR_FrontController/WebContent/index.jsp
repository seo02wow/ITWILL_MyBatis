<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>작업선택</title>
<script>
	function all_search(){
		//location.href="list.jsp";
		//location.href="list"; 
		location.href="controller?type=list"; 
	}
	function dept_search(){
		//location.href="dept"; 
		location.href="controller?type=dept"; 
	}
	function fullname_search(){
		location.href="controller?type=fullname"; 
	}
	function search_go(){
		location.href="controller?type=search"; 
	}
	
	
</script>
</head>
<body>
	<h1>작업선택[ index.jsp ]</h1>
	<button onclick="all_search()">전체보기(list)</button>
	<button onclick="dept_search()">부서코드검색(dept)</button>
	<button onclick="fullname_search()">이름검색(fullname)</button>
	<button onclick="search_go()">동적검색(search)</button>
</body>
</html>