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
        return projectMapper.insert(project);
    }
}

















