package com.atguigu.atcrowdfunding.potal.service;

import com.atguigu.atcrowdfunding.bean.Member;
import com.atguigu.atcrowdfunding.util.Page;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 会员的service层接口
 */
public interface MemberService {

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

    //保存会员
    void saveMember(Member member);

    //修改会员信息
    void updateMember(Member member);

    //调用service层查询方法，返回一个分页数据对象
    Page queryMemberPage(Integer pageno, Integer pagesize);

    //调用service层查询方法，返回一个分页数据对象
    Page queryMemberPage(HashMap<String, Object> paramMap);

    //删除会员
    int deleteMember(Integer id);

    //批量删除会员
    int deleteBatchMember(Integer[] id);

    //根据id查询会员信息
    Member queryMemberById(Integer id);

    //根据id修改会员信息
    void updateMemberById(Member member);

    //根据账号查询会员信息
    Member queryMemberByAcct(String loginacct);

    //修改会员的账号激活状态 status = "Y"
    int updateMemberStatusByLoginacct(String loginacct);

    //更新会员收货地址信息
    void updateMemberAddressInfoById(Member member);
}




















