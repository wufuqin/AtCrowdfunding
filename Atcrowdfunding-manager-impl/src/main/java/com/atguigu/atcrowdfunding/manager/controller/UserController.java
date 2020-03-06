package com.atguigu.atcrowdfunding.manager.controller;

import com.atguigu.atcrowdfunding.manager.service.UserService;
import com.atguigu.atcrowdfunding.util.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.Map;

/**
 * 用户角色维护模块的controller
 */
@Controller
@RequestMapping("/user")
public class UserController {

    @Autowired
    private UserService userService;

    /**
     * 去到用户维护模块页面，并且查询出用户数据
     * @param pageno    当前页数
     * @param pagesize  每页显示的数据条数
     * @param map       存储分页数据，返回前台
     * @return
     */
    @RequestMapping("index")
    public String index(@RequestParam(value = "pageno", required = false, defaultValue = "1") Integer pageno, @RequestParam(value = "pagesize", required = false, defaultValue = "10") Integer pagesize, Map map){

        //调用service层查询方法，返回一个分页数据对象
        Page page = userService.queryPage(pageno, pagesize);

        //将分页数据放入map集合中，方便前台页面获取，springMVC框架会自动将map集合封装到域对象中
        map.put("page",page);

        return "user/index";
    }


}


















