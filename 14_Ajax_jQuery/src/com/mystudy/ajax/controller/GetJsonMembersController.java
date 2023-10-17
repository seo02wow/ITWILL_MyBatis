package com.mystudy.ajax.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mystudy.ajax.dao.MemberDAO;
import com.mystudy.ajax.vo.MemberVO;

@WebServlet("/getJsonMembers")
public class GetJsonMembersController extends HttpServlet {
	
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("::: GetJsonMembersController doGet() 실행 ~");
		// 한글깨짐 방지를 위한 문자타입 처리
		response.setContentType("text/html; charset=UTF-8");
		
		//DB 데이터 가져오기
		List<MemberVO> list = MemberDAO.getList();
		System.out.println("list : " + list);
		
		//JSON 형식 문자열 만들고 응답처리 
		// {"list" : [{}, {}, ...,{}]}
		String result = makeJson(list);
		
		//클라이언트에게 응답처리
		PrintWriter out = response.getWriter();
		out.print(result);
	}

	private String makeJson(List<MemberVO> list) {
		/* JSON 형식 문자열  
		 {"list" : [{}, {}, ...,{}]}
		 {"list" : [
		 	{
		 		"idx" : 1,
		 		"name" : "홍길동",
		 		"age" : 27,
		 		"addr" : "서울",
		 		"redate" : "2023-10-17"
		 	},
		 	{}, {},...{}
		 ]}
		 **************/
		//JSON 형식 문자열 만들기
		StringBuilder result = new StringBuilder();
		result.append("{\"list\" : [");
		
		for(MemberVO vo : list) {
			result.append("{");
			result.append("\"idx\" : " + vo.getIdx() + ",");
			result.append("\"name\" : \"" +vo.getName() + "\","); // 문자열
			result.append("\"age\" : " + vo.getAge() + ",");
			result.append("\"addr\" : \"" +vo.getAddr() + "\",");
			result.append("\"regdate\" : \"" +vo.getRegdate() + "\"");
			result.append("},");
		}
		// 마지막 JSON 문장에 있는 , 제거
		//result.delete(result.length()-1,result.length()); 
		result.deleteCharAt(result.length()-1);
		result.append("]}");
		
		System.out.println("result : " + result.toString());
		
		return result.toString();
	}
}
