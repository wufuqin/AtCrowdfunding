package com.atguigu.atcrowdfunding.potal.controller;

import com.atguigu.atcrowdfunding.bean.Member;
import com.atguigu.atcrowdfunding.bean.Project;
import com.atguigu.atcrowdfunding.potal.service.MemberService;
import com.atguigu.atcrowdfunding.potal.service.PotalProjectService;
import com.atguigu.atcrowdfunding.util.AjaxResult;
import com.atguigu.atcrowdfunding.util.Const;
import org.aspectj.weaver.AjAttribute;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.Map;

/**
 * 前台项目的web控制器
 */
@Controller
@RequestMapping("/potalProject")
public class PotalProjectController {

    @Autowired
    private PotalProjectService potalProjectService;

    @Autowired
    private MemberService memberService;

    //去到查看项目详情页面
    @RequestMapping("/index")
    public String index(Integer id, Integer memberid, Map<String, Object> map, HttpSession session){
        //对当前项目的数据进行回显
        Project potalProject = potalProjectService.queryPotalProjectInfoById(id); //根据id查询项目信息
        Member companyMember = memberService.getMemberById(memberid); //根据id查询会员信息
        map.put("potalProject", potalProject);
        map.put("companyMember",companyMember);

        session.setAttribute("portalProject",potalProject); //将当前的项目信息存入session
        session.setAttribute("companyMember",companyMember); //将当前的商户会员信息存入session

        return "potalProject/index";
    }

    //检查用户是否登录
    @ResponseBody
    @RequestMapping("/checkMemberLoginStatus")
    public Object checkMemberLoginStatus(HttpSession session){
        AjaxResult result = new AjaxResult();
        Member member = (Member) session.getAttribute(Const.LOGIN_MEMBER);
        try {
            //判断当前用户是否已经登录
            if ("".equals(session.getAttribute(Const.LOGIN_MEMBER))){
                result.setMessage("您还没有登录，请先登录");
                result.setSuccess(false);
            }
            if (!"".equals(session.getAttribute(Const.LOGIN_MEMBER))){
                result.setSuccess(true);
            }

        } catch (Exception e) {
            result.setMessage("支持失败");
            result.setSuccess(false);
            e.printStackTrace();
        }
        return result;
    }

    //去到确认回报页面
    @RequestMapping("/toReport")
    public String toReport(Map<String, Object> map, HttpSession session){
        //获取session中的项目信息
        Project portalProject = (Project) session.getAttribute("portalProject");
        //获取session中的项目信息
        Member member = (Member) session.getAttribute("companyMember");

        //对当前项目的数据进行回显
        Project potalProject = potalProjectService.queryPotalProjectInfoById(portalProject.getId()); //根据id查询项目信息
        Member companyMember = memberService.getMemberById(member.getId()); //根据id查询会员信息
        map.put("potalProject", potalProject);
        map.put("companyMember",companyMember);
        return "potalProject/report";
    }

    //去到确认地址页面
    @RequestMapping("/toMemberAddress")
    public String memberAddress(HttpSession session, Map<String, Object> map){
        //获取当前登录用户
        Member loginMember = (Member) session.getAttribute(Const.LOGIN_MEMBER);
        Member memberInfo = memberService.getMemberById(loginMember.getId()); //根据id查询会员信息
        map.put("memberInfo",memberInfo);

        return "potalProject/memberAddress";
    }

    //提交会员填写的收货地址信息
    @ResponseBody
    @RequestMapping("/doMemberAddress")
    public Object doMemberAddress(Member member){
        AjaxResult result = new AjaxResult();
        try {
            //更新会员收货地址信息
            memberService.updateMemberAddressInfoById(member);
            result.setSuccess(true);
        }catch (Exception e){
            result.setMessage("更新失败");
            result.setSuccess(false);
            e.printStackTrace();
        }
        return result;
    }

    //生成订单并且去到订单页面
    @RequestMapping("/toOrder")
    public String toOrder(Map<String, Object> map, HttpSession session){
        try {

            //获取session中的项目信息
            Project portalProject = (Project) session.getAttribute("portalProject");
            //获取session中的项目信息
            Member member = (Member) session.getAttribute("companyMember");

            //对当前项目的数据进行回显
            Project potalProject = potalProjectService.queryPotalProjectInfoById(portalProject.getId()); //根据id查询项目信息
            Member companyMember = memberService.getMemberById(member.getId()); //根据id查询会员信息

            map.put("potalProject", potalProject);
            map.put("companyMember",companyMember);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "potalProject/order";
    }




}






















