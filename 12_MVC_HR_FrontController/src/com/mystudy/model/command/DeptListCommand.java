package com.mystudy.model.command;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mystudy.model.dao.EmployeeDAO;
import com.mystudy.model.vo.EmployeeVO;

public class DeptListCommand implements Command{

	@Override
	public String exec(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//전달받은 부서코드로 DB데이터 조회 후 deptList.jsp 응답처리
		//1. 전달받은 파라미터값(부서코드: deptno) 추출(확인) 
		String deptno = request.getParameter("deptno"); // 오라클 자동형변환됨 (문자열->숫자)
		
		//2. DB에서 해당부서(deptno)에 있는 직원 조회(DAO사용)
		List<EmployeeVO> list = EmployeeDAO.getDeptList(deptno);
		
		//3. 조회된 데이터를 응답페이지(deptList.jsp)에서 사용하도록 scope에 저장
		//포워드 처리 -> 세션 X 
		request.setAttribute("list", list);
		return "deptList.jsp";
	}

}
