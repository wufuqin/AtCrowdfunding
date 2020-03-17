package com.atguigu.atcrowdfunding.interceptor;

import java.util.HashSet;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.atguigu.atcrowdfunding.bean.Member;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.atguigu.atcrowdfunding.bean.User;
import com.atguigu.atcrowdfunding.util.Const;

/**
 * 登录拦截器
 */
public class LoginInterceptor extends HandlerInterceptorAdapter {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		
		//1.定义哪些路径是不需要拦截
		Set<String> uri = new HashSet<String>();
		uri.add("/index.htm");  //主页面
		uri.add("/login.htm");  //登录页面
		uri.add("/doLogin.do"); //登录处理
		uri.add("/logout.do");  //注销登录
		uri.add("/reg.htm");    //注册页面
		uri.add("/doRge.do");    //处理注册

		//获取请求路径.
		String servletPath = request.getServletPath();
		
		if(uri.contains(servletPath)){
			return true ;
		}

		//2.判断用户是否登录,如果登录就放行
		HttpSession session = request.getSession();
		User user = (User)session.getAttribute(Const.LOGIN_USER);
		Member member = (Member)session.getAttribute(Const.LOGIN_MEMBER);

		if(user != null || member != null){
			return true ;
		}else{
		    //重定向到系统首页面
			response.sendRedirect(request.getContextPath()+"/index.htm");
			return false;
		}
		
	}
	
}
