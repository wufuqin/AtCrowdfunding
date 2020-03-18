package com.atguigu.atcrowdfunding.manager.controller;

import com.atguigu.atcrowdfunding.bean.Cert;
import com.atguigu.atcrowdfunding.manager.service.CertService;
import com.atguigu.atcrowdfunding.manager.service.CertTypeService;
import com.atguigu.atcrowdfunding.util.AjaxResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 资质分类管理web控制器
 */
@Controller
@RequestMapping("certType")
public class CertTypeController {

    @Autowired
    private CertTypeService certTypeService;

    @Autowired
    private CertService certService;

    //去到资质类型首页面
    @RequestMapping("/index")
    public String index(Map<String,Object> map){
        //查询出所有的资质
        List<Cert> allCert = certService.queryCertAll();
        map.put("allCert",allCert);

        //查询资质与账户类型之间的关系（之前给账户类型分配个的资质）
        List<Map<String,Object>> certAcctTypeList = certTypeService.queryCertAcctType();
        map.put("certAcctTypeList",certAcctTypeList);

        return "certType/index";
    }

    //增加账户类型和资质的关系
    @ResponseBody
    @RequestMapping("/insertAcctTypeCert")
    public Object insertAcctTypeCert( Integer certid, String accttype ) {
        AjaxResult result = new AjaxResult();

        try {
            Map<String, Object> paramMap = new HashMap<String, Object>();
            paramMap.put("certid", certid);
            paramMap.put("accttype", accttype);

            int count = certTypeService.insertAcctTypeCert(paramMap);
            result.setSuccess(count==1);
        } catch ( Exception e ) {
            e.printStackTrace();
            result.setSuccess(false);
        }

        return result;
    }

    //删除账户类型和资质的关系
    @ResponseBody
    @RequestMapping("/deleteAcctTypeCert")
    public Object deleteAcctTypeCert( Integer certid, String accttype ) {
        AjaxResult result = new AjaxResult();

        try {
            Map<String, Object> paramMap = new HashMap<String, Object>();
            paramMap.put("certid", certid);
            paramMap.put("accttype", accttype);

            int count = certTypeService.deleteAcctTypeCert(paramMap);
            result.setSuccess(count==1);
        } catch ( Exception e ) {
            e.printStackTrace();
            result.setSuccess(false);
        }

        return result;
    }

}
































