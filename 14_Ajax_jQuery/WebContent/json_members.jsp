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
		
		$.ajax("getJsonMembers",{ // 요청을 보낼 서버 주소 - GetXmlMembersController 클래스
			// url : "getJsonMembers", 위 파라미터 없애고 url로 넣어도 됨 
			type : "get", 
			dataType : "json", // 서버에서 응답 받을 데이터 타입
			success : function(respData){ // respData : 서버에서 응답 받은 데이터를 받을 매개변수 
				// 요청 성공할 경우 실행되는 콜백 함수
				alert(">> Ajax 처리 성공 - 응답받은 데이터 : " + respData);
				console.log(respData); 
				console.log(respData.list);// 배열 데이터 
				
				//전달받은 JSON 데이터 사용 tr 태그 만들고 화면출력 
				let htmlTag = "";
				let alist = respData.list; // JSON 객체의 속성명 "list"의 값 추출(배열 데이터)
				// $.each 배열 데이터(alist) 반복
				$.each(alist, function(index, member){ // index, member : 현재 처리 중인 인덱스 번호와 요소
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
	<!-- getJsonMembersName 함수로 연결 및 "홍길동" 인자로 전달 -->
	<a href="javascript:getJsonMembersName('홍길동')">JSON 데이터 조회(이름으로 검색)</a>
<script>
	function getJsonMembersName(name){ // name : 홍길동
		alert(">> getJsonMembersName 실행~ 이름 : " + name);
		// 한글로 인코딩 처리
		alert(">> encodeURIComponent(name) : " + encodeURIComponent(name));
		
		$.ajax("getJsonMembersName", {
			type : "get",
			data : "name=" + encodeURIComponent(name), // 서버로 전달하는 데이터 '홍길동'
			dataType : "json", //응답 받는 데이터 타입
			success : function(data){ // data : 서버에서 받은 데이터 
				// 요청 성공할 경우 실행되는 콜백 함수
				alert(">> Ajax 처리 성공 - 응답받은 데이터 : " + data);
				console.log(data); 
				console.log(data.list);// 배열 데이터에 접근 가능 
				
				//전달받은 JSON 데이터 사용 tr 태그 만들고 화면출력 
				let htmlTag = "";
				let alist = data.list; // JSON 객체의 속성명 "list"의 값 추출(배열 데이터)
				// $.each 배열 데이터(alist) 반복
				$.each(alist, function(index, member){ // index, member : 현재 처리 중인 인덱스 번호와 요소
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
			error : function(){
				alert("실패 ");
			}
		});
	}
</script>	
	
</body>
</html>