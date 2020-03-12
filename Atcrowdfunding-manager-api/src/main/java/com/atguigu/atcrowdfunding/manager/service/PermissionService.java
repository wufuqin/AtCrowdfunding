package com.atguigu.atcrowdfunding.manager.service;

import com.atguigu.atcrowdfunding.bean.Permission;

import java.util.List;

/**
 * 许可维护的service接口
 */
public interface PermissionService {

    //查询父节点
    Permission getRootPermission();

    //查询子节点
    List<Permission> getChildrenPermissionByPid(Integer id);

    //查询所有
    List<Permission> queryAllPermission();

    //添加权限
    int savePermission(Permission permission);

    //根据id查询许可
    Permission getPermissionById(Integer id);

    //修改许可
    int updatePermission(Permission permission);

    //删除权限方法
    int deletePermission(Integer id);

    //根据角色id查询该角色之前所分配过的许可
    List<Integer> queryPermissionIdByRoleId(Integer roleid);
}






















