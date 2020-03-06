package com.atguigu.atcrowdfunding.manager.service.impl;

import java.util.List;
import java.util.Map;

import com.atguigu.atcrowdfunding.util.Page;
import org.apache.poi.ss.formula.functions.T;
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

	/**
	 * 分页数据查询
	 * @param pageno    当前页数
	 * @param pagesize  每页显示的数据条数
	 */
	@Override
	public Page queryPage(Integer pageno, Integer pagesize) {

		//创建一个分页对象，将查询的对应分页信息传入
		Page page = new Page(pageno, pagesize);

		//获取索引
		Integer startIndex = page.getStartIndex();

		//获取查询出来的分页数据
		List datas = userMapper.queryList(startIndex,pagesize);

		//设置分页数据到Page分页对象中
		page.setDatas(datas);

		//查询总的记录条数
		Integer totalsize = userMapper.queryCount();

		//设置总记录数到Page分页对象中
		page.setTotalsize(totalsize);

		return page;
	}

}


















