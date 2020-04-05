package com.atguigu.atcrowdfunding.manager.dao;

import com.atguigu.atcrowdfunding.bean.Advertisement;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;

/**
 * 广告管理dao层接口
 */
@Repository
public interface AdvertisementMapper {
    //根据id删除
    int deleteByPrimaryKey(Integer id);

    //添加数据
    int insert(Advertisement record);

    //根据id查询
    Advertisement selectByPrimaryKey(Integer id);

    //查询所有
    List<Advertisement> selectAll();

    //根据id修改
    int updateByPrimaryKey(Advertisement record);

    //获取查询出来的分页数据
    List queryList(@Param("startIndex") Integer startIndex, @Param("pagesize") Integer pagesize);

    //查询总的记录条数
    Integer queryCount();

    //获取查询出来的分页数据
    List queryListLike(HashMap<String, Object> paramMap);

    //查询总的记录条数
    Integer queryCountLike(HashMap<String, Object> paramMap);

    //将广告状态设置为 status:2 审核完成
    void updateAdvertisementStatusByIdPass(Integer id);

    //拒绝申请
    void updateAdvertisementStatusByIdRefuse(Integer id);

    //获取查询需要发布广告的分页数据
    List queryPublishList(@Param("startIndex") Integer startIndex, @Param("pagesize") Integer pagesize);

    //查询需要发布广告总的记录条数
    Integer queryPublishCount();

    //获取查询出来查询需要发布的广告的分页数据
    List queryPublishListLike(HashMap<String, Object> paramMap);

    //查询总的查询需要发布的广告记录条数
    Integer queryPublishCountLike(HashMap<String, Object> paramMap);

    //发布广告将广告的status改为 3
    void updateAdvertisementStatusByIdPublish(Integer id);

    //获取查询已经发布的广告数据
    List queryPublishAdvertisementList(@Param("startIndex") Integer startIndex, @Param("pagesize") Integer pagesize);

    //查询已经发布的广告数据总的记录条数
    Integer queryPublishAdvertisementCount();

    //获取查询已经发布的轮播图数据
    List queryPublishCarouseAdvertisementList(@Param("startIndex") Integer startIndex, @Param("pagesize") Integer pagesize);

    //查询已经发布的轮播图数据总的记录条数
    Integer queryPublishCarouseAdvertisementCount();
}