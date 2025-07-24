package com.hy.service.use;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.hy.common.sql.SqlSessionTemplate;
import com.hy.dao.use.UseDao;
import com.hy.dto.Member;
import com.hy.dto.use.Use;
import com.hy.dto.use.UseLog;

public class UseService {

	private UseDao dao = new UseDao();
	
	public int updateUseCheckIn(int memberNo, int check) {
		Use param = new Use();
		param.setMemberNo(memberNo);
		param.setStatus(check);
		return dao.updateUseCheckIn(param);
	}

	public Use getUseStatusByNo(int memberNo) {
		return dao.getUseStatusByNo(memberNo);
	}

	public int insertUseLog(int memberNo, int checkLog) {
		UseLog param = new UseLog();
		param.setMemberNo(memberNo);
		param.setStatus(checkLog);
		return dao.insertUseLog(param);
	}

	public List<UseLog> getLogByNo(int memberNo) {
		return dao.getLogByNo(memberNo);
	}

	public int insertUse(int param) {
		return dao.insertUse(param);
	}

	public List<Use> getUseStatus() {
		List<Use> list = dao.getUseStatus();
		for (Use u : list) {
			if (u.getStatus() == 1) u.setStatusDisplay("입실");
			else if (u.getStatus() == 2) u.setStatusDisplay("외출");
		}
		return list;
	}

	public int abortMemberWithPenalty(String[] memberNoArr, String[] memberNoPenArr) {
		
		int result = 0;
		SqlSession session = null;
		
		try {
			for (String s : memberNoArr) {					
				session = SqlSessionTemplate.getSqlSession(false);
				int memberNo = Integer.parseInt(s);
				result = dao.abortMember(session, memberNo);
				
				if (result > 0) {
					UseLog param = new UseLog();
					param.setMemberNo(memberNo);
					param.setStatus(0);
					result = dao.insertUseLogAbort(session, param);
				}
				
				if (result > 0) {
					for (String p : memberNoPenArr) {
						int memberNoPen = Integer.parseInt(p);
						if (memberNoPen == memberNo) {
							System.out.println(memberNoPen);
							result = dao.insertMemberPen(session, memberNoPen);
						}
					}
				}
				
				if (result > 0) {
					session.commit();
				} else {
					session.rollback();
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			session.rollback();
		} finally {
			session.close();
		}

		return result;
		
	}

}
