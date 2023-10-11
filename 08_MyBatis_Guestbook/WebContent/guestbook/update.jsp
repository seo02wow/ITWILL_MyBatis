<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 전달받은 VO 데이터를 화면에 표시하고 수정데이터 작성 --%>
<%
	//0. 전달받은 VO 데이터 확인(session에 저장된 데이터)
	System.out.println("update.jsp session guestbookVO : "
			+ session.getAttribute("guestbookVO"));
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>방명록수정</title>
<link rel="stylesheet" type="text/css" href="../css/guestbook.css">
<script>
	function save_go(frm) {
		//alert("save_go(frm) 실행~~ frm : " + frm);
		//비밀번호 확인 후 일치하면 수정 요청 처리
		let pwd1 = frm.pwd.value; //지금 입력한 암호
		let pwd2 = "${guestbookVO.pwd}"; //DB에 저장된 암호(암호 노출됨 - 하지말것)
		alert("pwd1: " + pwd1 + ", pwd2: " + pwd2);
		if (pwd1 !== pwd2) {
			alert("암호불일치. 암호를 확인하세요");
			frm.pwd.value = "";
			frm.pwd.focus();
			return false;
		}
		
		frm.action = "update_ok.jsp"
		frm.submit();
	}
</script>
</head>
<body>

<div id="container">
	<h2>방명록 : 수정화면</h2>
	<hr>
	<p><a href="list.jsp">[목록으로 이동]</a></p>
	
	<form method="get">
	<table>
		<tbody>
			<tr>
				<th>작성자</th>
				<td><input type="text" name="name" value="${guestbookVO.name }"></td>
			</tr>
			<tr>
				<th>제목</th>
				<td><input type="text" name="subject" value="${guestbookVO.subject }"></td>
			</tr>
			<tr>
				<th>이메일</th>
				<td><input type="text" name="email" value="${guestbookVO.email }"></td>
			</tr>
			<tr>
				<th>비밀번호확인</th>
				<td><input type="password" name="pwd"></td>
			</tr>
			<tr>
				<td colspan="2">
					<textarea name="content" rows="5" cols="60">${guestbookVO.content }</textarea>
				</td>
			</tr>
		</tbody>
		<tfoot>
			<tr>
				<td colspan="2">
					<input type="button" value="수 정" onclick="save_go(this.form)">
					<input type="reset" value="취 소">
					<input type="hidden" name="idx" value="${guestbookVO.idx }">
				</td>
			</tr>
		</tfoot>
	</table>
	</form>
</div>

</body>
</html>