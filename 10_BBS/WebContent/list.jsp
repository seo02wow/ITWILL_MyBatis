<%@page import="com.mystudy.bbs.vo.BbsVO"%>
<%@page import="java.util.List"%>
<%@page import="com.mystudy.bbs.dao.BbsDAO"%>
<%@page import="com.mystudy.bbs.common.Paging"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 현재 페이지에 표시할 데이터를 화면에 표시
	1. 페이징 처리를 위한 객체(paging) 생성해서 필요한 데이터 참조
	2. 페이징 객체에 설정할 데이터 생성 저장
	3. (DB) 현재 페이지에 표시할 게시글 데이터 조회
	4. 데이터 화면 표시(화면 컨트롤 - 스타일 지정)
 --%>
<%
	//0. 페이징 처리를 위한 객체(paging) 생성
	Paging p = new Paging();

	//1. 전체 게시물 수량 구하기
	p.setTotalRecord(BbsDAO.getTotalCount());
	p.setTotalPage();
	System.out.println("> 전체 게시글 수 : " + p.getTotalRecord());
	System.out.println("> 전체 페이지 수 : " + p.getTotalPage());
	
	//2. 현재 페이지 구하기
	String cPage = request.getParameter("cPage");
	if(cPage != null){
		p.setNowPage(Integer.parseInt(cPage));
	}
	System.out.println("> cPage : " + cPage);
	System.out.println("> paging nowPage : " + p.getNowPage());
	
	//3. 현재 페이지에 표시할 게시글 시작번호(begin), 끝번호(end) 구하기
	// 1 페이지 : 게시물 1(끝 번호 - 표시할 게시글 수 + 1) ~ 3(표시할 게시글 수 * 페이지)
	
	p.setEnd(p.getNowPage() * p.getNumPerPage());
	p.setBegin(p.getEnd() - p.getNumPerPage() + 1);
	
	//3-1. (선택적) 끝 번호가 데이터 건수보다 많아지면 데이터 건수와 동일하게 설정
	if(p.getEnd() > p.getTotalRecord()){
		// 데이터 범위 벗어나지 않도록 설정 
		p.setEnd(p.getTotalRecord());
	}
	System.out.println(" >> 시작번호(begin)" + p.getBegin());
	System.out.println(" >> 끝번호(end)" + p.getEnd());
	
	//---- 블록(block) 계산하기 ----
	//4. 블록 시작페이지, 끝페이지 구하기(현재페이지 번호 사용)
	//4-1. 시작 페이지 구하기
	int beginPage = (p.getNowPage() - 1) / p.getPagePerBlock() * p.getPagePerBlock() + 1;
	p.setBeginPage(beginPage);
	p.setEndPage(beginPage + p.getPagePerBlock() - 1);
	
	//4-2. 끝 페이지(endPage)가 전체 페이지 수(totalPage)보다 크면
	// 끝 페이지를 전체 페이지 수로 변경처리(설정)
	if(p.getEndPage() > p.getTotalPage()){
		p.setEndPage(p.getTotalPage());
	}
	
	
	System.out.println(" >> 시작페이지(beginPage)" + p.getBeginPage());
	System.out.println(" >> 끝페이지(endPage)" + p.getEndPage());
	
	System.out.println("p : " + p);
%>
<%
	//=====================
	//현재 페이지 기준으로 DB 데이터(게시글) 가져오기
	//시작번호(begin), 끝번호(end) 사용해서 
	List<BbsVO> list = BbsDAO.getList(p.getBegin(), p.getEnd());
	System.out.println(">> 현재 페이지 글 목록(list) : " + list);
	
	//------------------------
	//JSTL,EL 사용을 위해 scope에 데이터 등록(page 영역)
	pageContext.setAttribute("list", list);
	pageContext.setAttribute("pvo", p);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 목록</title>
