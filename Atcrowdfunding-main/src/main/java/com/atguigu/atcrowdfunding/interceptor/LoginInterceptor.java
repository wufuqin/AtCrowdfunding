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
		uri.add("/forget.htm");    //忘记密码
		uri.add("/restPassword.do");    //发送重置密码邮件
		uri.add("/time.htm");    //发送邮件自动跳转
		uri.add("/regTime.htm"); //注册成功自动跳转
		uri.add("/toRestPassword.htm"); //重置密码
		uri.add("/doRestPassword.do"); //重置密码
		uri.add("/restTime.htm"); //重置密码
		uri.add("/activateAccount.do"); //激活会员账号邮件链接
		uri.add("/advertisement/selectPublish.do"); //加载首页一般广告
		uri.add("/advertisement/selectPublishCarouse.do"); //加载首页轮播图广告
		uri.add("/project/publishTechnologyProject.do"); //科技项目
		uri.add("/project/publishDesignProject.do"); //设计项目
		uri.add("/project/publishAgricultureProject.do"); //农业项目
		uri.add("/project/publishOthersProject.do"); //其他项目
		uri.add("/potalProject/index.htm"); //其他项目

		uri.add("/draw.htm"); //抽签页面
		uri.add("/doDraw.do"); //完成抽签
		uri.add("/showDrawInfo.htm"); //抽签信息页面
		uri.add("/showDrawId.htm"); //抽签成功跳转页面
		uri.add("/drawInfo.do"); //查询抽签数据抽签
		uri.add("/doDeleteBatch.do"); //批量删除抽签数据
		uri.add("/newDraw.do"); //开启新一轮抽签

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
