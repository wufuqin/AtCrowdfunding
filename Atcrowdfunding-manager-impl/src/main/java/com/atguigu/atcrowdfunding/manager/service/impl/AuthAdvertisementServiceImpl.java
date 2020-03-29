package com.atguigu.atcrowdfunding.manager.service.impl;

import com.atguigu.atcrowdfunding.manager.dao.AuthAdvertisementMapper;
import com.atguigu.atcrowdfunding.manager.service.AuthAdvertisementService;
import com.atguigu.atcrowdfunding.util.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;

/**
 * 广告管理的service层接口
 */
@Service
public class AuthAdvertisementServiceImpl implements AuthAdvertisementService {

    @Autowired
    private AuthAdvertisementMapper authAdvertisementMapper;

    //调用service层查询方法，返回一个分页数据对象
    @Override
    public Page queryPageAuthAdvertisement(Integer pageno, Integer pagesize) {
        //创建一个分页对象，将查询的对应分页信息传入
        Page page = new Page(pageno, pagesize);

        //获取索引
        Integer startIndex = page.getStartIndex();

        //获取查询出来的分页数据
        List datas = authAdvertisementMapper.queryList(startIndex,pagesize);

        //设置分页数据到Page分页对象中
        page.setDatas(datas);

        //查询总的记录条数
        Integer totalsize = authAdvertisementMapper.queryCount();

        //设置总记录数到Page分页对象中
        page.setTotalsize(totalsize);
        page.setTotalno(totalsize);

        return page;
    }

    //调用service层查询方法，返回一个分页数据对象
    @Override
    public Page queryPageAdvertisementLike(HashMap<String, Object> paramMap) {
        //创建一个分页对象，将查询的对应分页信息传入
        Page page = new Page((Integer) paramMap.get("pageno"), (Integer) paramMap.get("pagesize"));

        //获取索引
        Integer startIndex = page.getStartIndex();
        //将索引信息存入map集合
        paramMap.put("startIndex",startIndex);

        //获取查询出来的分页数据
        List datas = authAdvertisementMapper.queryListLike(paramMap);

        //设置分页数据到Page分页对象中
        page.setDatas(datas);

        //查询总的记录条数
        Integer totalsize = authAdvertisementMapper.queryCountLike(paramMap);

        //设置总记录数到Page分页对象中
        page.setTotalsize(totalsize);
        page.setTotalno(totalsize);

        return page;
    }
}





















