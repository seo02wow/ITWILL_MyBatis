package com.mystudy.bbs.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.mystudy.bbs.mybatis.DBService;
import com.mystudy.bbs.vo.BbsVO;
import com.mystudy.bbs.vo.CommentVO;

public class BbsDAO {
	
	//게시글(BBS) 전체 건수 조회
	public static int getTotalCount() {
		int totalCount = 0;
		
		SqlSession ss = DBService.getFactory().openSession();
		try {
			totalCount = ss.selectOne("BBS.totalCount");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ss.close();
		}
		
		return totalCount;
	}
	
	//페이지에 해당하는 글목록(게시글) 가져오기(조회)
	public static List<BbsVO> getList (int begin,int end){
		Map<String, Integer> map = new HashMap<>();
		map.put("begin", begin);
		map.put("end", end);
		
		SqlSession ss = DBService.getFactory().openSession();
		List<BbsVO> list = ss.selectList("BBS.list", map);
		ss.close();
		
		return list;
	}
	
	//게시글 조회
	public static BbsVO selectOne(int bbsIdx) {
		SqlSession ss = DBService.getFactory().openSession();
		BbsVO vo = ss.selectOne("BBS.one", bbsIdx);
		ss.close();
		return vo;
	}
	
	//=========== 댓글 ========================
	//게시글에 딸린 댓글 목록 조회
	public static List<CommentVO> getCommList (int bbsIdx){
		SqlSession ss = DBService.getFactory().openSession();
		List<CommentVO> list = ss.selectList("BBS.commList", bbsIdx);
		ss.close();
		
		return list;
	}
	
}
