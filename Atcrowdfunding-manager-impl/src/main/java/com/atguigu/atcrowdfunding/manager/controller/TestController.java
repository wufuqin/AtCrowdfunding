package com.atguigu.atcrowdfunding.manager.controller;

import com.atguigu.atcrowdfunding.util.AjaxResult;
import com.atguigu.atcrowdfunding.util.MD5Util;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.atguigu.atcrowdfunding.manager.service.TestService;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;

@Controller
public class TestController {

	/**
	 * @Autowired
	 * 首先根据byType进行类型查找:
	 * 		如果查找到一个,直接注入;
	 * 		如果查找到多个:
	 * 			根据byName进行注入:
	 * 				将多个对象中其中名称与变量名称一致的那个bean注入进来.
	 * 				如果多个对象没有名称是与变量名称一致的:
	 * 					可以指定@Qualifier(value="testServiceImpl"),将其中一个注入进来.
	 * 					如果	@Qualifier 所指定的名称,没有与任何一个bean的名称一致,会报错.
	 * 				如果无法注入,不希望报错:	@Autowired(required=false)
	 *
	 * AOP原理:动态代理.
	 * 	如果目标对象有接口,那么默认采用JDK动态代理(基于接口(代理类和目标类实现共同的接口.)).
	 * 	如果目标对象 没有接口,那么采用Cglib动态代理(基于继承(代理类是目标类的子类)).
	 *  推荐,使用JDK动态代理 .也就是我们推荐采用面向接口编程.面向抽象编程.
	 */
	//@Autowired(required=false)
	//@Qualifier(value="abc")
	@Autowired
	private TestService testService; //依赖倒转原则.

	/*@RequestMapping("/test")
	public String test(String name) {
		System.out.println("TestController");
		testService.insert();
		return "success/success";
	}*/

	/**
	 * 测试获取上下文路径
	 */
	@RequestMapping("/test")
	public String test(){
		return "alert/test";
	}

	/*//测试短信注册
	@ResponseBody
	@RequestMapping("/doRge")
	public Object doRge(String loginacct, String userpswd, String code,String email, HttpSession session){
		//用来封装ajax请求结果
		AjaxResult result = new AjaxResult();
		try {
			//使用map集合对用户输入的信息进行封装
			Map<String,Object> paramMap = new HashMap<String,Object>();
			paramMap.put("loginacct", loginacct);
			paramMap.put("userpswd", MD5Util.digest(userpswd)); //使用MD5对密码进行加密
			paramMap.put("email", email);
			System.out.println(paramMap);

			//从session域中获取程序生成的验证码
			String checkCode_server = (String) session.getAttribute("CODE");
			//销毁验证码，确保验证码一次性
			session.removeAttribute("CHECKCODE_SERVER");
			//判断用户输入的验证码和实际生成的验证码是否一致，不区分大小写
			if(!checkCode_server.equalsIgnoreCase(code)){
				//验证码不正确(抛出异常信息)
				result.setMessage("验证码错误！");
				result.setSuccess(false);
				return result;
			}
			result.setSuccess(true);
		} catch (Exception e) {
			result.setSuccess(false);
			result.setMessage("注册失败");
			e.printStackTrace();
		}
		return result;
	}*/



}















