package com.atguigu.atcrowdfunding.potal.controller;

import com.atguigu.atcrowdfunding.bean.Cert;
import com.atguigu.atcrowdfunding.bean.Member;
import com.atguigu.atcrowdfunding.bean.MemberCert;
import com.atguigu.atcrowdfunding.bean.Ticket;
import com.atguigu.atcrowdfunding.manager.service.CertService;
import com.atguigu.atcrowdfunding.potal.listener.PassListener;
import com.atguigu.atcrowdfunding.potal.listener.RefuseListener;
import com.atguigu.atcrowdfunding.potal.service.MemberService;
import com.atguigu.atcrowdfunding.potal.service.TicketService;
import com.atguigu.atcrowdfunding.util.AjaxResult;
import com.atguigu.atcrowdfunding.util.Const;
import com.atguigu.atcrowdfunding.vo.Data;
import org.activiti.engine.RepositoryService;
import org.activiti.engine.RuntimeService;
import org.activiti.engine.TaskService;
import org.activiti.engine.repository.ProcessDefinition;
import org.activiti.engine.runtime.ProcessInstance;
import org.activiti.engine.task.Task;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpSession;
import java.io.File;
import java.util.*;

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

    @Autowired
    private RepositoryService repositoryService;

    @Autowired
    private RuntimeService runtimeService;

    @Autowired
    private TaskService taskService ;

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
                    System.out.println(queryCertByAcctType);
                    return "redirect:/member/uploadCert.htm";
                }else if("uploadcert".equals(pstep)){
                    return "redirect:/member/checkEmail.htm";
                }else if("checkemail".equals(pstep)){

                    return "redirect:/member/checkAuthCode.htm";
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

    //完成发送邮件
    @ResponseBody
    @RequestMapping("/startProcess")
    public Object startProcess( HttpSession session, String email) {
        AjaxResult result = new AjaxResult();
        try {
            // 获取登录会员信息
            Member member = (Member)session.getAttribute("member");
            System.out.println(member.getEmail());
            // 如果用户输入新的邮箱,将旧的邮箱地址替换
            if(!member.getEmail().equals(email)){
                member.setEmail(email);
                //更新邮箱
                memberService.updateEmail(member);
            }

            //启动实名认证流程 - 系统自动发送邮件,生成验证码.验证邮箱地址是否合法(模拟:银行卡是否邮箱).
            ProcessDefinition processDefinition = repositoryService.createProcessDefinitionQuery().processDefinitionKey("auth").singleResult();

            //toEmail
            //authcode
            //loginacct
            //flag  审核实名认证时提供
            //passListener
            //refuseListener
            StringBuilder authcode = new StringBuilder();
            for (int i = 1; i <= 4; i++) {
                authcode.append(new Random().nextInt(10));
            }

            Map<String,Object> variables= new HashMap<String,Object>();
            variables.put("toEmail", email);
            variables.put("authcode", authcode);
            variables.put("loginacct", member.getLoginacct());
            variables.put("passListener", new PassListener());
            variables.put("refuseListener", new RefuseListener());


            //ProcessInstance processInstance = runtimeService.startProcessInstanceByKey("auth");
            ProcessInstance processInstance = runtimeService.startProcessInstanceById(processDefinition.getId(), variables);

            //记录流程步骤:
            Ticket ticket = ticketService.getTicketByMemberId(member.getId()) ;
            ticket.setPstep("checkemail");
            ticket.setPiid(processInstance.getId());
            ticket.setAuthcode(authcode.toString());
            //更新流程id和状态
            ticketService.updatePiidAndPstep(ticket);

            result.setSuccess(true);
        } catch( Exception e ) {
            e.printStackTrace();
            result.setSuccess(false);
        }

        return result;

    }

    //去到验证验证码页面
    @RequestMapping("/checkAuthCode")
    public String checkAuthCode(){
        return "member/checkAuthCode";
    }

    //完成实名认证申请
    @ResponseBody
    @RequestMapping("/finishApply")
    public Object finishApply( HttpSession session, String authcode) {
        AjaxResult result = new AjaxResult();

        try {

            // 获取登录会员信息
            Member loginMember = (Member)session.getAttribute(Const.LOGIN_MEMBER);


            //让当前系统用户完成:验证码审核任务.
            Ticket ticket = ticketService.getTicketByMemberId(loginMember.getId()) ;
            if(ticket.getAuthcode().equals(authcode)){
                //完成审核验证码任务
                Task task = taskService.createTaskQuery().processInstanceId(ticket.getPiid()).taskAssignee(loginMember.getLoginacct()).singleResult();
                taskService.complete(task.getId());

                //更新用户申请状态
                loginMember.setAuthstatus("1");
                memberService.updateAuthStatus(loginMember);

                //记录流程步骤:
                ticket.setPstep("finishapply");
                ticketService.updatePstep(ticket);
                result.setSuccess(true);
            }else{
                result.setSuccess(false);
                result.setMessage("验证码不正确,请重新输入!");
            }
        } catch( Exception e ) {
            e.printStackTrace();
            result.setSuccess(false);
        }

        return result;

    }

}






















