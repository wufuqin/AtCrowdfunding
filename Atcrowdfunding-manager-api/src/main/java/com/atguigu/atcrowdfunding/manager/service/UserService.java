package com.atguigu.atcrowdfunding.manager.service;

import java.util.Map;

import com.atguigu.atcrowdfunding.bean.User;

/**
 * �û���ҵ���ӿ�
 */
public interface UserService {

	//��ѯ�û���У���û��Ƿ����
	User queryUserLogin(Map<String, Object> paramMap);

}
