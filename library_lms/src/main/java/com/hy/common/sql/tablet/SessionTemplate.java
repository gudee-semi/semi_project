package com.hy.common.sql.tablet;

import java.io.InputStream;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

public class SessionTemplate {
	
	public static SqlSession getSqlSession(boolean autoCommit) {
		
		SqlSession session = null;
		
		try {
			String path = "mybatis-config.xml";
			InputStream is = Resources.getResourceAsStream(path);

			SqlSessionFactoryBuilder builder = new SqlSessionFactoryBuilder();
			SqlSessionFactory factory = builder.build(is);

			session = factory.openSession(autoCommit);

		} catch (Exception e) {
			System.out.println("예외 발생");
			e.printStackTrace();
		}

		return session;
	}
	
}
