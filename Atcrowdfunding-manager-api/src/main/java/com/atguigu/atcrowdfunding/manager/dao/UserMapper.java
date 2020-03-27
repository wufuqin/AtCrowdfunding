package com.atguigu.atcrowdfunding.manager.dao;

import com.atguigu.atcrowdfunding.bean.Permission;
import com.atguigu.atcrowdfunding.bean.Role;
import com.atguigu.atcrowdfunding.bean.User;
import com.atguigu.atcrowdfunding.util.Page;
import com.atguigu.atcrowdfunding.vo.Data;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
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

    //根据id修改（可修改密码）
    int updateUserById(User user);

    //查询用户信息,校验登录信息
    User queryUserLogin(Map<String, Object> paramMap);

    //获取查询出来的分页数据
    //当想mybatis传递多个参数是，需要使用注解指定参数名，否则mybatis不能自动识别
    List queryList(@Param("startIndex") Integer startIndex, @Param("pagesize") Integer pagesize);

    //查询总的记录条数
    Integer queryCount();

    //获取模糊查询分页数据
    List queryListLike(HashMap<String, Object> paramMap);

    //模糊查询总记录数
    Integer queryCountLike(HashMap<String, Object> paramMap);

    //查询所有的角色
    List<Role> queryAllRole();

    //根据用户id查询用户拥有的角色的id
    List<Integer> queryRoleByUserId(Integer id);

    //分配角色
    void addAssignRole(@Param("userid") Integer userid, @Param("data") Data data);

    //取消权限
    void deleteAssignRole(@Param("userid") Integer userid, @Param("data") Data data);

    //查询用户拥有的权限
    List<Permission> queryPermissionByUserId(Integer id);
}