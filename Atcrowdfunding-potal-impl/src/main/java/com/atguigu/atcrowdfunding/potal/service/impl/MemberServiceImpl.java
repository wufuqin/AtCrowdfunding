package com.atguigu.atcrowdfunding.potal.service.impl;

import com.atguigu.atcrowdfunding.bean.Member;
import com.atguigu.atcrowdfunding.exception.LoginFailException;
import com.atguigu.atcrowdfunding.potal.dao.MemberMapper;
import com.atguigu.atcrowdfunding.potal.service.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Map;

/**
 * 会员的service层实现类
 */
@Service
public class MemberServiceImpl implements MemberService {

    @Autowired
    private MemberMapper memberMapper;

    //处理会员的登录请求
    @Override
    public Member queryMemberLogin(Map<String, Object> paramMap) {
        Member member = memberMapper.queryMemberLogin(paramMap);
        //判断用户输入数据是否为空
        if(member==null){
            //抛出异常
            throw new LoginFailException("用户账号或密码不正确!");
        }
        return member;
    }

    //更新账户类型
    @Override
    public void updateAcctType(Member loginMember) {
        memberMapper.updateAcctType(loginMember);
    }

    //提交填写的基本信息
    @Override
    public void updateBasicInfo(Member loginMember) {
        memberMapper.updateBasicInfo(loginMember);
    }


}





























