package com.atguigu.atcrowdfunding.potal.service.impl;

import com.atguigu.atcrowdfunding.bean.Draw;
import com.atguigu.atcrowdfunding.bean.DrawId;
import com.atguigu.atcrowdfunding.potal.dao.DrawMapper;
import com.atguigu.atcrowdfunding.potal.service.DrawService;
import com.atguigu.atcrowdfunding.util.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 抽签的service层实现类
 */
@Service
public class DrawServiceImpl implements DrawService {

    @Autowired
    private DrawMapper drawMapper;

    //添加新的抽签信息
    @Override
    public int AddDrawInfo(Draw draw) {
        return drawMapper.AddDrawInfo(draw);
    }

    //学号是否存在
    @Override
    public List<String> queryStudentId(String studentId) {
        return drawMapper.queryStudentId(studentId);
    }

    //签号是否存在
    @Override
    public List<Integer> queryDrawId(Integer draw) {
        return drawMapper.queryDrawId(draw);
    }

    //调用service层查询方法，返回一个分页数据对象
    @Override
    public Page queryDrawPage(Integer pageno, Integer pagesize) {
        //创建一个分页对象，将查询的对应分页信息传入
        Page page = new Page(pageno, pagesize);

        //获取索引
        Integer startIndex = page.getStartIndex();

        //获取查询出来的分页数据
        List datas = drawMapper.queryDrawList(startIndex,pagesize);

        //设置分页数据到Page分页对象中
        page.setDatas(datas);

        //查询总的记录条数
        Integer totalsize = drawMapper.queryDrawCount();

        //设置总记录数到Page分页对象中
        page.setTotalsize(totalsize);
        page.setTotalno(totalsize);

        return page;
    }

    //批量删除抽签数据
    @Override
    public int deleteBatchDraw(Integer[] ids) {
        int totalCount = 0;
        //计算实际删除的记录数
        for (Integer id : ids) {
            drawMapper.deleteByPrimaryKey(id);
            totalCount += 1;
        }
        //实际删除记录数与计划删除记录数比较
        if (totalCount != ids.length){
            throw new  RuntimeException("批量删除数据失败");
        }
        return totalCount;
    }

    //删除抽签表中的所有数据
    @Override
    public void deleteDrawTableInfo() {
        drawMapper.deleteDrawTableInfo();
    }

    //删除抽签号表中的全部数据
    @Override
    public void deleteDrawIdTableInfo() {
        drawMapper.deleteDrawIdTableInfo();
    }

    //循环添加数据到抽签号表中
    @Override
    public void addDrawId(DrawId drawId) {
        drawMapper.addDrawId(drawId);
    }

    //查询数据库中的抽签号
    @Override
    public List<DrawId> queryDrawIdList() {
        return drawMapper.queryDrawIdList();
    }

    //删除抽签号表中的对应签号
    @Override
    public void deleteDrawIdInfoByDraw(int drawId) {
        drawMapper.deleteDrawIdInfoByDraw(drawId);
    }

}