<style>
	#bbs table {
		width: 580px;
		margin-left: 10px;
		border-collapse: collapse;
		font-size: 14px;
	}
	#bbs table caption{
		font-size: 20px;
		font-weight: bold;
		margin-bottom: 10px;
	}
	#bbs th, #bbs td {
		border: 1px solid black;
		padding: 4px 10px;
		text-align: center;
	}
	#bbs .align-left { text-align: left;}
	
	.title { background-color: lightgray; }
	.no { width: 10% }
	.writer { width: 15% }
	.regdate { width: 20% }
	.hit { width: 15% }
	
	/* 페이지 표시 영역 스타일(시작) */
	.paging { list-style: none; }
	.paging li {
		float: left;
		margin-right: 8px;
	}
	.paging li a {
		text-decoration: none;
		display: block;
		padding: 3px 7px;
		border: 1px solid pink;
		font-weight: bold;
		color: black;
	}
	
	.paging .disable {
		border: 1px solid silver;
		padding: 3px 7px;
		color: silver;
	}
	
	.paging .now {
		border: 1px solid lightpink;
		padding: 3px 7px;
		background-color:  lightpink;
	}
	/* 페이지 표시 영역 스타일(끝) */
	
</style>

</head>
<body>
<div id="bbs">
	<table>
		<caption>게시글 목록</caption>
		<thead>
			<tr class="title">
				<th class="no">번호</th>
				<th class="subject">제목</th>
				<th class="writer">글쓴이</th>
				<th class="regdate">날짜</th>
				<th class="hit">조회수</th>
			</tr>
		</thead>
		<tbody>
		<c:choose>
		<c:when test="${empty list }">
			<tr>
				<td colspan="5">
					<h2>현재 등록된 게시글이 없습니다.</h2>
				</td>
			</tr>
		</c:when>
		<c:otherwise>
			<c:forEach var="vo" items="${list }">
				<tr>
					<td>${vo.bbsIdx }</td>
					<td class="align-left">
						<a href="view.jsp?bbsIdx=${vo.bbsIdx }&cPage=${pvo.nowPage}">${vo.subject }<a>
					</td>
					<td>${vo.writer }</td>
					<td>${vo.writeDate.substring(0, 10)}</td>
					<td>${vo.hit }</td>
				</tr>
			</c:forEach>
		</c:otherwise>
		</c:choose>
		</tbody>
		<tfoot>
			<tr>
				<td colspan="4">
					<ol class="paging">
						<%-- [이전으로]에 대한 사용여부 처리 --%>
						<c:if test="${pvo.beginPage == 1 }">
							<li class="disable">이전으로</li>
						</c:if>
						
						<c:if test="${pvo.beginPage != 1 }">
						<li>
							<a href="list.jsp?cPage=${pvo.beginPage - 1 }">이전으로</a>
						</li>
						</c:if>
						<%-- 블록 내에 표시할 페이지 태그 작성(시작페이지~끝페이지) --%>
						<c:forEach var="pageNo" begin="${pvo.beginPage }" end="${pvo.endPage }">
						<c:if test="${pageNo == pvo.nowPage }">
							<li class="now">${pageNo }</li>
						</c:if>
						<c:if test="${pageNo != pvo.nowPage }">
							<li>
								<a href="list.jsp?cPage=${pageNo }">${pageNo }</a>
							</li>
						</c:if>
						</c:forEach>
						
						<%-- [다음으로]에 대한 사용여부 처리 --%>
						<c:if test="${pvo.endPage >= pvo.totalPage }">
							<li class="disable">다음으로</li>
						</c:if>
						
						<c:if test="${pvo.endPage < pvo.totalPage }">
							<li>
								<a href="list.jsp?cPage=${pvo.endPage + 1}">다음으로</a>
							</li>
						</c:if>
					</ol>
				</td>
				<td>
					<input type="button" value="글쓰기"
						onclick="javascript:location.href='write.jsp'">
				</td>
			</tr>
		</tfoot>
	</table>
</div>
</body>
</html>