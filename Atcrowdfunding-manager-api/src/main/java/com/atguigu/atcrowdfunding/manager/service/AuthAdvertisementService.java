package com.atguigu.atcrowdfunding.manager.service;

import com.atguigu.atcrowdfunding.util.Page;

import java.util.HashMap;

/**
 * 广告审核service层接口
 */
public interface AuthAdvertisementService {

    //调用service层查询方法，返回一个分页数据对象
    Page queryPageAuthAdvertisement(Integer pageno, Integer pagesize);

    //调用service层查询方法，返回一个分页数据对象
    Page queryPageAdvertisementLike(HashMap<String, Object> paramMap);
}















