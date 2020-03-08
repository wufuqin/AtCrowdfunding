package com.atguigu.atcrowdfunding.manager.service;

import java.util.HashMap;
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

	//模糊查询
    Page queryPage(HashMap<String, Object> paramMap);

    //根据id查询用户信息
	User getUserById(Integer id);

	//修改用户
    int updateUser(User user);

    //删除用户
    int deleteUser(Integer id);
}
