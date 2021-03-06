package com.atguigu.atcrowdfunding.manager.service.impl;

import com.atguigu.atcrowdfunding.bean.Advertisement;
import com.atguigu.atcrowdfunding.manager.dao.AdvertisementMapper;
import com.atguigu.atcrowdfunding.manager.service.AdvertisementService;
import com.atguigu.atcrowdfunding.util.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;

/**
 * 广告管理service层实现类
 */
@Service
public class AdvertisementServiceImpl implements AdvertisementService {

    @Autowired
    private AdvertisementMapper advertisementMapper;

    //分页查询数据
    @Override
    public Page queryPageAdvertisement(Integer pageno, Integer pagesize) {
        //创建一个分页对象，将查询的对应分页信息传入
        Page page = new Page(pageno, pagesize);

        //获取索引
        Integer startIndex = page.getStartIndex();

        //获取查询出来的分页数据
        List datas = advertisementMapper.queryList(startIndex,pagesize);

        //设置分页数据到Page分页对象中
        page.setDatas(datas);

        //查询总的记录条数
        Integer totalsize = advertisementMapper.queryCount();

        //设置总记录数到Page分页对象中
        page.setTotalsize(totalsize);
        page.setTotalno(totalsize);

        return page;
    }

    //模糊查询
    @Override
    public Page queryPageAdvertisement(HashMap<String, Object> paramMap) {
        //创建一个分页对象，将查询的对应分页信息传入
        Page page = new Page((Integer) paramMap.get("pageno"), (Integer) paramMap.get("pagesize"));

        //获取索引
        Integer startIndex = page.getStartIndex();
        //将索引信息存入map集合
        paramMap.put("startIndex",startIndex);

        //获取查询出来的分页数据
        List datas = advertisementMapper.queryListLike(paramMap);

        //设置分页数据到Page分页对象中
        page.setDatas(datas);

        //查询总的记录条数
        Integer totalsize = advertisementMapper.queryCountLike(paramMap);

        //设置总记录数到Page分页对象中
        page.setTotalsize(totalsize);
        page.setTotalno(totalsize);

        return page;
    }

    //删除单条数据
    @Override
    public int deleteAdvertisement(Integer id) {
        return advertisementMapper.deleteByPrimaryKey(id);
    }

    //批量删除
    @Override
    public int deleteBatchAdvertisement(Integer[] ids) {
        int totalCount = 0;
        //计算实际删除的记录数
        for (Integer id : ids) {
            advertisementMapper.deleteByPrimaryKey(id);
            totalCount += 1;
        }
        //实际删除记录数与计划删除记录数比较
        if (totalCount != ids.length){
            throw new  RuntimeException("批量删除数据失败");
        }
        return totalCount;
    }

    //保存广告
    @Override
    public int insertAdvertisement(Advertisement advertisement) {
        return advertisementMapper.insert(advertisement);
    }

    //根据id查询广告信息
    @Override
    public Advertisement getAdvertisementById(Integer id) {
        return advertisementMapper.selectByPrimaryKey(id);
    }

    //修改广告数据
    @Override
    public int updateAdvertisement(Advertisement advertisement) {
        return advertisementMapper.updateByPrimaryKey(advertisement);
    }

    //将广告状态设置为 status:2 审核完成
    @Override
    public void updateAdvertisementStatusByIdPass(Integer id) {
        advertisementMapper.updateAdvertisementStatusByIdPass(id);
    }

    //拒绝申请
    @Override
    public void updateAdvertisementStatusByIdRefuse(Integer id) {
        advertisementMapper.updateAdvertisementStatusByIdRefuse(id);
    }

    //查询需要发布的广告
    @Override
    public Page queryPagePublishAdvertisement(Integer pageno, Integer pagesize) {
        //创建一个分页对象，将查询的对应分页信息传入
        Page page = new Page(pageno, pagesize);

        //获取索引
        Integer startIndex = page.getStartIndex();

        //获取查询需要发布广告的分页数据
        List datas = advertisementMapper.queryPublishList(startIndex,pagesize);

        //设置分页数据到Page分页对象中
        page.setDatas(datas);

        //查询需要发布广告总的记录条数
        Integer totalsize = advertisementMapper.queryPublishCount();

        //设置总记录数到Page分页对象中
        page.setTotalsize(totalsize);
        page.setTotalno(totalsize);

        return page;
    }

    //模糊查询需要发布的广告
    @Override
    public Page queryPagePublishLikeAdvertisement(HashMap<String, Object> paramMap) {
        //创建一个分页对象，将查询的对应分页信息传入
        Page page = new Page((Integer) paramMap.get("pageno"), (Integer) paramMap.get("pagesize"));

        //获取索引
        Integer startIndex = page.getStartIndex();
        //将索引信息存入map集合
        paramMap.put("startIndex",startIndex);

        //获取查询出来查询需要发布的广告的分页数据
        List datas = advertisementMapper.queryPublishListLike(paramMap);

        //设置分页数据到Page分页对象中
        page.setDatas(datas);

        //查询总的查询需要发布的广告记录条数
        Integer totalsize = advertisementMapper.queryPublishCountLike(paramMap);

        //设置总记录数到Page分页对象中
        page.setTotalsize(totalsize);
        page.setTotalno(totalsize);

        return page;
    }

    //发布广告将广告的status改为 3
    @Override
    public void updateAdvertisementStatusByIdPublish(Integer id) {
        advertisementMapper.updateAdvertisementStatusByIdPublish(id);
    }

    //查询已经状态为status为3的广告
    @Override
    public Page queryPublishAdvertisement(Integer pageno, Integer pagesize) {
        //创建一个分页对象，将查询的对应分页信息传入
        Page page = new Page(pageno, pagesize);

        //获取索引
        Integer startIndex = page.getStartIndex();

        //获取查询已经发布的广告数据
        List datas = advertisementMapper.queryPublishAdvertisementList(startIndex,pagesize);

        //设置分页数据到Page分页对象中
        page.setDatas(datas);

        //查询已经发布的广告数据总的记录条数
        Integer totalsize = advertisementMapper.queryPublishAdvertisementCount();

        //设置总记录数到Page分页对象中
        page.setTotalsize(totalsize);
        page.setTotalno(totalsize);

        return page;
    }

    //查询轮播图数据
    @Override
    public Page queryPublishCarouseAdvertisement(Integer pageno, Integer pagesize) {
        //创建一个分页对象，将查询的对应分页信息传入
        Page page = new Page(pageno, pagesize);

        //获取索引
        Integer startIndex = page.getStartIndex();

        //获取查询已经发布的轮播图数据
        List datas = advertisementMapper.queryPublishCarouseAdvertisementList(startIndex,pagesize);

        //设置分页数据到Page分页对象中
        page.setDatas(datas);

        //查询已经发布的轮播图数据总的记录条数
        Integer totalsize = advertisementMapper.queryPublishCarouseAdvertisementCount();

        //设置总记录数到Page分页对象中
        page.setTotalsize(totalsize);
        page.setTotalno(totalsize);

        return page;
    }

}
