package com.atguigu.atcrowdfunding.manager.service;

import java.util.Map;

import com.atguigu.atcrowdfunding.bean.User;

/**
 * 用户的业务层接口
 */
public interface UserService {

	//查询用户，校验用户是否存在
	User queryUserLogin(Map<String, Object> paramMap);

}
