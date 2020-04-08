package com.atguigu.atcrowdfunding.potal.controller;

import com.atguigu.atcrowdfunding.bean.Member;
import com.atguigu.atcrowdfunding.bean.Project;
import com.atguigu.atcrowdfunding.potal.service.MemberService;
import com.atguigu.atcrowdfunding.potal.service.PotalProjectService;
import com.atguigu.atcrowdfunding.util.AjaxResult;
import com.atguigu.atcrowdfunding.util.Const;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Repository;
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
    public String index(Integer id, Integer memberid, Map<String, Object> map){
        //对当前项目的数据进行回显
        Project potalProject = potalProjectService.queryPotalProjectInfoById(id); //根据id查询项目信息
        Member member = memberService.getMemberById(memberid); //根据id查询会员信息

        map.put("potalProject", potalProject);
        map.put("member",member);

        return "potalProject/index";
    }

    //去到确认回报页面
    @RequestMapping("/toReport")
    public String toReport(Integer id, Integer memberid, Map<String, Object> map){
        //对当前项目的数据进行回显
        Project potalProject = potalProjectService.queryPotalProjectInfoById(id); //根据id查询项目信息
        Member member = memberService.getMemberById(memberid); //根据id查询会员信息
        map.put("potalProject", potalProject);
        map.put("member",member);
        return "potalProject/report";
    }

    //去到确认回报页面
    @ResponseBody
    @RequestMapping("/checkMemberLoginStatus")
    public Object checkMemberLoginStatus(HttpSession session){
        AjaxResult result = new AjaxResult();
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

    //去到订单页面
    @RequestMapping("/toOrder")
    public String toOrder(){
        return "potalProject/order";
    }




}






















