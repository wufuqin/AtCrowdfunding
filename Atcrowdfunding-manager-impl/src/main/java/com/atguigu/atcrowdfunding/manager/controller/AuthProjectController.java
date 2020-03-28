package com.atguigu.atcrowdfunding.manager.controller;

import com.atguigu.atcrowdfunding.manager.service.AuthProjectService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * 项目审核的的web控制器
 */
@Controller
@RequestMapping("/authProject")
public class AuthProjectController {

    @Autowired
    private AuthProjectService authProjectService;

    //去到项目审核首页面
    @RequestMapping("index")
    public String index(){
        return "authProject/index";
    }



}


























