package com.mystudy.ajax.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.mystudy.ajax.vo.MemberVO;
import com.mystudy.mybatis.DBService;

public class MemberDAO {
	
	public static List<MemberVO> getList(){
		List<MemberVO> list = null;
		SqlSession ss = null;
		try {
			ss = DBService.getFactory().openSession();
			list = ss.selectList("members.all");
		}catch (Exception e) {
			e.printStackTrace();
		} finally {
			ss.close();
		}
		
		return list;
	}
	
	public static List<MemberVO> getListNameLike(String name){
		List<MemberVO> list = null;
		
		try (SqlSession ss = DBService.getFactory().openSession()){
			// "members.searchName" : 매퍼의 "namespace.id" 
			list = ss.selectList("members.searchName",name);
		}catch (Exception e) {
			e.printStackTrace();
		} 
		
		return list;
	}
	
}
