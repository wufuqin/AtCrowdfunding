package com.atguigu.atcrowdfunding.manager.controller;

import com.atguigu.atcrowdfunding.manager.service.UserService;
import com.atguigu.atcrowdfunding.util.AjaxResult;
import com.atguigu.atcrowdfunding.util.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Map;

/**
 * 用户角色维护模块的controller
 */
@Controller
@RequestMapping("/user")
public class UserController {

    @Autowired
    private UserService userService;

    //异步方式查询用户数据
    /**
     * 去到用户维护模块首页面
     */
    @RequestMapping("/index")
    public String index(){
        return "user/index";
    }

    //异步请求
    /**
     * 查询用户数据
     * @param pageno    当前页数
     * @param pagesize  每页显示的数据条数
     */
    @ResponseBody
    @RequestMapping("doIndex")
    public Object index(@RequestParam(value = "pageno", required = false, defaultValue = "1") Integer pageno, @RequestParam(value = "pagesize", required = false, defaultValue = "5") Integer pagesize){

        //创建一个用于存储查询得到的数据集对象
        AjaxResult result = new AjaxResult();
        try {
            //调用service层查询方法，返回一个分页数据对象
            Page page = userService.queryPage(pageno, pagesize);
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


    //同步请求方式,查询用户数据
    /*
     *
     * 去到用户维护模块页面，并且查询出用户数据
     * @param pageno    当前页数
     * @param pagesize  每页显示的数据条数
     * @param map       存储分页数据，返回前台
     * @return
     */
    /*@RequestMapping("index")
    public String index(@RequestParam(value = "pageno", required = false, defaultValue = "1") Integer pageno, @RequestParam(value = "pagesize", required = false, defaultValue = "5") Integer pagesize, Map map){

        //调用service层查询方法，返回一个分页数据对象
        Page page = userService.queryPage(pageno, pagesize);

        //将分页数据放入map集合中，方便前台页面获取，springMVC框架会自动将map集合封装到域对象中
        map.put("page",page);

        return "user/index";
    }
*/

}


















