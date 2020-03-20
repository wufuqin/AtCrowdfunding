package com.atguigu.atcrowdfunding.manager.service;

import com.atguigu.atcrowdfunding.bean.Cert;
import com.atguigu.atcrowdfunding.bean.MemberCert;
import com.atguigu.atcrowdfunding.util.Page;

import java.util.HashMap;
import java.util.List;

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

    //查询出所有的资质
    List<Cert> queryCertAll();

    //根据当前用户选择的账户类型查询需要上传的资质图片
    List<Cert> queryCertByAcctType(String accttype);

    //保存会员与资质关系数据
    void saveMemberCert(List<MemberCert> certimgs);
}







































