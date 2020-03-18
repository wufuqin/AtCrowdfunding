package com.atguigu.atcrowdfunding.manager.service.impl;

import com.atguigu.atcrowdfunding.manager.dao.AccountTypeCertMapper;
import com.atguigu.atcrowdfunding.manager.service.CertTypeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 * 资质分类管理service实现类
 */
@Service
public class CertTypeServiceImpl implements CertTypeService {

    @Autowired
    private AccountTypeCertMapper accountTypeCertMapper;

    //查询资质与账户类型之间的关系（之前给账户类型分配个的资质）
    @Override
    public List<Map<String, Object>> queryCertAcctType() {
        return accountTypeCertMapper.queryCertAcctType();
    }

    //增加账户类型和资质的关系
    @Override
    public int insertAcctTypeCert(Map<String, Object> paramMap) {
        return accountTypeCertMapper.insertAcctTypeCert(paramMap);
    }

    //删除账户类型和资质的关系
    @Override
    public int deleteAcctTypeCert(Map<String, Object> paramMap) {
        return accountTypeCertMapper.deleteAcctTypeCert(paramMap);
    }
}























