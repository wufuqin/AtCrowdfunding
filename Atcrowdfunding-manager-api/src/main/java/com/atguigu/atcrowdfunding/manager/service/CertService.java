package com.atguigu.atcrowdfunding.manager.service;

import com.atguigu.atcrowdfunding.util.Page;

import java.util.HashMap;

/**
 * 资质维护的业务层接口
 */
public interface CertService {

    //查询分页数据
    Page queryPageCert(Integer pageno, Integer pagesize);

    //模糊查询
    Page queryPageCert(HashMap<String, Object> paramMap);
}







































