package com.atguigu.atcrowdfunding.manager.service;

import java.util.List;
import java.util.Map;

/**
 * 资质分类管理service层接口
 */
public interface CertTypeService {

    //查询资质与账户类型之间的关系（之前给账户类型分配个的资质）
    List<Map<String, Object>> queryCertAcctType();

    //增加账户类型和资质的关系
    int insertAcctTypeCert(Map<String, Object> paramMap);

    //删除账户类型和资质的关系
    int deleteAcctTypeCert(Map<String, Object> paramMap);
}


















