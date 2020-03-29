package com.atguigu.atcrowdfunding.manager.service;

import com.atguigu.atcrowdfunding.bean.Project;
import com.atguigu.atcrowdfunding.util.Page;

import java.util.HashMap;

/**
 * 项目管理的service接口
 */

public interface ProjectService {

    //调用service层查询方法，返回一个分页数据对象
    Page queryPageProject(Integer pageno, Integer pagesize);

    //调用service层查询方法，返回一个分页数据对象，模糊查询
    Page queryPageProjectLike(HashMap<String, Object> paramMap);

    //保存项目
    int saveProject(Project project);
}
