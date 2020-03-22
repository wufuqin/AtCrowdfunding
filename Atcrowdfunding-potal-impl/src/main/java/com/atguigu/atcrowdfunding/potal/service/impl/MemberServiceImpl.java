package com.atguigu.atcrowdfunding.potal.service.impl;

import com.atguigu.atcrowdfunding.bean.Member;
import com.atguigu.atcrowdfunding.exception.LoginFailException;
import com.atguigu.atcrowdfunding.potal.dao.MemberMapper;
import com.atguigu.atcrowdfunding.potal.service.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
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

    //更新邮箱
    @Override
    public void updateEmail(Member loginMember) {
        memberMapper.updateEmail(loginMember);
    }

    //更新用户申请状态
    @Override
    public void updateAuthStatus(Member loginMember) {
        memberMapper.updateAuthStatus(loginMember);
    }

    //根据会员id查询会员信息
    @Override
    public Member getMemberById(Integer memberid) {
        return memberMapper.getMemberById(memberid);
    }

    //查询会员资质信息
    @Override
    public List<Map<String, Object>> queryCertByMemberId(Integer memberid) {
        return memberMapper.queryCertByMemberId(memberid);
    }



}





























