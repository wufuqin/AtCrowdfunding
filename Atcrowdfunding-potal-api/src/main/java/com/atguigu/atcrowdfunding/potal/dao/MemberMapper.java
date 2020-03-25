package com.atguigu.atcrowdfunding.potal.dao;

import com.atguigu.atcrowdfunding.bean.Member;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 会员的dao层接口
 */
@Repository
public interface MemberMapper {

    //根据id删除
    int deleteByPrimaryKey(Integer id);

    //添加会员
    int insert(Member record);

    //根据id查询
    Member selectByPrimaryKey(Integer id);

    //查询所有
    List<Member> selectAll();

    //根据id修改
    int updateByPrimaryKey(Member record);

    //处理会员的登录请求
    Member queryMemberLogin(Map<String, Object> paramMap);

    //更新账户类型
    void updateAcctType(Member loginMember);

    //提交填写的基本信息
    void updateBasicInfo(Member loginMember);

    //更新邮箱
    void updateEmail(Member loginMember);

    //更新用户申请状态
    void updateAuthStatus(Member loginMember);

    //根据会员id查询会员信息
    Member getMemberById(Integer memberid);

    //查询会员资质信息
    List<Map<String, Object>> queryCertByMemberId(Integer memberid);

    //获取查询出来的分页数据
    List queryMemberList(@Param("startIndex") Integer startIndex, @Param("pagesize") Integer pagesize);

    //查询总的记录条数
    Integer queryMemberCount();

    //获取查询出来的分页数据
    List queryMemberListLike(HashMap<String, Object> paramMap);

    //查询总的记录条数
    Integer queryMemberCountLike(HashMap<String, Object> paramMap);
}





