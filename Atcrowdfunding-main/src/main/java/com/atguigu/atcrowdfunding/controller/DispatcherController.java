package com.atguigu.atcrowdfunding.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.atguigu.atcrowdfunding.bean.Member;
import com.atguigu.atcrowdfunding.bean.Permission;
import com.atguigu.atcrowdfunding.potal.service.MemberService;
import com.atguigu.atcrowdfunding.util.AjaxResult;
import com.atguigu.atcrowdfunding.util.MD5Util;
import com.atguigu.atcrowdfunding.util.SendEmail;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import com.atguigu.atcrowdfunding.bean.User;
import com.atguigu.atcrowdfunding.manager.service.UserService;
import com.atguigu.atcrowdfunding.util.Const;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * 主web控制器
 */
@Controller
public class DispatcherController {

    //用户的业务层对象，按自动类型注入
    @Autowired
    private UserService userService ;

    @Autowired
    private MemberService memberService;

    //会员登录成功之后的主页面
    @RequestMapping("/afterSuccessfulLoginIndex")
    public String afterSuccessfulLoginIndex(){
        return "afterSuccessfulLoginIndex";
    }

    //去到系统主页面
    @RequestMapping("/index")
    public String index(){
        return "index";
    }

    //去到登录页面
    @RequestMapping("/login")
    public String login(){
        return "login";
    }

    //去到注册页面
    @RequestMapping("/reg")
    public String reg(){
        return "reg";
    }

    //完成注册
    @ResponseBody
    @RequestMapping("/doRge")
    public Object doRge(String tel, String username, String userpswd, String email, String checkCode, String usertype,HttpSession session){
        //请求结果封装对象
        AjaxResult result = new AjaxResult();
        try {
            Member member = new Member();
            //设置会员注册的信息
            member.setTel(tel);
            member.setUsername(username);
            member.setUserpswd(MD5Util.digest(userpswd));
            member.setEmail(email);
            member.setUsertype(usertype);

            //设置会员刚刚注册时的默认信息
            member.setLoginacct(tel);
            member.setAuthstatus(Const.MEMBER_STATUS);

            //从session域中获取程序生成的验证码
            String checkCode_server = (String) session.getAttribute("CODE");
            //判断用户输入的验证码和实际生成的验证码是否一致，不区分大小写
            if(!checkCode_server.equalsIgnoreCase(checkCode)){
            //if(!"abcd".equalsIgnoreCase("abcd")){
                //验证码不正确(抛出异常信息)
                result.setMessage("验证码错误！");
                result.setSuccess(false);
                return result;
            }
            //保存会员
            memberService.saveMember(member);
            String loginacct = member.getLoginacct();

            //给注册用户发送激活邮件链接
            SendEmail.sendEmial(email,"激活账号","<a href='http://"+Const.path+"/activateAccount.do?loginacct="+loginacct+"'>点击激活</a>");
            result.setSuccess(true);
        } catch (Exception e) {
            result.setSuccess(false);
            result.setMessage("注册失败");
            e.printStackTrace();
        }
        return result;
    }

    //去到后台主页面
    @RequestMapping("/main")
    public String main(HttpSession session){

        //从session域中获取当前登录的用户信息
        User user = (User)session.getAttribute(Const.LOGIN_USER);
        //当前用户所拥有的许可权限
        List<Permission> myPermissions = userService.queryPermissionByUserId(user.getId()); //当前用户所拥有的许可权限
        Permission permissionRoot = null;
        Map<Integer,Permission> map = new HashMap<Integer,Permission>();

        //将用户拥有的权限存储到map集合中
        for (Permission innerPermission : myPermissions) {
            map.put(innerPermission.getId(), innerPermission);
        }
        for (Permission permission : myPermissions) {
            //通过子查找父
            Permission child = permission ; //假设为子菜单
            if(child.getPid() == null ){
                permissionRoot = permission;
            }else{
                //父节点
                Permission parent = map.get(child.getPid());
                parent.getChildren().add(child);
            }
        }
        session.setAttribute("permissionRoot", permissionRoot);

        return "main";
    }

    //去到前台页面
    @RequestMapping("/member")
    public String member(){
        return "member/index";
    }

    //注销功能（退出系统）
    /**
     * 注销功能（退出系统）
     * @return 重定向到系统主页面
     */
    @RequestMapping("/logout")
    public String logout(HttpSession session){
        session.invalidate();  //销毁session或者清理session域
        return "redirect:index.htm";  //使用重定向方法，避免用户重复提交请求
    }

