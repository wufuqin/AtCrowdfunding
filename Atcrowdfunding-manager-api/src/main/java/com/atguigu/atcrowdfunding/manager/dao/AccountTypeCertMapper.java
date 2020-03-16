package com.atguigu.atcrowdfunding.manager.dao;

import com.atguigu.atcrowdfunding.bean.AccountTypeCert;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * 资质分类管理dao层接口
 */
@Repository
public interface AccountTypeCertMapper {

    //根据id删除
    int deleteByPrimaryKey(Integer id);

    //添加数据
    int insert(AccountTypeCert record);

    //根据id查询
    AccountTypeCert selectByPrimaryKey(Integer id);

    //查询所有
    List<AccountTypeCert> selectAll();

    //根据id修改
    int updateByPrimaryKey(AccountTypeCert record);
}






















