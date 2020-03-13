/*
package com.atguigu.atcrowdfunding.util;

import com.aliyuncs.CommonRequest;
import com.aliyuncs.CommonResponse;
import com.aliyuncs.DefaultAcsClient;
import com.aliyuncs.IAcsClient;
import com.aliyuncs.exceptions.ClientException;
import com.aliyuncs.exceptions.ServerException;
import com.aliyuncs.http.MethodType;
import com.aliyuncs.profile.DefaultProfile;

*/
/**
 * 阿里云短信发送工具类
 *
 *//*

public class SendSms {
    //public static void sendMsg () {
    public static void main(String[] args) {

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
        request.putQueryParameter("PhoneNumbers", "18377548732");
        request.putQueryParameter("SignName", "田间的代码");
        request.putQueryParameter("TemplateCode", "SMS_185840421");
        request.putQueryParameter("TemplateParam", "{\"code\":123456}");
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
*/