    //登录请求
    /**
     * 处理登录请求
     * ResponseBody注解： 结合Jackson组件, 将返回结果转换为字符串.
     * 将JSON串以流的形式返回给客户端.
     *      返回数据格式： {"success":false,"message":"登录失败!"}
     */
    @ResponseBody
    @RequestMapping("/doLogin")
    public Object doLogin(String loginacct,String userpswd, String checkCode, String type,HttpSession session){

        //请求结果封装对象
        AjaxResult result = new AjaxResult();
        try {
            //使用map集合对用户输入的信息进行封装
            Map<String,Object> paramMap = new HashMap<String,Object>();
            paramMap.put("loginacct", loginacct);
            paramMap.put("userpswd", MD5Util.digest(userpswd)); //使用MD5对密码进行加密
            paramMap.put("type", type);

            //从session域中获取程序生成的验证码
            String checkCode_server = (String) session.getAttribute("CHECKCODE_SERVER");
            //销毁验证码，确保验证码一次性
            session.removeAttribute("CHECKCODE_SERVER");
            //判断用户输入的验证码和实际生成的验证码是否一致，不区分大小写
            if(!checkCode_server.equalsIgnoreCase(checkCode)){
                //验证码不正确(抛出异常信息)
                result.setMessage("验证码错误！");
                result.setSuccess(false);
                return result;
            }

            if("member".equals(type)){
                //查询会员用户是否已经激活
                Member memberStatus = memberService.queryMemberLogin(paramMap);
                if (memberStatus.getStatus().equals("N")){
                    result.setMessage("用户没有激活，请先去激活");
                    result.setSuccess(false);
                    return result;
                }

                Member member = memberService.queryMemberLogin(paramMap);
                session.setAttribute(Const.LOGIN_MEMBER, member);
            }
            if ("user".equals(type)){
                //将查询到的用户数据封装到map集合中
                User user = userService.queryUserLogin(paramMap);
                session.setAttribute(Const.LOGIN_USER, user);
            }

            result.setSuccess(true);
        } catch (Exception e) {
            e.printStackTrace();
            result.setMessage("登录失败，请检查用户名和密码！");
            result.setSuccess(false);
        }
        return result;
    }

    //去到忘记密码页面
    @RequestMapping("/forget")
    public String forget(){
        return "forget/forgetPassword";
    }

    //发送重置密码邮件
    @ResponseBody
    @RequestMapping("/restPassword")
    public Object restPassword(String email, String checkCode, HttpSession session){
        AjaxResult result = new AjaxResult();
        try {
            //从session域中获取程序生成的验证码
            String checkCode_server = (String) session.getAttribute("CHECKCODE_SERVER");
            //销毁验证码，确保验证码一次性
            session.removeAttribute("CHECKCODE_SERVER");
            //判断用户输入的验证码和实际生成的验证码是否一致，不区分大小写
            if(!checkCode_server.equalsIgnoreCase(checkCode)){
                //验证码不正确(抛出异常信息)
                result.setMessage("验证码错误！");
                result.setSuccess(false);
                return result;
            }
            //发送邮件
            SendEmail.sendEmial(email,"重置密码","<a href='http://"+Const.path+"/toRestPassword.htm'>重置密码</a>");
            result.setSuccess(true);
        } catch (Exception e) {
            result.setMessage("邮件发送失败");
            e.printStackTrace();
            result.setSuccess(false);
        }
        return result;
    }

    //跳转到自动跳转页面
    @RequestMapping("/time")
    public String time(){
        return "forget/time";
    }

    //点击邮件里重置密码的连接，跳转到重置密码页面
    @RequestMapping("/toRestPassword")
    public String toRestPassword(){
        return "forget/toRestPassword";
    }

    //完成重置密码功能
    @ResponseBody
    @RequestMapping("/doRestPassword")
    public Object doRestPassword(String loginacct, String userpswd, String confirm_password, String checkCode, HttpSession session){
        AjaxResult result = new AjaxResult();
        try {
            //根据账号查询会员信息
            Member member = memberService.queryMemberByAcct(loginacct);
            //判断用户两次输入的密码是否一致
            if (!userpswd.equals(confirm_password)){
                result.setMessage("两次输入的密码不一致");
                result.setSuccess(false);
                return result;
            }
            //从session域中获取程序生成的验证码
            String checkCode_server = (String) session.getAttribute("CHECKCODE_SERVER");
            //销毁验证码，确保验证码一次性
            session.removeAttribute("CHECKCODE_SERVER");
            //判断用户输入的验证码和实际生成的验证码是否一致，不区分大小写
            if(!checkCode_server.equalsIgnoreCase(checkCode)){
                //验证码不正确(抛出异常信息)
                result.setMessage("验证码错误！");
                result.setSuccess(false);
                return result;
            }
            //设置新密码
            member.setUserpswd(MD5Util.digest(userpswd));
            //根据id修改密码
            memberService.updateMemberById(member);
            result.setSuccess(true);
        } catch (Exception e) {
            result.setSuccess(false);
            result.setMessage("重置密码失败");
            e.printStackTrace();
        }
        return result;
    }

    //重置密码成功，自动跳转
    @RequestMapping("/restTime")
    public String restTime(){
        return "forget/restTime";
    }

    //注册成功，自动跳转页面
    @RequestMapping("/regTime")
    public String regTime(){
        return "regTime";
    }

    //激活注册会员账号
    @RequestMapping("/activateAccount")
    public Object activateAccount(String loginacct){
        //修改会员的账号激活状态 status = "Y"
        memberService.updateMemberStatusByLoginacct(loginacct);
        return "activateAccount";
    }

}



























