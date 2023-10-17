<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Ajax JSON</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script>
	$(document).ready(function(){
		$("#getDataBtn").on("click",ajaxGetJsonMembers)
	});
	function ajaxGetJsonMembers(){
		alert(">> ajaxGetJsonMembers() 실행");
		
		$.ajax("getJsonMembers",{ // 요청을 보낼 URL
			type : "get",
			dataType : "json", //응답 받을 데이터 타입
			success : function(respData){ 
				// 요청 성공할 경우 실행되는 콜백 함수
				alert(">> Ajax 처리 성공 - 응답받은 데이터 : " + respData);
				console.log(respData); 
				console.log(respData.list);// 배열 데이터 
				
				//전달받은 JSON 데이터 사용 tr 태그 만들고 화면출력 
				let htmlTag = "";
				let alist = respData.list; // JSON 객체의 속성명 "list"의 값 추출
				$.each(alist, function(index, member){ // 현재 처리 중인 인덱스 번호와 객체
					//console.log("this.name" + this.name);
					htmlTag += "<tr>"
					htmlTag += "<td>" + this.idx + "</td>"
					htmlTag += "<td>" + this.name + "</td>"
					htmlTag += "<td>" + this["age"] + "</td>" // ["문자열"] 사용 가능
					htmlTag += "<td>" + this.addr + "</td>"
					htmlTag += "<td>" + this["regdate"] + "</td>"
					htmlTag += "</tr>"
				})
				$("#tbody").html(htmlTag);
			},
			error : function(jqXHR, textStatus, errorThrown){
				alert(">> Ajax 처리 실패 : \n"
						+ "jqXHR.readyState : " + jqXHR.readyState + "\n"
						+ "textStatus : " + textStatus + "\n"
						+ "errorThrown : " + errorThrown);
			}
		});
	}
</script>
</head>
<body>
	<h1>Ajax JSON 데이터 요청 처리</h1>
	<button id="getDataBtn">Ajax - JSON 데이터 가져오기</button>
	<hr>
	<table border>
		<thead>
			<tr>
				<th>번호</th>
				<th>이름</th>
				<th>나이</th>
				<th>주소</th>
				<th>날짜</th>
			</tr>
		</thead>
		<tbody id="tbody">
			<tr>
				<td>1</td>
				<td>홍길동</td>
				<td>27</td>
				<td>서울</td>
				<td>2023-10-17</td>
			</tr>
		</tbody>
	</table>
	<hr>
	<a href="javascript:getJsonMembersName('홍길동')">JSON 데이터 조회(이름으로 검색)</a>
<script>
	function getJsonMembersName(name){
		alert(">> getJsonMembersName 실행~ 이름 : " + name);
		alert(">> encodeURIComponent(name) : " + encodeURIComponent(name));
		
		$.ajax("getJsonMembersName", {
			type : "get",
			data : "name=" + encodeURIComponent(name), // 한글로 인코딩 처리, 서버로 전달하는 데이터
			dataType : "json", //응답 받는 데이터 타입
			success : function(data){
				alert("Ajax 처리 성공 - 응답 받는 데이터 : " + data);
			}
			error : function(){
				alert("실패 ");
			}
		});
	}
</script>	
	
</body>
</html>