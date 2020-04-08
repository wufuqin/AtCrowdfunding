package com.atguigu.atcrowdfunding.potal.dao;

import com.atguigu.atcrowdfunding.bean.Project;
import org.springframework.stereotype.Repository;

/**
 * 前台项目的dao层接口
 */
@Repository
public interface PotalProjectMapper {

    //根据id查询项目信息
    Project queryPotalProjectInfoById(Integer id);
}


















