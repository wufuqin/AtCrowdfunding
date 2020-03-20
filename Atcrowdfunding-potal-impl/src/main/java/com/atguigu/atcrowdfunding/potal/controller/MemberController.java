package com.atguigu.atcrowdfunding.potal.controller;

import com.atguigu.atcrowdfunding.bean.Cert;
import com.atguigu.atcrowdfunding.bean.Member;
import com.atguigu.atcrowdfunding.bean.MemberCert;
import com.atguigu.atcrowdfunding.bean.Ticket;
import com.atguigu.atcrowdfunding.manager.service.CertService;
import com.atguigu.atcrowdfunding.potal.service.MemberService;
import com.atguigu.atcrowdfunding.potal.service.TicketService;
import com.atguigu.atcrowdfunding.util.AjaxResult;
import com.atguigu.atcrowdfunding.util.Const;
import com.atguigu.atcrowdfunding.vo.Data;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpSession;
import java.io.File;
import java.util.List;
import java.util.UUID;

/**
 * 会员的web控制器
 */
@Controller
@RequestMapping("/member")
public class MemberController {

    @Autowired
    private MemberService memberService;

    @Autowired
    private TicketService ticketService;

    @Autowired
    private CertService certService;

    //去到实名认证账户类型选择页面
    @RequestMapping("/acctType")
    public String acctType(){
        return "member/acctType";
    }

    //更新账户类型
    @ResponseBody
    @RequestMapping("/updateAcctType")
    public Object updateAcctType(HttpSession session, String acctType ) {
        AjaxResult result = new AjaxResult();
        try {
            // 获取登录会员信息
            Member loginMember = (Member)session.getAttribute(Const.LOGIN_MEMBER);
            loginMember.setAccttype(acctType);
            // 更新账户类型
            memberService.updateAcctType(loginMember);
            result.setSuccess(true);
        } catch( Exception e ) {
            e.printStackTrace();
            result.setSuccess(false);
        }
        return result;
    }

    //去到填写基本信息页面
    @RequestMapping("/basicInfo")
    public String basicInfo(){
        return "member/basicInfo";
    }

    //判断会员在填写实名认证信息时是否为第一次填写
    @RequestMapping("/apply")
    public String apply(HttpSession session){
        try {
            Member member = (Member)session.getAttribute(Const.LOGIN_MEMBER);
            Ticket ticket = ticketService.getTicketByMemberId(member.getId()) ;
            if(ticket == null ){
                ticket = new Ticket(); //封装数据
                ticket.setMemberid(member.getId());
                ticket.setPstep("apply");
                ticket.setStatus("0");

                ticketService.saveTicket(ticket);
            }else{
                String pstep = ticket.getPstep();
                if("accttype".equals(pstep)){
                    return "redirect:/member/basicInfo.htm";
                } else if("basicinfo".equals(pstep)){
                    //根据当前用户选择的账户类型查询需要上传的资质图片
                    List<Cert> queryCertByAcctType = certService.queryCertByAcctType(member.getAccttype());
                    session.setAttribute("queryCertByAcctType",queryCertByAcctType);
                    return "redirect:/member/uploadCert.htm";
                }else if("uploadcert".equals(pstep)){
                    return "redirect:/member/checkEmail.htm";
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "member/acctType";
    }

    //提交填写的基本信息
    @ResponseBody
    @RequestMapping("/updateBasicInfo")
    public Object updateBasicInfo( HttpSession session, Member member) {
        AjaxResult result = new AjaxResult();
        try {
            // 获取登录会员信息
            Member loginMember = (Member)session.getAttribute(Const.LOGIN_MEMBER);
            loginMember.setRealname(member.getRealname());
            loginMember.setCardnum(member.getCardnum());
            loginMember.setTel(member.getTel());
            // 更新账户类型
            memberService.updateBasicInfo(loginMember);

            //记录流程步骤:
            Ticket ticket = ticketService.getTicketByMemberId(loginMember.getId()) ;
            ticket.setPstep("basicinfo");
            ticketService.updatePstep(ticket);

            result.setSuccess(true);
        } catch( Exception e ) {
            e.printStackTrace();
            result.setSuccess(false);
        }
        return result;
    }

    //去到上传资质图片页面
    @RequestMapping("/uploadCert")
    public String uploadCert(){
        return "member/uploadCert";
    }

    //保存资质数据
    @ResponseBody
    @RequestMapping("/doUploadCert")
    public Object doUploadCert( HttpSession session, Data ds) {
        AjaxResult result = new AjaxResult();
        try {
            // 获取登录会员信息
            Member loginMember = (Member)session.getAttribute(Const.LOGIN_MEMBER);
            String realPath = session.getServletContext().getRealPath("/picture");
            List<MemberCert> certimgs = ds.getCertimgs();
            for (MemberCert memberCert : certimgs) {
                MultipartFile fileImg = memberCert.getFileImg();
                String extName = fileImg.getOriginalFilename().substring(fileImg.getOriginalFilename().lastIndexOf("."));
                String tmpName = UUID.randomUUID().toString() +  extName;
                String filename = realPath + "/cert" +"/" + tmpName;
                fileImg.transferTo(new File(filename));	//资质文件上传
                //准备数据
                memberCert.setIconpath(tmpName); //封装数据,保存数据库
                memberCert.setMemberid(loginMember.getId());
            }
            // 保存会员与资质关系数据.
            certService.saveMemberCert(certimgs);
            //记录流程步骤:
            Ticket ticket = ticketService.getTicketByMemberId(loginMember.getId());
            ticket.setPstep("uploadcert");
            ticketService.updatePstep(ticket);
            result.setSuccess(true);
        } catch( Exception e ) {
            e.printStackTrace();
            result.setSuccess(false);
        }
        return result;

    }

    //去到发送邮件页面
    @RequestMapping("/checkEmail")
    public String checkEmail(){
        return "member/checkEmail";
    }

}






















