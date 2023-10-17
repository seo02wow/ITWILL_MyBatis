package com.mystudy.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.mystudy.model.vo.EmployeeVO;
import com.mystudy.mybatis.DBService;


public class EmployeeDAO {
	
	//전체 직원 목록 조회
	public static List<EmployeeVO> getList(){
		SqlSession ss = DBService.getFactory().openSession();
		List<EmployeeVO> list = ss.selectList("hr.list");
		ss.close();
		return list;
	}
	
	//부서 직원 목록 조회
	public static List<EmployeeVO> getDeptList(String deptno){
		SqlSession ss = DBService.getFactory().openSession();
		List<EmployeeVO> list = ss.selectList("hr.deptList",deptno);
		ss.close();
		return list;
	}
	
	//이름으로 조회
	public static List<EmployeeVO> getFullnameList(String name){
		SqlSession ss = DBService.getFactory().openSession();
		List<EmployeeVO> list = ss.selectList("hr.fullnameList",name);
		ss.close();
		return list;
	}

	public static List<EmployeeVO> getSearch(String idx, String keyword) {
		Map<String, String> map = new HashMap<>();
		map.put("idx", idx);
		map.put("keyword", keyword);
		
		SqlSession ss = DBService.getFactory().openSession();
		List<EmployeeVO> list = ss.selectList("hr.search",map);
		ss.close();
		return list;
	}
	
}
