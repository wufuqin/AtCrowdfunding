package com.atguigu.atcrowdfunding.potal.service;

import com.atguigu.atcrowdfunding.bean.Member;

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
}




















