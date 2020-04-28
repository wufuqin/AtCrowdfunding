package com.atguigu.atcrowdfunding.potal.service.impl;

import com.atguigu.atcrowdfunding.bean.MemberProjectSupport;
import com.atguigu.atcrowdfunding.bean.Project;
import com.atguigu.atcrowdfunding.potal.dao.PotalProjectMapper;
import com.atguigu.atcrowdfunding.potal.service.PotalProjectService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * 前台项目的service实现类
 */
@Service
public class PotalProjectServiceImpl implements PotalProjectService {

    @Autowired
    private PotalProjectMapper potalProjectMapper;

    //根据id查询项目信息
    @Override
    public Project queryPotalProjectInfoById(Integer id) {
        return potalProjectMapper.queryPotalProjectInfoById(id);
    }

    //保存会员支持的项目信息
    @Override
    public void saveMemberSupportProject(MemberProjectSupport memberProjectSupport) {
        potalProjectMapper.saveMemberSupportProject(memberProjectSupport);
    }
}
























