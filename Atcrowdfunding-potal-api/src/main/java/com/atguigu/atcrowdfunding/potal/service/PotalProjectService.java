package com.atguigu.atcrowdfunding.potal.service;

import com.atguigu.atcrowdfunding.bean.MemberProjectSupport;
import com.atguigu.atcrowdfunding.bean.Project;

/**
 * 前台项目的service层接口
 */
public interface PotalProjectService {

    //根据id查询项目信息
    Project queryPotalProjectInfoById(Integer id);

    //保存会员支持的项目信息
    void saveMemberSupportProject(MemberProjectSupport memberProjectSupport);

    //修改有人支持之后的项目数据
    void updateProject(Project project);
}
