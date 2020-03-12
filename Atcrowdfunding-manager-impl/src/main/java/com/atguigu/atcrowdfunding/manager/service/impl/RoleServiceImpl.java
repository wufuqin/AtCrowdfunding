package com.atguigu.atcrowdfunding.manager.service.impl;

import com.atguigu.atcrowdfunding.bean.Role;
import com.atguigu.atcrowdfunding.bean.RolePermission;
import com.atguigu.atcrowdfunding.manager.dao.RoleMapper;
import com.atguigu.atcrowdfunding.manager.service.RoleService;
import com.atguigu.atcrowdfunding.util.Page;
import com.atguigu.atcrowdfunding.vo.Data;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;

/**
 * 角色维护模块的业务层实现类
 */
@Service
public class RoleServiceImpl implements RoleService {

    @Autowired
    private RoleMapper roleMapper;

    //分页数据查询
    /**
     * 分页数据查询
     * @param pageno    当前页数
     * @param pagesize  每页显示的数据条数
     */
    @Override
    public Page queryPage(Integer pageno, Integer pagesize) {

        //创建一个分页对象，将查询的对应分页信息传入
        Page page = new Page(pageno, pagesize);

        //获取索引
        Integer startIndex = page.getStartIndex();

        //获取查询出来的分页数据
        List datas = roleMapper.queryList(startIndex,pagesize);

        //设置分页数据到Page分页对象中
        page.setDatas(datas);

        //查询总的记录条数
        Integer totalsize = roleMapper.queryCount();

        //设置总记录数到Page分页对象中
        page.setTotalsize(totalsize);
        page.setTotalno(totalsize);

        return page;
    }

    //模糊查询
    /**
     * 模糊查询
     * @param paramMap 封装好的模糊查询条件
     */
    @Override
    public Page queryPage(HashMap<String, Object> paramMap) {
        //创建一个分页对象，将查询的对应分页信息传入
        Page page = new Page((Integer) paramMap.get("pageno"), (Integer) paramMap.get("pagesize"));

        //获取索引
        Integer startIndex = page.getStartIndex();
        //将索引信息存入map集合
        paramMap.put("startIndex",startIndex);

        //获取查询出来的分页数据
        List datas = roleMapper.queryListLike(paramMap);

        //设置分页数据到Page分页对象中
        page.setDatas(datas);

        //查询总的记录条数
        Integer totalsize = roleMapper.queryCountLike(paramMap);

        //设置总记录数到Page分页对象中
        page.setTotalsize(totalsize);
        page.setTotalno(totalsize);

        return page;
    }

    //添加角色
    @Override
    public int saveUser(Role role) {
        return roleMapper.insert(role);
    }

    //删除角色
    @Override
    public int deleteRole(Integer id) {
        return roleMapper.deleteByPrimaryKey(id);
    }

    //修改角色数据
    @Override
    public int updateRole(Role role) {
        return roleMapper.updateByPrimaryKey(role);
    }

    //批量删除用户
    @Override
    public int deleteBatchRole(Integer[] ids) {
        int totalCount = 0;
        //计算实际删除的记录数
        for (Integer id : ids) {
            roleMapper.deleteByPrimaryKey(id);
            totalCount += 1;
        }
        //实际删除记录数与计划删除记录数比较
        if (totalCount != ids.length){
            throw new  RuntimeException("批量删除数据失败");
        }
        return totalCount;
    }

    //根据id查询角色
    @Override
    public Role getRoleById(Integer id) {
        return roleMapper.selectByPrimaryKey(id);
    }

    //完成分配许可
    @Override
    public int saveRolePermissionRelationship(Integer roleid, Data datas) {

        //删除原来已经有的权限
        roleMapper.deleteRolePermissionRelationship(roleid);

        int totalCount = 0 ;
        List<Integer> ids = datas.getIds();
        //将选中的权限分配
        for (Integer permissionid : ids) {
            RolePermission rp = new RolePermission();
            rp.setRoleid(roleid);
            rp.setPermissionid(permissionid);
            int count = roleMapper.insertRolePermission(rp);
            totalCount += count ;
        }

        return totalCount;
    }
}
