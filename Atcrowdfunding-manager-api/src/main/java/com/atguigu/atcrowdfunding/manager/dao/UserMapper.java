package com.atguigu.atcrowdfunding.manager.dao;

import com.atguigu.atcrowdfunding.bean.User;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

/**
 * 用户的dao层接口
 */
@Repository
public interface UserMapper {

    //根据id删除
    int deleteByPrimaryKey(Integer id);

    //添加用户
    int insert(User record);

    //根据id查询
    User selectByPrimaryKey(Integer id);

    //查询所有
    List<User> selectAll();

    //根据id修改
    int updateByPrimaryKey(User record);

    //查询用户信息,校验登录信息
    User queryUserLogin(Map<String, Object> paramMap);
}