package com.atguigu.atcrowdfunding.util;

import com.aliyuncs.CommonRequest;
import com.aliyuncs.CommonResponse;
import com.aliyuncs.DefaultAcsClient;
import com.aliyuncs.IAcsClient;
import com.aliyuncs.exceptions.ClientException;
import com.aliyuncs.exceptions.ServerException;
import com.aliyuncs.http.MethodType;
import com.aliyuncs.profile.DefaultProfile;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 生成6位随机数,并且获得前台填写的数据好，发送短信
 */
@WebServlet("/CheckCode")
public class CheckCode extends HttpServlet {

    //生成6位验证码并且存储session域中，接收前台传回的手机号，
    @Override
    public void service(HttpServletRequest request, HttpServletResponse response) {
        //生成随机验证码
        String str = "";
        for (int i = 0; i < 6; i++){
            str += (int)Math.floor(Math.random()*10);
        }
        //将生成的验证码存入session中
        request.getSession().setAttribute("CODE",str);

        //获取前台传回来手机号码
        String phone = request.getParameter("phone");
        //发送短信
        sendMsg(phone,str);
    }

    //实现短信发送工具类
    private void sendMsg(String phone, String str){
        //定义两个字符串,相当于短信发送服务的账号和密码
        String accessKeyId = "LTAI4Fh9j6rH7F9Ndxr1i5FZ";
        String accessSecret = "tUgOPL5WkjtJS0w7Y2DDSIUKQdCcJA";

        DefaultProfile profile = DefaultProfile.getProfile("cn-hangzhou", accessKeyId, accessSecret);
        IAcsClient client = new DefaultAcsClient(profile);

        CommonRequest request = new CommonRequest();
        request.setSysMethod(MethodType.POST);
        request.setSysDomain("dysmsapi.aliyuncs.com");
        request.setSysVersion("2017-05-25");
        request.setSysAction("SendSms");
        request.putQueryParameter("RegionId", "cn-hangzhou");
        request.putQueryParameter("PhoneNumbers", phone);
        request.putQueryParameter("SignName", "田间的代码");
        request.putQueryParameter("TemplateCode", "SMS_185840421");
        request.putQueryParameter("TemplateParam", "{\"code\":'"+str+"'}");
        try {
            CommonResponse response = client.getCommonResponse(request);
            System.out.println(response.getData());
        } catch (ServerException e) {
            e.printStackTrace();
        } catch (ClientException e) {
            e.printStackTrace();
        }
    }

}


















