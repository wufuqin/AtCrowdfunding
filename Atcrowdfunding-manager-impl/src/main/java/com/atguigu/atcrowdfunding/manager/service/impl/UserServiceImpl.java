package com.atguigu.atcrowdfunding.manager.service.impl;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.atguigu.atcrowdfunding.bean.User;
import com.atguigu.atcrowdfunding.exception.LoginFailException;
import com.atguigu.atcrowdfunding.manager.dao.UserMapper;
import com.atguigu.atcrowdfunding.manager.service.UserService;

/**
 * 用户的业务层实现类
 */
@Service
public class UserServiceImpl implements UserService {

	@Autowired
	private UserMapper userMapper ;

	/**
	 * 处理用户的登录请求，查询登录用户的信息是否存在
	 * @param paramMap 用户输入的登录信息
	 * @return 将用户信息返回
	 */
	@Override
	public User queryUserLogin(Map<String, Object> paramMap) {

		//调用dao层
		User user = userMapper.queryUserLogin(paramMap);
		//判断用户输入数据是否为空
		if(user==null){
			//抛出异常
			throw new LoginFailException("用户账号或密码不正确!");
		}
		return user;
	}

}
