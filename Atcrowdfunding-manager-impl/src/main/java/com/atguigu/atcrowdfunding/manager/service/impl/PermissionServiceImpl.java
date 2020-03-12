package com.atguigu.atcrowdfunding.manager.service.impl;

import com.atguigu.atcrowdfunding.bean.Permission;
import com.atguigu.atcrowdfunding.manager.dao.PermissionMapper;
import com.atguigu.atcrowdfunding.manager.service.PermissionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 许可维护的service实现类
 */
@Service
public class PermissionServiceImpl implements PermissionService {

    @Autowired
    private PermissionMapper permissionMapper;

    //查询父节点
    @Override
    public Permission getRootPermission() {
        return permissionMapper.getRootPermission();
    }

    //查询子节点
    @Override
    public List<Permission> getChildrenPermissionByPid(Integer id) {
        return permissionMapper.getChildrenPermissionByPid(id);
    }

    //查询所有
    @Override
    public List<Permission> queryAllPermission() {
        return permissionMapper.queryAllPermission();
    }

    //添加权限
    @Override
    public int savePermission(Permission permission) {
        return permissionMapper.insert(permission);
    }

    //根据id查询许可
    @Override
    public Permission getPermissionById(Integer id) {
        return permissionMapper.selectByPrimaryKey(id);
    }

    //修改许可
    @Override
    public int updatePermission(Permission permission) {
        return permissionMapper.updateByPrimaryKey(permission);
    }

    //删除权限方法
    @Override
    public int deletePermission(Integer id) {
        return permissionMapper.deleteByPrimaryKey(id);
    }

    //根据角色id查询该角色之前所分配过的许可
    @Override
    public List<Integer> queryPermissionIdByRoleId(Integer roleid) {
        return permissionMapper.queryPermissionIdByRoleId(roleid);
    }
}


















