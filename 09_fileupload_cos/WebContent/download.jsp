<%@page import="java.io.File"%>
<%@page import="java.io.BufferedOutputStream"%>
<%@page import="java.io.BufferedInputStream"%>
<%@page import="java.io.FileInputStream"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 전달받은 데이터를 사용해서 파일 다운로드 처리 --%>
<%
	//한글처리
	request.setCharacterEncoding("UTF-8");

	//전달받은 파라미터 값 확인(추출)
	String path = request.getParameter("path"); // 저장된 폴더명 (디렉토리)
	String filename = request.getParameter("filename"); // 물리적으로 저장된 파일명
	System.out.println("> path : " + path);
	System.out.println("> filename : " + filename);
	
	//실제 파일이 저장된 경로 확인 
	String realPath = this.getServletContext().getRealPath(path);
	System.out.println("> realPath : " + realPath);
	
	//다운로드 받을 수 있도록 클라이언트 응답 문서 타입 변경 
	response.setContentType("application/x-msdownload");
	
	//클라이언트 헤더 정보를 첨부파일이 있는 것으로 변경 
	response.setHeader("Content-Disposition", "attachment;filename=" + filename);
	
	//----------- 실제 파일 읽고, 쓰기 작업 --------------
	FileInputStream fis = null;
	BufferedInputStream bis = null; // 속도 개선 
	
	BufferedOutputStream bos = null;
	
	File file = new File(realPath + "/" + filename); //물리적으로 읽을 파일
	
	if(file.isFile()){
		try{
			//파일 읽기 객체 생성
			fis = new FileInputStream(file);
			bis = new BufferedInputStream(fis);
			
			//파일 쓰기 객체 생성 
			bos = new BufferedOutputStream(response.getOutputStream());
			
			//파일 읽고, 쓰기 반복 
			int readValue = bis.read();
			while (readValue != -1){ //파일의 끝 : -1 
				bos.write(readValue);
				readValue = bis.read();
			}
			// JSP 출력스트림과 서블릿 출력스트림이 겹쳐서 
			// 발생하는 오류 발생 시 해결법 
			out.clear();
			out = pageContext.pushBody();
		} catch (Exception e){
			e.printStackTrace();
		} finally {
			bos.close();
			bis.close();
		}
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>