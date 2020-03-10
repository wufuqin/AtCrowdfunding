package com.atguigu.atcrowdfunding.manager.service;

import com.atguigu.atcrowdfunding.bean.Role;
import com.atguigu.atcrowdfunding.util.Page;

import java.util.HashMap;

/**
 * 角色维护模块的service接口
 */
public interface RoleService {
    //分页查询数据
    Page queryPage(Integer pageno, Integer pagesize);

    //模糊查询
    Page queryPage(HashMap<String, Object> paramMap);

    //添加角色
    int saveUser(Role role);

    //删除角色
    int deleteRole(Integer id);

    //修改角色数据
    int updateRole(Role role);

    //批量删除用户
    int deleteBatchRole(Integer[] id);

    //根据id查询角色
    Role getRoleById(Integer id);
}















