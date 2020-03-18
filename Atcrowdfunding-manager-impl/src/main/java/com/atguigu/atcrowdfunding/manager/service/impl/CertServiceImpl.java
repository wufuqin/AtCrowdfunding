package com.atguigu.atcrowdfunding.manager.service.impl;

import com.atguigu.atcrowdfunding.bean.Cert;
import com.atguigu.atcrowdfunding.manager.dao.CertMapper;
import com.atguigu.atcrowdfunding.manager.service.CertService;
import com.atguigu.atcrowdfunding.util.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;

/**
 * 资质维护的业务层实现类
 */
@Service
public class CertServiceImpl implements CertService {

    @Autowired
    private CertMapper certMapper;

    //查询分页数据
    @Override
    public Page queryPageCert(Integer pageno, Integer pagesize) {
        //创建一个分页对象，将查询的对应分页信息传入
        Page page = new Page(pageno, pagesize);

        //获取索引
        Integer startIndex = page.getStartIndex();

        //获取查询出来的分页数据
        List datas = certMapper.queryList(startIndex,pagesize);

        //设置分页数据到Page分页对象中
        page.setDatas(datas);

        //查询总的记录条数
        Integer totalsize = certMapper.queryCount();

        //设置总记录数到Page分页对象中
        page.setTotalsize(totalsize);
        page.setTotalno(totalsize);

        return page;
    }

    //模糊查询
    @Override
    public Page queryPageCert(HashMap<String, Object> paramMap) {
        //创建一个分页对象，将查询的对应分页信息传入
        Page page = new Page((Integer) paramMap.get("pageno"), (Integer) paramMap.get("pagesize"));

        //获取索引
        Integer startIndex = page.getStartIndex();
        //将索引信息存入map集合
        paramMap.put("startIndex",startIndex);

        //获取查询出来的分页数据
        List datas = certMapper.queryListLike(paramMap);

        //设置分页数据到Page分页对象中
        page.setDatas(datas);

        //查询总的记录条数
        Integer totalsize = certMapper.queryCountLike(paramMap);

        //设置总记录数到Page分页对象中
        page.setTotalsize(totalsize);
        page.setTotalno(totalsize);

        return page;
    }

    //添加资质
    @Override
    public int saveCert(Cert cert) {
        return certMapper.insert(cert);
    }

    //删除用户数据
    @Override
    public int deleteCert(Integer id) {
        return certMapper.deleteByPrimaryKey(id);
    }

    //批量删除资质
    @Override
    public int deleteBatchCert(Integer[] ids) {
        int totalCount = 0;
        //计算实际删除的记录数
        for (Integer id : ids) {
            certMapper.deleteByPrimaryKey(id);
            totalCount += 1;
        }
        //实际删除记录数与计划删除记录数比较
        if (totalCount != ids.length){
            throw new  RuntimeException("批量删除数据失败");
        }
        return totalCount;
    }

    //根据id查询资质信息
    @Override
    public Cert getCertById(Integer id) {
        return certMapper.selectByPrimaryKey(id);
    }

    //修改资质数据
    @Override
    public int updateCert(Cert cert) {
        return certMapper.updateByPrimaryKey(cert);
    }

    //查询出所有的资质
    @Override
    public List<Cert> queryCertAll() {
        return certMapper.queryCertAll();
    }

}






















