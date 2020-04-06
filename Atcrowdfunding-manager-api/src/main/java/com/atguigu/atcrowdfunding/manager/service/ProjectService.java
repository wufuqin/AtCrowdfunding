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

    //删除项目
    int deleteProject(Integer id);

    //调用删除方法
    int deleteBatchProject(Integer[] id);

    //根据id查询项目信息
    Project queryProjectById(Integer id);

    //修改项目信息
    void updateProjectById(Project project);

    //用service层的方法将项目状态设置为 status:1 审核完成
    void updateProjectStatusByIdPass(Integer id);

    //项目状态设置为 status5 拒绝申请
    void updateProjectStatusByIdRefuse(Integer id);

    //查询需要发布的项目信息
    Page queryPagePublishProject(Integer pageno, Integer pagesize);

    //发布项目，将项目的status该为 2
    void updateProjectStatusByIdPublish(Integer id);

    //查询科技类项目数据
    Page queryPublishTechnologyProject(Integer pageno, Integer pagesize);

    //查询设计类项目
    Page queryPublishDesignProject(Integer pageno, Integer pagesize);

    //查询农业类项目
    Page queryPublishAgricultureProject(Integer pageno, Integer pagesize);

    //查询其他类项目
    Page queryPublishOthersProject(Integer pageno, Integer pagesize);
}
