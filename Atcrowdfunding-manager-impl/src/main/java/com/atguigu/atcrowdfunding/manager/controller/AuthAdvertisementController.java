package com.atguigu.atcrowdfunding.manager.controller;

import com.atguigu.atcrowdfunding.manager.service.AuthAdvertisementService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * 广告审核的web控制器
 */
@Controller
@RequestMapping("/authAdvertisement")
public class AuthAdvertisementController {

    @Autowired
    private AuthAdvertisementService authAdvertisementService;

    //去到广告审核页面
    @RequestMapping("index")
    public String index(){
        return "authAdvertisement/index";
    }


}

















