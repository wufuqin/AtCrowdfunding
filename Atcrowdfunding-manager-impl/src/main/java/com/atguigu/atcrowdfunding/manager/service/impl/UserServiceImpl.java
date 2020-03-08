package com.atguigu.atcrowdfunding.manager.service.impl;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.atguigu.atcrowdfunding.util.Const;
import com.atguigu.atcrowdfunding.util.MD5Util;
import com.atguigu.atcrowdfunding.util.Page;
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

	//处理用户的登录请求，查询登录用户的信息是否存在
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

	//分页数据查询
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
		page.setTotalno(totalsize);

		return page;
	}

	//模糊查询
	/**
	 * 模糊查询
	 * @param paramMap 封装好的模糊查询条件
	 */
	@Override
	public Page queryPage(HashMap<String, Object> paramMap) {
		//创建一个分页对象，将查询的对应分页信息传入
		Page page = new Page((Integer) paramMap.get("pageno"), (Integer) paramMap.get("pagesize"));

		//获取索引
		Integer startIndex = page.getStartIndex();
		//将索引信息存入map集合
		paramMap.put("startIndex",startIndex);

		//获取查询出来的分页数据
		List datas = userMapper.queryListLike(paramMap);

		//设置分页数据到Page分页对象中
		page.setDatas(datas);

		//查询总的记录条数
		Integer totalsize = userMapper.queryCountLike(paramMap);

		//设置总记录数到Page分页对象中
		page.setTotalsize(totalsize);
		page.setTotalno(totalsize);

		return page;
	}

	//保存用户
	@Override
	public int saveUser(User user) {
		//设置时间格式
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		//创建一个日期对象
		Date date = new Date();
		String createTime = sdf.format(date);
		//设置账户初始值
		user.setCreatetime(createTime);
		user.setUserpswd(MD5Util.digest(Const.PASSWORD));
		return userMapper.insert(user);
	}

}


















