package com.atguigu.atcrowdfunding.manager.service.impl;

import com.atguigu.atcrowdfunding.bean.Project;
import com.atguigu.atcrowdfunding.bean.User;
import com.atguigu.atcrowdfunding.manager.dao.ProjectMapper;
import com.atguigu.atcrowdfunding.manager.service.ProjectService;
import com.atguigu.atcrowdfunding.util.Const;
import com.atguigu.atcrowdfunding.util.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

/**
 * 项目管理的service实现类
 */
@Service
public class ProjectServiceImpl implements ProjectService {

    @Autowired
    private ProjectMapper projectMapper;

    //调用service层查询方法，返回一个分页数据对象
    @Override
    public Page queryPageProject(Integer pageno, Integer pagesize) {
        //创建一个分页对象，将查询的对应分页信息传入
        Page page = new Page(pageno, pagesize);

        //获取索引
        Integer startIndex = page.getStartIndex();

        //获取查询出来的分页数据
        List datas = projectMapper.queryList(startIndex,pagesize);

        //设置分页数据到Page分页对象中
        page.setDatas(datas);

        //查询总的记录条数
        Integer totalsize = projectMapper.queryCount();

        //设置总记录数到Page分页对象中
        page.setTotalsize(totalsize);
        page.setTotalno(totalsize);

        return page;
    }

    //调用service层查询方法，返回一个分页数据对象，模糊查询
    @Override
    public Page queryPageProjectLike(HashMap<String, Object> paramMap) {
        //创建一个分页对象，将查询的对应分页信息传入
        Page page = new Page((Integer) paramMap.get("pageno"), (Integer) paramMap.get("pagesize"));

        //获取索引
        Integer startIndex = page.getStartIndex();
        //将索引信息存入map集合
        paramMap.put("startIndex",startIndex);

        //获取查询出来的分页数据
        List datas = projectMapper.queryListLike(paramMap);

        //设置分页数据到Page分页对象中
        page.setDatas(datas);

        //查询总的记录条数
        Integer totalsize = projectMapper.queryCountLike(paramMap);

        //设置总记录数到Page分页对象中
        page.setTotalsize(totalsize);
        page.setTotalno(totalsize);

        return page;
    }

    //保存项目
    @Override
    public int saveProject(Project project) {
        //设置时间格式
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        //创建一个日期对象
        Date date = new Date();
        String createTime = sdf.format(date);
        project.setStatus("0");
        project.setDeploydate(null);
        project.setSupportmoney(1L);
        project.setSupporter(0);
        project.setCompletion(0);
        project.setCreatedate(createTime);
        project.setFollower(0);
        project.setRaiseMoney(0);
        return projectMapper.insert(project);
    }

    //删除项目
    @Override
    public int deleteProject(Integer id) {
        return projectMapper.deleteByPrimaryKey(id);
    }

    //调用删除方法
    @Override
    public int deleteBatchProject(Integer[] ids) {
        int totalCount = 0;
        //计算实际删除的记录数
        for (Integer id : ids) {
            projectMapper.deleteByPrimaryKey(id);
            totalCount += 1;
        }
        //实际删除记录数与计划删除记录数比较
        if (totalCount != ids.length){
            throw new  RuntimeException("批量删除数据失败");
        }
        return totalCount;
    }

    //根据id查询项目信息
    @Override
    public Project queryProjectById(Integer id) {
        return projectMapper.selectByPrimaryKey(id);
    }

    //修改项目信息
    @Override
    public void updateProjectById(Project project) {
        projectMapper.updateByPrimaryKey(project);
    }

    //将项目状态设置为 status:1 审核完成
    @Override
    public void updateProjectStatusByIdPass(Integer id) {
        projectMapper.updateProjectStatusByIdPass(id);
    }

    //项目状态设置为 status5 拒绝申请
    @Override
    public void updateProjectStatusByIdRefuse(Integer id) {
        projectMapper.updateProjectStatusByIdRefuse(id);
    }

    //查询需要发布的项目信息
    @Override
    public Page queryPagePublishProject(Integer pageno, Integer pagesize) {
        //创建一个分页对象，将查询的对应分页信息传入
        Page page = new Page(pageno, pagesize);

        //获取索引
        Integer startIndex = page.getStartIndex();

        //获取查询需要发布广告的分页数据
        List datas = projectMapper.queryPublishList(startIndex,pagesize);

        //设置分页数据到Page分页对象中
        page.setDatas(datas);

        //查询需要发布广告总的记录条数
        Integer totalsize = projectMapper.queryPublishCount();

        //设置总记录数到Page分页对象中
        page.setTotalsize(totalsize);
        page.setTotalno(totalsize);

        return page;
    }

