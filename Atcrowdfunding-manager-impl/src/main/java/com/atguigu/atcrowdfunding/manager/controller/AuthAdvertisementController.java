package com.atguigu.atcrowdfunding.manager.controller;

import com.atguigu.atcrowdfunding.bean.Advertisement;
import com.atguigu.atcrowdfunding.manager.service.AdvertisementService;
import com.atguigu.atcrowdfunding.manager.service.AuthAdvertisementService;
import com.atguigu.atcrowdfunding.util.AjaxResult;
import com.atguigu.atcrowdfunding.util.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.Map;

/**
 * 广告审核的web控制器
 */
@Controller
@RequestMapping("/authAdvertisement")
public class AuthAdvertisementController {

    @Autowired
    private AuthAdvertisementService authAdvertisementService;

    @Autowired
    private AdvertisementService advertisementService;

    //去到广告审核页面
    @RequestMapping("index")
    public String index(){
        return "authAdvertisement/index";
    }

    //查询需要审核的广告数据
    @ResponseBody
    @RequestMapping("doIndex")
    public Object doIndex(@RequestParam(value = "pageno", required = false, defaultValue = "1") Integer pageno, @RequestParam(value = "pagesize", required = false, defaultValue = "8") Integer pagesize){
        //创建一个用于存储查询得到的数据集对象
        AjaxResult result = new AjaxResult();
        try {
            //调用service层查询方法，返回一个分页数据对象
            Page page = authAdvertisementService.queryPageAuthAdvertisement(pageno, pagesize);
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

    //模糊查询
    @ResponseBody
    @RequestMapping("doLike")
    public Object doLike(@RequestParam(value = "pageno", required = false, defaultValue = "1") Integer pageno, @RequestParam(value = "pagesize", required = false, defaultValue = "8") Integer pagesize, String queryText){

        //创建一个用于存储查询得到的数据集对象
        AjaxResult result = new AjaxResult();
        try {
            //创建一个map集合
            HashMap<String, Object> paramMap = new HashMap<String, Object>();
            //将查询条件存入map集合
            paramMap.put("pageno",pageno);
            paramMap.put("pagesize",pagesize);
            paramMap.put("queryText",queryText);

            //调用service层查询方法，返回一个分页数据对象
            Page page = authAdvertisementService.queryPageAdvertisementLike(paramMap);
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

    //去到广告审核页面
    @RequestMapping("/show")
    public String show(Integer id, Map map){
        Advertisement advertisement = advertisementService.getAdvertisementById(id);
        map.put("advertisement",advertisement);
        return "authAdvertisement/show";
    }

    //通过申请
    @ResponseBody
    @RequestMapping("passAdvertisement")
    public Object passAdvertisement(Integer id){
        //创建一个用于存储查询得到的数据集对象
        AjaxResult result = new AjaxResult();
        try {
            //调用service层的方法将广告状态设置为 status:2 审核完成
            advertisementService.updateAdvertisementStatusByIdPass(id);
            result.setSuccess(true);
        } catch (Exception e) {
            result.setSuccess(false);
            result.setMessage("操作失败...");
            e.printStackTrace();
        }
        return result;
    }

    //拒绝申请
    @ResponseBody
    @RequestMapping("refuseAdvertisement")
    public Object refuseAdvertisement(Integer id){
        //创建一个用于存储查询得到的数据集对象
        AjaxResult result = new AjaxResult();
        try {
            //调用service层的方法将广告状态设置为 status:2 审核完成
            advertisementService.updateAdvertisementStatusByIdRefuse(id);
            result.setSuccess(true);
        } catch (Exception e) {
            result.setSuccess(false);
            result.setMessage("操作失败...");
            e.printStackTrace();
        }
        return result;
    }

}

















