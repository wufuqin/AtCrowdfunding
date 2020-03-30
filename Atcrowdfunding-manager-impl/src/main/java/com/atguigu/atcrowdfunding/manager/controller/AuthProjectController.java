package com.atguigu.atcrowdfunding.manager.controller;

import com.atguigu.atcrowdfunding.bean.Project;
import com.atguigu.atcrowdfunding.manager.service.AuthProjectService;
import com.atguigu.atcrowdfunding.manager.service.ProjectService;
import com.atguigu.atcrowdfunding.util.AjaxResult;
import com.atguigu.atcrowdfunding.util.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Map;

/**
 * 项目审核的的web控制器
 */
@Controller
@RequestMapping("/authProject")
public class AuthProjectController {

    @Autowired
    private AuthProjectService authProjectService;

    @Autowired
    private ProjectService projectService;

    //去到项目审核首页面
    @RequestMapping("index")
    public String index(){
        return "authProject/index";
    }

    //查询数据
    @ResponseBody
    @RequestMapping("doIndex")
    public Object doIndex(@RequestParam(value = "pageno", required = false, defaultValue = "1") Integer pageno, @RequestParam(value = "pagesize", required = false, defaultValue = "8") Integer pagesize){
        //创建一个用于存储查询得到的数据集对象
        AjaxResult result = new AjaxResult();
        try {
            //调用service层查询方法，返回一个分页数据对象
            Page page = authProjectService.queryPageAuthProject(pageno, pagesize);
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

    //去到审核项目页面
    @RequestMapping("/show")
    public String show(Integer id, Map<String,Object> map){
        //查询项目数据进行回显
        Project project = projectService.queryProjectById(id);
        map.put("project",project);
        return "authProject/show";
    }

    //通过申请
    @ResponseBody
    @RequestMapping("passProject")
    public Object passProject(Integer id){
        //创建一个用于存储查询得到的数据集对象
        AjaxResult result = new AjaxResult();
        try {
            //调用service层的方法将项目状态设置为 status:1 审核完成
            projectService.updateProjectStatusByIdPass(id);
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
    @RequestMapping("refuseProject")
    public Object refuseProject(Integer id){
        //创建一个用于存储查询得到的数据集对象
        AjaxResult result = new AjaxResult();
        try {
            //调用service层的方法将项目状态设置为 status5 拒绝申请
            projectService.updateProjectStatusByIdRefuse(id);
            result.setSuccess(true);
        } catch (Exception e) {
            result.setSuccess(false);
            result.setMessage("操作失败...");
            e.printStackTrace();
        }
        return result;
    }

}


























