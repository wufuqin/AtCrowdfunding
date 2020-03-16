package com.atguigu.atcrowdfunding.manager.controller;

import com.atguigu.atcrowdfunding.util.AjaxResult;
import com.atguigu.atcrowdfunding.util.Page;
import org.activiti.engine.RepositoryService;
import org.activiti.engine.repository.ProcessDefinition;
import org.activiti.engine.repository.ProcessDefinitionQuery;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 业务管理
 *      流程管理web控制器
 */
@Controller
@RequestMapping("/process")
public class ProcessController {

    //注入activiti流程框架的service
    @Autowired
    private RepositoryService repositoryService;

    //去到流程管理主页面
    @RequestMapping("/index")
    public String index(){
        return "process/index";
    }

    //查询数据
    @ResponseBody
    @RequestMapping("doIndex")
    public Object doIndex(@RequestParam(value = "pageno", required = false, defaultValue = "1") Integer pageno, @RequestParam(value = "pagesize", required = false, defaultValue = "8") Integer pagesize){
        //创建一个用于存储查询得到的数据集对象
        AjaxResult result = new AjaxResult();
        try {
            //创建一个分页对象
            Page page = new Page(pageno,pagesize);
            //调用流程查询方法
            ProcessDefinitionQuery processDefinitionQuery = repositoryService.createProcessDefinitionQuery();
            //查询流程定义集合数据,可能出现了自关联,导致Jackson组件无法将集合序列化为JSON串.
            List<ProcessDefinition> listPage = processDefinitionQuery.listPage(page.getStartIndex(), pagesize);
            //将数据先存储到map集合中，在存储到list集合中
            List<Map<String,Object>> mylistPage = new ArrayList<Map<String,Object>>();
            //将查询查询到的数据存储到map中
            for (ProcessDefinition processDefinition : listPage) {
                Map<String,Object> pd = new HashMap<String,Object>();
                pd.put("id", processDefinition.getId());
                pd.put("name", processDefinition.getName());
                pd.put("key", processDefinition.getKey());
                pd.put("version", processDefinition.getVersion());
                //将数据存储到list中
                mylistPage.add(pd);
            }
            //计算总的记录数
            Long totalsize = processDefinitionQuery.count();
            //设置分页数据的当前页数据
            page.setDatas(mylistPage);
            //设置分页数据的
            page.setTotalsize(totalsize.intValue());
            result.setPage(page);
            result.setSuccess(true);
        } catch (Exception e) {
            result.setSuccess(false);
            result.setMessage("查询流程定义失败!");
            e.printStackTrace();
        }
        return result;
    }

    //上流程定义文件
    @ResponseBody
    @RequestMapping("/deploy")
    public Object deploy(HttpServletRequest request){
        AjaxResult result = new AjaxResult();
        try {
            MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest)request;
            MultipartFile multipartFile  = multipartHttpServletRequest.getFile("processDefFile");
            repositoryService.createDeployment()
                    .addInputStream(multipartFile
                    .getOriginalFilename(), multipartFile.getInputStream())
                    .deploy();

            result.setSuccess(true);
        } catch (Exception e) {
            result.setSuccess(false);
            result.setMessage("部署流程定义失败!");
            e.printStackTrace();
        }
        return result;
    }

    //删除流程定义
    @ResponseBody
    @RequestMapping("/doDelete")
    public Object doDelete(String id){	 //流程定义id
        AjaxResult result = new AjaxResult();
        try {
            ProcessDefinition processDefinition = repositoryService.createProcessDefinitionQuery().processDefinitionId(id).singleResult();
            repositoryService.deleteDeployment(processDefinition.getDeploymentId(), true);//true表示级联删除.
            result.setSuccess(true);
        } catch (Exception e) {
            result.setSuccess(false);
            result.setMessage("删除流程定义失败!");
            e.printStackTrace();
        }
        return result;
    }

    //批量删除流程定义
    @ResponseBody
    @RequestMapping("/doDeleteBatch")
    public Object doDeleteBatch(String[] id){	 //流程定义id
        AjaxResult result = new AjaxResult();
       try {
           for (String ids: id) {
               ProcessDefinition processDefinition = repositoryService.createProcessDefinitionQuery().processDefinitionId(ids).singleResult();
               repositoryService.deleteDeployment(processDefinition.getDeploymentId(), true);//true表示级联删除.
               result.setSuccess(true);
           }
        } catch (Exception e) {
           result.setSuccess(false);
           result.setMessage("删除流程定义失败!");
           e.printStackTrace();
        }
        return result;
    }














}














