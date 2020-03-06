package com.atguigu.atcrowdfunding.manager.dao;

import org.springframework.stereotype.Repository;

import java.util.Map;

/**
 * 测试环境是否搭建成功
 */
@Repository
public interface TestDao {

	//添加数据
	public void insert(Map map);
	
}
