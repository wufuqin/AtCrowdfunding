package com.atguigu.atcrowdfunding.potal.dao;

import com.atguigu.atcrowdfunding.bean.MemberProjectSupport;
import com.atguigu.atcrowdfunding.bean.Project;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

/**
 * 前台项目的dao层接口
 */
@Repository
public interface PotalProjectMapper {

    //根据id查询项目信息
    Project queryPotalProjectInfoById(Integer id);

    //保存会员支持的项目信息@Param
    void saveMemberSupportProject(MemberProjectSupport memberProjectSupport);
}


















