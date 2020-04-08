package com.atguigu.atcrowdfunding.potal.service;

import com.atguigu.atcrowdfunding.bean.Project;

/**
 * 前台项目的service层接口
 */
public interface PotalProjectService {

    //根据id查询项目信息
    Project queryPotalProjectInfoById(Integer id);
}
