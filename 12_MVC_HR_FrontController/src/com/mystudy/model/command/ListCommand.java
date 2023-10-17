package com.mystudy.model.command;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mystudy.model.dao.EmployeeDAO;
import com.mystudy.model.vo.EmployeeVO;

public class ListCommand implements Command{

	@Override
	public String exec(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//1. DB 연결하고 데이터 가져오기
		List<EmployeeVO> list = EmployeeDAO.getList();
		
		//2. 응답페이지(list.jsp)에 전달
		request.setAttribute("list", list);
		
		//3. 페이지 전환 - 응답할 페이지(list.jsp)로 포워딩(위임,전가)
		//request.getRequestDispatcher("list.jsp").forward(request, response);
		// 최종 응답처리는 Contoroller에서 
		
		return "list.jsp";
	}
	
}
