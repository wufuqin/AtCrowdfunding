package com.atguigu.atcrowdfunding.manager.dao;

import com.atguigu.atcrowdfunding.bean.Project;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;

/**
 * 项目管理的dao层接口
 */
@Repository
public interface ProjectMapper {
    //根据id删除
    int deleteByPrimaryKey(Integer id);

    //添加数据
    int insert(Project record);

    //根据id查询
    Project selectByPrimaryKey(Integer id);

    //查询所有
    List<Project> selectAll();

    //根据id修改
    int updateByPrimaryKey(Project record);

    //获取查询出来的分页数据
    List queryList(@Param("startIndex") Integer startIndex, @Param("pagesize") Integer pagesize);

    //查询总的记录条数
    Integer queryCount();

    //获取查询出来的分页数据
    List queryListLike(HashMap<String, Object> paramMap);

    //查询总的记录条数
    Integer queryCountLike(HashMap<String, Object> paramMap);

    //将项目状态设置为 status:1 审核完成
    void updateProjectStatusByIdPass(Integer id);

    //项目状态设置为 status5 拒绝申请
    void updateProjectStatusByIdRefuse(Integer id);

    //获取查询需要发布广告的分页数据
    List queryPublishList(@Param("startIndex") Integer startIndex, @Param("pagesize") Integer pagesize);

    //查询需要发布广告总的记录条数
    Integer queryPublishCount();

    //发布项目，将项目的status该为 2
    void updateProjectStatusByIdPublish(Integer id);

    //获取查询已经发布的科技类项目数据
    List queryPublishTechnologyProject(@Param("startIndex") Integer startIndex, @Param("pagesize") Integer pagesize);

    //查询查询已经发布的科技类项目数据总的记录条数
    Integer queryPublishTechnologyProjectCount();

    //获取查询已经发布的设计类项目数据
    List queryPublishDesignProjectList(@Param("startIndex") Integer startIndex, @Param("pagesize") Integer pagesize);

    //查询查询已经发布的设计类项目数据总的记录条数
    Integer queryPublishDesignProjectCount();

    //获取查询已经发布的农业类项目数据
    List queryPublishAgricultureProjectList(@Param("startIndex") Integer startIndex, @Param("pagesize") Integer pagesize);

    //查询查询已经发布的农业类项目数据总的记录条数
    Integer queryPublishAgricultureProjectCount();

    //获取查询已经发布的其他类项目数据
    List queryPublishOthersProjectList(@Param("startIndex") Integer startIndex, @Param("pagesize") Integer pagesize);

    //查询查询已经发布的其他类项目数据总的记录条数
    Integer queryPublishOthersProjectCount();

    //获取查询出来的分页数据
    List queryShowMerchantProjectList(HashMap<String, Object> paramMap);

    //查询总的记录条数
    Integer queryShowMerchantProjectCount(HashMap<String, Object> paramMap);
}





















