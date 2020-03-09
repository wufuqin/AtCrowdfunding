package com.atguigu.atcrowdfunding.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import com.atguigu.atcrowdfunding.util.AjaxResult;
import com.atguigu.atcrowdfunding.util.MD5Util;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
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

    //去到后台主页面
    @RequestMapping("/main")
    public String main(){
        return "main";
    }

    //去到忘记密码页面
    @RequestMapping("/forget")
    public String forget(){
        return "forget/forget";
    }

    //注销功能（退出系统）
    /**
     * 注销功能（退出系统）
     * @return 重定向到系统主页面
     */
    @RequestMapping("/logout")
    public String logout(HttpSession session){
        session.invalidate();  //销毁session或者清理session域
        return "redirect:index.htm";  //使用重定向方法，封装用户写法提交请求
    }

    //登录异步请求方式
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

            //将查询到的用户数据封装到map集合中
            User user = userService.queryUserLogin(paramMap);
            session.setAttribute(Const.LOGIN_USER, user);
            result.setSuccess(true);
        } catch (Exception e) {
            e.printStackTrace();
            result.setMessage("登录失败，请检查用户名和密码！");
            result.setSuccess(false);
        }
        return result;
    }


}





















