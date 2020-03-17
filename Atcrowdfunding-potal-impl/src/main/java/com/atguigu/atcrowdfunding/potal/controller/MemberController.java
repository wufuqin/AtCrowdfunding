package com.atguigu.atcrowdfunding.potal.controller;

import com.atguigu.atcrowdfunding.potal.service.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * 会员的web控制器
 */
@Controller
@RequestMapping("/member")
public class MemberController {

    @Autowired
    private MemberService memberService;

    //去到实名认证账户类型选择页面
    @RequestMapping("/acctType")
    public String acctType(){
        return "member/acctType";
    }

}






















