package com.atguigu.atcrowdfunding.manager.service;

import java.util.Map;

import com.atguigu.atcrowdfunding.bean.User;
import com.atguigu.atcrowdfunding.util.Page;

/**
 * 用户的业务层接口
 */
public interface UserService {

	//查询用户，校验用户是否存在
	User queryUserLogin(Map<String, Object> paramMap);

	//分页查询数据
	Page queryPage(Integer pageno, Integer pagesize);

	//保存用户
	int saveUser(User user);
}
