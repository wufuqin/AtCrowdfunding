package com.atguigu.atcrowdfunding.potal.service.impl;

import com.atguigu.atcrowdfunding.bean.Member;
import com.atguigu.atcrowdfunding.exception.LoginFailException;
import com.atguigu.atcrowdfunding.potal.dao.MemberMapper;
import com.atguigu.atcrowdfunding.potal.service.MemberService;
import com.atguigu.atcrowdfunding.util.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
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

    //保存会员
    @Override
    public void saveMember(Member member) {
        memberMapper.insert(member);
    }

    //修改会员信息
    @Override
    public int updateMember(Member member) {
        memberMapper.updateByPrimaryKey(member);
        return 0;
    }

    //调用service层查询方法，返回一个分页数据对象
    @Override
    public Page queryMemberPage(Integer pageno, Integer pagesize) {
        //创建一个分页对象，将查询的对应分页信息传入
        Page page = new Page(pageno, pagesize);

        //获取索引
        Integer startIndex = page.getStartIndex();

        //获取查询出来的分页数据
        List datas = memberMapper.queryMemberList(startIndex,pagesize);

        //设置分页数据到Page分页对象中
        page.setDatas(datas);

        //查询总的记录条数
        Integer totalsize = memberMapper.queryMemberCount();

        //设置总记录数到Page分页对象中
        page.setTotalsize(totalsize);
        page.setTotalno(totalsize);

        return page;
    }

    //调用service层查询方法，返回一个分页数据对象
    @Override
    public Page queryMemberPage(HashMap<String, Object> paramMap) {
        //创建一个分页对象，将查询的对应分页信息传入
        Page page = new Page((Integer) paramMap.get("pageno"), (Integer) paramMap.get("pagesize"));

        //获取索引
        Integer startIndex = page.getStartIndex();
        //将索引信息存入map集合
        paramMap.put("startIndex",startIndex);

        //获取查询出来的分页数据
        List datas = memberMapper.queryMemberListLike(paramMap);

        //设置分页数据到Page分页对象中
        page.setDatas(datas);

        //查询总的记录条数
        Integer totalsize = memberMapper.queryMemberCountLike(paramMap);

        //设置总记录数到Page分页对象中
        page.setTotalsize(totalsize);
        page.setTotalno(totalsize);

        return page;
    }

    //删除会员
    @Override
    public int deleteMember(Integer id) {
        return memberMapper.deleteByPrimaryKey(id);
    }

    //批量删除会员
    @Override
    public int deleteBatchMember(Integer[] ids) {
        int totalCount = 0;
        //计算实际删除的记录数
        for (Integer id : ids) {
            memberMapper.deleteByPrimaryKey(id);
            totalCount += 1;
        }
        //实际删除记录数与计划删除记录数比较
        if (totalCount != ids.length){
            throw new  RuntimeException("批量删除数据失败");
        }
        return totalCount;
    }


}





























