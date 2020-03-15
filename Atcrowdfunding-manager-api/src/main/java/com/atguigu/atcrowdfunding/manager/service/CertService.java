package com.atguigu.atcrowdfunding.manager.service;

import com.atguigu.atcrowdfunding.bean.Cert;
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

    //添加资质
    int saveCert(Cert cert);

    //删除资质数据
    int deleteCert(Integer id);

    //批量删除资质
    int deleteBatchCert(Integer[] id);

    //根据id查询资质信息
    Cert getCertById(Integer id);

    //修改资质数据
    int updateCert(Cert cert);
}







