    //发布项目，将项目的status该为 2
    @Override
    public void updateProjectStatusByIdPublish(Integer id) {
        projectMapper.updateProjectStatusByIdPublish(id);
    }

    //查询科技类项目数据
    @Override
    public Page queryPublishTechnologyProject(Integer pageno, Integer pagesize) {
        //创建一个分页对象，将查询的对应分页信息传入
        Page page = new Page(pageno, pagesize);

        //获取索引
        Integer startIndex = page.getStartIndex();

        //获取查询已经发布的科技类项目数据
        List datas = projectMapper.queryPublishTechnologyProject(startIndex,pagesize);

        //设置分页数据到Page分页对象中
        page.setDatas(datas);

        //查询查询已经发布的科技类项目数据总的记录条数
        Integer totalsize = projectMapper.queryPublishTechnologyProjectCount();

        //设置总记录数到Page分页对象中
        page.setTotalsize(totalsize);
        page.setTotalno(totalsize);

        return page;
    }

    //查询设计类项目
    @Override
    public Page queryPublishDesignProject(Integer pageno, Integer pagesize) {
        //创建一个分页对象，将查询的对应分页信息传入
        Page page = new Page(pageno, pagesize);

        //获取索引
        Integer startIndex = page.getStartIndex();

        //获取查询已经发布的设计类项目数据
        List datas = projectMapper.queryPublishDesignProjectList(startIndex,pagesize);

        //设置分页数据到Page分页对象中
        page.setDatas(datas);

        //查询查询已经发布的设计类项目数据总的记录条数
        Integer totalsize = projectMapper.queryPublishDesignProjectCount();

        //设置总记录数到Page分页对象中
        page.setTotalsize(totalsize);
        page.setTotalno(totalsize);

        return page;
    }

    //查询农业类项目
    @Override
    public Page queryPublishAgricultureProject(Integer pageno, Integer pagesize) {
        //创建一个分页对象，将查询的对应分页信息传入
        Page page = new Page(pageno, pagesize);

        //获取索引
        Integer startIndex = page.getStartIndex();

        //获取查询已经发布的农业类项目数据
        List datas = projectMapper.queryPublishAgricultureProjectList(startIndex,pagesize);

        //设置分页数据到Page分页对象中
        page.setDatas(datas);

        //查询查询已经发布的农业类项目数据总的记录条数
        Integer totalsize = projectMapper.queryPublishAgricultureProjectCount();

        //设置总记录数到Page分页对象中
        page.setTotalsize(totalsize);
        page.setTotalno(totalsize);

        return page;
    }

    //查询其他类项目
    @Override
    public Page queryPublishOthersProject(Integer pageno, Integer pagesize) {
        //创建一个分页对象，将查询的对应分页信息传入
        Page page = new Page(pageno, pagesize);

        //获取索引
        Integer startIndex = page.getStartIndex();

        //获取查询已经发布的其他类项目数据
        List datas = projectMapper.queryPublishOthersProjectList(startIndex,pagesize);

        //设置分页数据到Page分页对象中
        page.setDatas(datas);

        //查询查询已经发布的其他类项目数据总的记录条数
        Integer totalsize = projectMapper.queryPublishOthersProjectCount();

        //设置总记录数到Page分页对象中
        page.setTotalsize(totalsize);
        page.setTotalno(totalsize);

        return page;
    }

    //根据会员商家id查询商家发布的众筹项目
    @Override
    public Page queryPageShowMerchantProject(HashMap<String, Object> paramMap) {
        //创建一个分页对象，将查询的对应分页信息传入
        Page page = new Page((Integer) paramMap.get("pageno"), (Integer) paramMap.get("pagesize"));

        //获取索引
        Integer startIndex = page.getStartIndex();
        //将索引信息存入map集合
        paramMap.put("startIndex",startIndex);

        //获取查询出来的分页数据
        List datas = projectMapper.queryShowMerchantProjectList(paramMap);

        //设置分页数据到Page分页对象中
        page.setDatas(datas);

        //查询总的记录条数
        Integer totalsize = projectMapper.queryShowMerchantProjectCount(paramMap);

        //设置总记录数到Page分页对象中
        page.setTotalsize(totalsize);
        page.setTotalno(totalsize);

        return page;
    }

}

















