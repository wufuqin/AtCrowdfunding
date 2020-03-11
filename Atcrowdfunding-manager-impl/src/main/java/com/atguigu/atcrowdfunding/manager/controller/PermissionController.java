package com.atguigu.atcrowdfunding.manager.controller;

import com.atguigu.atcrowdfunding.manager.service.PermissionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * 许可维护的web控制器
 */
@Controller
@RequestMapping("/permission")
public class PermissionController {

    @Autowired
    private PermissionService permissionService;

    //去到许可维护主页面
    @RequestMapping("/index")
    public String index(){
        return "permission/index";
    }

}























