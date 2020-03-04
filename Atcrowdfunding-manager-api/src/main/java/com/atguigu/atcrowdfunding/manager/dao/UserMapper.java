package com.atguigu.atcrowdfunding.manager.dao;

import com.atguigu.atcrowdfunding.bean.User;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

/**
 * �û���dao��ӿ�
 */
@Repository
public interface UserMapper {

    //����idɾ��
    int deleteByPrimaryKey(Integer id);

    //����û�
    int insert(User record);

    //����id��ѯ
    User selectByPrimaryKey(Integer id);

    //��ѯ����
    List<User> selectAll();

    //����id�޸�
    int updateByPrimaryKey(User record);

    //��ѯ�û���Ϣ,У���¼��Ϣ
	User queryUserLogin(Map<String, Object> paramMap);
}