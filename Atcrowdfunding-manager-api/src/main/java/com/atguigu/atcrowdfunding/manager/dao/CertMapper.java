package com.atguigu.atcrowdfunding.manager.dao;

import com.atguigu.atcrowdfunding.bean.Cert;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;

/**
 * 资质维护的dao层接口
 */
@Repository
public interface CertMapper {

    //根据id删除
    int deleteByPrimaryKey(Integer id);

    //添加数据
    int insert(Cert record);

    //根据id查询
    Cert selectByPrimaryKey(Integer id);

    //查询所有
    List<Cert> selectAll();

    //根据id修改
    int updateByPrimaryKey(Cert record);

    //获取查询出来的分页数据
    //当想mybatis传递多个参数是，需要使用注解指定参数名，否则mybatis不能自动识别
    List queryList(@Param("startIndex") Integer startIndex, @Param("pagesize") Integer pagesize);

    //查询总的记录条数
    Integer queryCount();

    //获取模糊查询分页数据
    List queryListLike(HashMap<String, Object> paramMap);

    //模糊查询总记录数
    Integer queryCountLike(HashMap<String, Object> paramMap);

    //查询出所有的资质
    List<Cert> queryCertAll();
}














