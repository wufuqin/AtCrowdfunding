package com.atguigu.atcrowdfunding.manager.service.impl;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.atguigu.atcrowdfunding.manager.dao.TestDao;
import com.atguigu.atcrowdfunding.manager.service.TestService;

/**
 * 测试数据
 */
@Service
public class TestServiceImpl implements TestService {

	@Autowired
	private TestDao testDao ;
	
	@Override
	public void insert() {
		Map map = new HashMap();
		map.put("name", "张三");
		testDao.insert(map);
	}

}
