package com.hy.controller.tablet;

import java.io.Reader;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

public class MyBatisUtil {
	
	private static SqlSessionFactory factory;

  static {
      // 앱 시작할 때 한 번만 실행됨!
      try {
          String resource = "mybatis-config.xml";
          Reader reader = Resources.getResourceAsReader(resource);
          factory = new SqlSessionFactoryBuilder().build(reader);
      } catch (Exception e) {
          e.printStackTrace();
      }
  }

  // SqlSession(=DB연결)을 쉽게 만들어주는 메서드!

  public static SqlSession getSqlSession(boolean autoCommit) {
      return factory.openSession(autoCommit);
  }
  
  public static SqlSession getSession() {
      return factory.openSession();  // autoCommit=false
  }

  public static SqlSession getSession(boolean autoCommit) {
      return factory.openSession(autoCommit);
  }

}
