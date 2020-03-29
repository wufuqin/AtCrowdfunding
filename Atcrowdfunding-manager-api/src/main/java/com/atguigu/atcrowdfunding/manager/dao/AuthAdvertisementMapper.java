package com.atguigu.atcrowdfunding.manager.dao;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;

/**
 * 广告审核dao层接口
 */
@Repository
public interface AuthAdvertisementMapper {

    //获取查询出来的分页数据
    List queryList(@Param("startIndex") Integer startIndex, @Param("pagesize") Integer pagesize);

    //查询总的记录条数
    Integer queryCount();

    //获取查询出来的分页数据
    List queryListLike(HashMap<String, Object> paramMap);

    //查询总的记录条数
    Integer queryCountLike(HashMap<String, Object> paramMap);
}

















