package com.mystudy.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mystudy.model.command.Command;
import com.mystudy.model.command.DeptCommand;
import com.mystudy.model.command.DeptListCommand;
import com.mystudy.model.command.FullnameCommand;
import com.mystudy.model.command.ListCommand;
import com.mystudy.model.command.SearchCommand;

@WebServlet("/controller")
public class FrontControllerCommand extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println(">> FrontControllerCommand doGet() 시작");
		String type = request.getParameter("type");
		System.out.println("> type : " + type);
		
		Command command = null; 
		if("list".equals(type)) {
			command = new ListCommand();
		}
		if("dept".equals(type)) {
			command = new DeptCommand();
		}
		if("deptList".equals(type)) {
			command = new DeptListCommand();
		}
		if("fullname".equals(type)) {
			command = new FullnameCommand();
		}
		if("search".equals(type)) {
			command = new SearchCommand();
		}
		
		
		//중복되는 동작 밖으로 빼냄
		// path : exec 메소드가 jsp 경로 리턴
		String path = command.exec(request, response);
		//포워드 : 위임처리
		request.getRequestDispatcher(path).forward(request, response);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println(">> FrontControllerCommand doPost() 시작");
		req.setCharacterEncoding("UTF-8");
		doGet(req, resp);
	}
}
