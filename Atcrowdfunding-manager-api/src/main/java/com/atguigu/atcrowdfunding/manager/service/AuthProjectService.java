package com.atguigu.atcrowdfunding.manager.service;

import com.atguigu.atcrowdfunding.util.Page;

/**
 * 项目审核service层接口
 */
public interface AuthProjectService {

    //调用service层查询方法，返回一个分页数据对象
    Page queryPageAuthProject(Integer pageno, Integer pagesize);
}













