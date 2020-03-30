package com.atguigu.atcrowdfunding.manager.service.impl;

import com.atguigu.atcrowdfunding.manager.dao.AuthProjectMapper;
import com.atguigu.atcrowdfunding.manager.service.AuthProjectService;
import com.atguigu.atcrowdfunding.util.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 项目审核的service层实现类
 */
@Service
public class AuthProjectServiceImpl implements AuthProjectService {

    @Autowired
    private AuthProjectMapper authProjectMapper;

    //调用service层查询方法，返回一个分页数据对象
    @Override
    public Page queryPageAuthProject(Integer pageno, Integer pagesize) {
        //创建一个分页对象，将查询的对应分页信息传入
        Page page = new Page(pageno, pagesize);

        //获取索引
        Integer startIndex = page.getStartIndex();

        //获取查询出来的分页数据
        List datas = authProjectMapper.queryProjectList(startIndex,pagesize);

        //设置分页数据到Page分页对象中
        page.setDatas(datas);

        //查询总的记录条数
        Integer totalsize = authProjectMapper.queryProjectCount();

        //设置总记录数到Page分页对象中
        page.setTotalsize(totalsize);
        page.setTotalno(totalsize);

        return page;
    }
}
