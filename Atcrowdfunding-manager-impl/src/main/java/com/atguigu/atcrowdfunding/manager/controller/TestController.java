package com.atguigu.atcrowdfunding.manager.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.atguigu.atcrowdfunding.manager.service.TestService;

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
	 */
	/**
	 * AOP原理:动态代理.
	 * 	如果目标对象有接口,那么默认采用JDK动态代理(基于接口(代理类和目标类实现共同的接口.)).
	 * 	如果目标对象 没有接口,那么采用Cglib动态代理(基于继承(代理类是目标类的子类)).
	 *  推荐,使用JDK动态代理 .也就是我们推荐采用面向接口编程.面向抽象编程.
	 */
	//@Autowired(required=false)
	//@Qualifier(value="abc")
	@Autowired
	private TestService testService; //依赖倒转原则.

	@RequestMapping("/test")
	public String test(String name) {
		System.out.println("TestController");
		testService.insert();
		return "success";
	}

}
