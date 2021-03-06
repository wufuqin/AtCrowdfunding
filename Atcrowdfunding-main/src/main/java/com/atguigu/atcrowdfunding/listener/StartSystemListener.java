package com.atguigu.atcrowdfunding.listener;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

/**
 * 服务器启动时监听
 */
public class StartSystemListener implements ServletContextListener {

	//在服务器启动时,创建application对象时需要执行的方法.
	@Override
	public void contextInitialized(ServletContextEvent sce) {
		//1.将项目上下文路径(request.getContextPath())放置到application域中.
		ServletContext application = sce.getServletContext();
		String contextPath = application.getContextPath();
		application.setAttribute("APP_PATH", contextPath);
		//System.out.println("APP_PATH"+contextPath);
		//System.out.println("路径："+sce.getServletContext().getContextPath());

		//2.
	}

	@Override
	public void contextDestroyed(ServletContextEvent sce) {
		
	}

}
