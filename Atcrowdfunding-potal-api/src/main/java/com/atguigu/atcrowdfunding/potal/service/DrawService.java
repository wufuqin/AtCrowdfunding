package com.atguigu.atcrowdfunding.potal.service;

import com.atguigu.atcrowdfunding.bean.Draw;
import com.atguigu.atcrowdfunding.bean.DrawId;
import com.atguigu.atcrowdfunding.util.Page;

import java.util.List;

/**
 * 抽签的service层接口
 */
public interface DrawService {

    //添加新的抽签信息
    int AddDrawInfo(Draw draw);

    //学号是否存在
    List<String> queryStudentId(String studentId);

    //签号是否存在
    List<Integer> queryDrawId(Integer draw);

    //调用service层查询方法，返回一个分页数据对象
    Page queryDrawPage(Integer pageno, Integer pagesize);

    //批量删除抽签数据
    int deleteBatchDraw(Integer[] id);

    //删除抽签表中的所有数据
    void deleteDrawTableInfo();

    //删除抽签号表中的全部数据
    void deleteDrawIdTableInfo();

    //循环添加数据到抽签号表中
    void addDrawId(DrawId drawId);

    //查询数据库中的抽签号
    List<DrawId> queryDrawIdList();

    //删除抽签号表中的对应签号
    void deleteDrawIdInfoByDraw(int drawId);
}
