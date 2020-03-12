package com.atguigu.atcrowdfunding.manager.dao;

import com.atguigu.atcrowdfunding.bean.Role;
import com.atguigu.atcrowdfunding.bean.RolePermission;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;

/**
 * 用户维护模块的dao层接口
 */
@Repository
public interface RoleMapper {

    //根据id删除
    int deleteByPrimaryKey(Integer id);

    //添加数据
    int insert(Role record);

    //根据id查询
    Role selectByPrimaryKey(Integer id);

    //查询所有
    List<Role> selectAll();

    //根据id修改
    int updateByPrimaryKey(Role record);

    //获取查询出来的分页数据
    //当想mybatis传递多个参数是，需要使用注解指定参数名，否则mybatis不能自动识别
    List queryList(@Param("startIndex") Integer startIndex, @Param("pagesize") Integer pagesize);

    //查询总的记录条数
    Integer queryCount();

    //获取模糊查询分页数据
    List queryListLike(HashMap<String, Object> paramMap);

    //模糊查询总记录数
    Integer queryCountLike(HashMap<String, Object> paramMap);

    //删除原来已经有的权限
    void deleteRolePermissionRelationship(Integer roleid);

    //分配权限
    int insertRolePermission(RolePermission rp);
}