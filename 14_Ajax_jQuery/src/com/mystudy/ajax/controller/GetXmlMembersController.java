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

@WebServlet("/getXmlMembers")
public class GetXmlMembersController extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println(">> GetXmlMembersController doGet() 실행~");
		
		//DB 데이터 가져오기
		List<MemberVO> list = MemberDAO.getList();
		System.out.println("list : " + list);
		
		//XML 형식 문자열로 만들기
		/*
		<?xml version="1.0" encoding="UTF-8"?>
		<members>
			<member>
				<idx>1</idx>
				<name>홍길동1</name>
				<age>27</age>
				<addr>서울</addr>
				<regdate>2023-10-17</regdate>
			</member>
			....
		</members>
		*************************/
		StringBuilder result = new StringBuilder();
		result.append("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
		result.append("<members>");
		
		for (MemberVO vo : list) {
			result.append("<member>");
			result.append("<idx>" + vo.getIdx() + "</idx>");
			result.append("<name>" + vo.getName() + "</name>");
			result.append("<age>" + vo.getAge() + "</age>");
			result.append("<addr>" + vo.getAddr() + "</addr>");
			result.append("<regdate>" + vo.getRegdate() + "</regdate>");
			result.append("</member>");
		}
		result.append("</members>");
		System.out.println("result : \n" + result.toString());
		
		//응답하기
		resp.setContentType("text/html;charset=UTF-8");
		PrintWriter out = resp.getWriter();
		out.print(result.toString());
		
	}
}
