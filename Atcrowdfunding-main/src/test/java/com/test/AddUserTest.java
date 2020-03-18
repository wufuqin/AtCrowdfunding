/*
package com.test;

import com.atguigu.atcrowdfunding.bean.User;
import com.atguigu.atcrowdfunding.manager.service.UserService;
import com.atguigu.atcrowdfunding.util.MD5Util;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

*/
/**
 * 往用户表里添加测试数据
 *//*

public class AddUserTest {
    public static void main(String[] args) throws Exception {
        ApplicationContext ioc = new ClassPathXmlApplicationContext("spring/spring*.xml");

        UserService userService = ioc.getBean(UserService.class);


        for (int i = 1; i <= 100; i++) {
            User user = new User();
            user.setLoginacct("test"+i);
            user.setUserpswd(MD5Util.digest("123"));
            user.setUsername("test"+i);
            user.setEmail("test"+i+"@qq.com");
            user.setCreatetime("2020-03-07 11:30:00");
            userService.saveUser(user);
        }

    }
}
















*/
