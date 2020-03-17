package com.atguigu.atcrowdfunding.potal.service;

import com.atguigu.atcrowdfunding.bean.Member;

import java.util.Map;

/**
 * 会员的service层接口
 */
public interface MemberService {

    //处理会员的登录请求
    Member queryMemberLogin(Map<String, Object> paramMap);

}




















