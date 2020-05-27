package com.atguigu.atcrowdfunding.controller;

import java.text.SimpleDateFormat;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.atguigu.atcrowdfunding.bean.*;
import com.atguigu.atcrowdfunding.potal.service.DrawService;
import com.atguigu.atcrowdfunding.potal.service.MemberService;
import com.atguigu.atcrowdfunding.util.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import com.atguigu.atcrowdfunding.manager.service.UserService;
import org.springframework.web.bind.annotation.RequestParam;
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

    @Autowired
    private DrawService drawService;

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

//============================================================================================================================
    //去到抽签页面
    @RequestMapping("/draw")
    public String draw(){
        return "draw/draw";
    }

    //去到查看抽签信息页面
    @RequestMapping("/showDrawInfo")
    public String showDrawInfo(){
        return "draw/showDrawInfo";
    }

    //完成抽签
    @ResponseBody
    @RequestMapping("/doDraw")
    public synchronized Object doDraw(Draw draw, HttpSession session){
        AjaxResult result = new AjaxResult();

        //设置时间格式
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        //创建一个日期对象
        Date date = new Date();
        String createTime = sdf.format(date);
        draw.setCreateTime(createTime);  //抽签时间

        try {
            //生成抽签号
            /*//int drawId = RandomNumber.rand();
            //查询数据库，判断本次抽签号与学号是否已经存在
            List<String> studentIdList = drawService.queryStudentId(draw.getStudentId()); //学号是否存在
            if (studentIdList.size()>= 1){
                result.setMessage("您已经抽过签了");
                result.setSuccess(false);
                return result;
            }
            List<Integer> drawIdList = drawService.queryDrawId(drawId);         //签号是否存在
            if (drawIdList.size()>= 1){
                result.setMessage("当前签已经被抽走，请重新抽签");
                result.setSuccess(false);
                return result;
            }*/

            //查询数据库中的抽签号
            List<DrawId> drawIdList = drawService.queryDrawIdList();

            //将集合中的第一个数当做抽签号
            Integer drawId = drawIdList.get(0).getDraw();

            //查询数据库，判断本次抽签号与学号是否已经存在
            List<String> studentIdList = drawService.queryStudentId(draw.getStudentId()); //学号是否存在
            if (studentIdList.size()>= 1){
                result.setMessage("您已经抽过签了");
                result.setSuccess(false);
                return result;
            }
            List<Integer> List = drawService.queryDrawId(drawId);         //签号是否存在
            if (List.size()>= 1){
                result.setMessage("当前签已经被抽走，请重新抽签");
                result.setSuccess(false);
                return result;
            }


            draw.setDraw(drawId);
            session.setAttribute("drawId",drawId);
            //添加新的抽签信息
            drawService.AddDrawInfo(draw);
            //删除抽签号表中的对应签号
            drawService.deleteDrawIdInfoByDraw(drawId);

            result.setSuccess(true);
            return result;
        } catch (Exception e) {
            result.setSuccess(false);
            result.setMessage("抽签失败,请重新抽签");
            e.printStackTrace();
            return result;
        }
    }

    //去到抽签成功提示页面
    @RequestMapping("/showDrawId")
    public String showDrawId(HttpSession session, Map<String, Integer> map){
        //取出session中的签号
        int drawId = (Integer) session.getAttribute("drawId");
        map.put("drawId",drawId);

        return "draw/showDrawId";
    }

    //加载完成抽签的数据
    @ResponseBody
    @RequestMapping("drawInfo")
    public Object doIndex(@RequestParam(value = "pageno", required = false, defaultValue = "1") Integer pageno, @RequestParam(value = "pagesize", required = false, defaultValue = "38") Integer pagesize){
        //创建一个用于存储查询得到的数据集对象
        AjaxResult result = new AjaxResult();
        try {
            //调用service层查询方法，返回一个分页数据对象
            Page page = drawService.queryDrawPage(pageno, pagesize);
            //设置查询状态
            result.setSuccess(true);
            //存储查询到的数据
            result.setPage(page);
        } catch (Exception e) {
            result.setSuccess(false);
            result.setMessage("查询数据失败...");
            e.printStackTrace();
        }
        return result;
    }

    //批量删除抽签数据
    @ResponseBody
    @RequestMapping("/doDeleteBatch")
    public Object doDeleteBatch(Integer[] id){
        AjaxResult result = new AjaxResult();
        try {
            int count = drawService.deleteBatchDraw(id);
            result.setSuccess(count == id.length);
        } catch (Exception e) {
            result.setSuccess(false);
            result.setMessage("删除数据失败");
            e.printStackTrace();
        }
        return result;
    }

    //开启新一轮抽签
    @ResponseBody
    @RequestMapping("/newDraw")
    public Object newDraw(){
        AjaxResult result = new AjaxResult();
        DrawId drawId = new DrawId();

        try {
            //删两个表中的全部数据
            drawService.deleteDrawTableInfo();    //删除抽签表中的所有数据
            drawService.deleteDrawIdTableInfo();  //删除抽签号表中的全部数据

            //重新添加数据到抽签号表中
            List<Integer> randList = RandomNumber.rand();  //获得一个1-38的随机数集合
            for (Integer number : randList) {
                //循环添加数据到抽签号表中
                drawId.setDraw(number);
                drawService.addDrawId(drawId);
            }

            result.setSuccess(true);
        } catch (Exception e) {
            result.setSuccess(false);
            result.setMessage("初始化数据失败");
            e.printStackTrace();
        }
        return result;
    }

}



























