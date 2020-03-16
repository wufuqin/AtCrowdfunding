package com.atguigu.atcrowdfunding.manager.service;

import com.atguigu.atcrowdfunding.bean.Advertisement;
import com.atguigu.atcrowdfunding.util.Page;

import java.util.HashMap;

/**
 * 广告管理service层接口
 */
public interface AdvertisementService {
    //分页查询数据
    Page queryPageAdvertisement(Integer pageno, Integer pagesize);

    //模糊查询
    Page queryPageAdvertisement(HashMap<String, Object> paramMap);

    //删除广告数据
    int deleteAdvertisement(Integer id);

    //批量删除
    int deleteBatchAdvertisement(Integer[] id);

    //保存广告
    int insertAdvertisement(Advertisement advertisement);

    //根据id查询广告信息
    Advertisement getAdvertisementById(Integer id);

    //修改广告数据
    int updateAdvertisement(Advertisement advertisement);
}
