package com.atguigu.atcrowdfunding.manager.dao;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * 项目审核dao层接口
 */
@Repository
public interface AuthProjectMapper {

    //获取查询出来的分页数据
    List queryProjectList(@Param("startIndex") Integer startIndex, @Param("pagesize") Integer pagesize);

    //查询总的记录条数
    Integer queryProjectCount();
}
