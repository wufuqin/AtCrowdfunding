package com.atguigu.atcrowdfunding.potal.dao;

import com.atguigu.atcrowdfunding.bean.Draw;
import com.atguigu.atcrowdfunding.bean.DrawId;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * 抽签的mapper层接口
 */
@Repository
public interface DrawMapper {

    //添加新的抽签信息
    int AddDrawInfo(Draw draw);

    //学号是否存在
    List<String> queryStudentId(String studentId);

    //签号是否存在
    List<Integer> queryDrawId(Integer draw);

    //获取查询出来的分页数据
    List queryDrawList(@Param("startIndex") Integer startIndex, @Param("pagesize") Integer pagesize);

    //查询总的记录条数
    Integer queryDrawCount();

    //批量删除抽签数据
    void deleteByPrimaryKey(Integer id);

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
