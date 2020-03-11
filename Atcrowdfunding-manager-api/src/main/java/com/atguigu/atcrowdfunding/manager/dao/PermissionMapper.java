package com.atguigu.atcrowdfunding.manager.dao;

import com.atguigu.atcrowdfunding.bean.Permission;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * 许可维护的dao层接口
 */
@Repository
public interface PermissionMapper {

    //根据id删除
    int deleteByPrimaryKey(Integer id);

    //添加许可
    int insert(Permission record);

    //根据id查询
    Permission selectByPrimaryKey(Integer id);

    //查询所有许可
    List<Permission> selectAll();

    //根据id修改
    int updateByPrimaryKey(Permission record);
}






















