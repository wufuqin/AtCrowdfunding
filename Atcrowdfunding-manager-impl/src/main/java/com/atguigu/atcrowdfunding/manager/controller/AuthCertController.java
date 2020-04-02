package com.atguigu.atcrowdfunding.manager.controller;

import com.atguigu.atcrowdfunding.bean.Member;
import com.atguigu.atcrowdfunding.potal.service.MemberService;
import com.atguigu.atcrowdfunding.potal.service.TicketService;
import com.atguigu.atcrowdfunding.util.AjaxResult;
import com.atguigu.atcrowdfunding.util.Page;
import org.activiti.engine.RepositoryService;
import org.activiti.engine.TaskService;
import org.activiti.engine.repository.ProcessDefinition;
import org.activiti.engine.task.Task;
import org.activiti.engine.task.TaskQuery;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 实名审核的web控制器
 */
@Controller
@RequestMapping("/authCert")
public class AuthCertController {
    @Autowired
    private TicketService ticketService;

    @Autowired
    private TaskService taskService ;

    @Autowired
    private RepositoryService repositoryService ;

    @Autowired
    private MemberService memberService;

    //去到实名认证首页面
    @RequestMapping("/index")
    public String index(){
        return "authCert/index";
    }

    //查询数据
    @ResponseBody
    @RequestMapping("/doIndex")
    public Object doIndex(@RequestParam(value="pageno",required=false,defaultValue="1") Integer pageno, @RequestParam(value="pagesize",required=false,defaultValue="8") Integer pagesize){
        AjaxResult result = new AjaxResult();
        try {
            Page page = new Page(pageno,pagesize);
            //1.查询后台backuser委托组的任务
            TaskQuery taskQuery = taskService.createTaskQuery().processDefinitionKey("auth")
                    .taskCandidateGroup("backuser");
            List<Task> listPage = taskQuery
                    .listPage(page.getStartIndex(), pagesize);
            List<Map<String,Object>> data = new ArrayList<Map<String,Object>>();

            for (Task task : listPage) {
                Map<String,Object> map = new HashMap<String,Object>();
                map.put("taskid", task.getId());
                map.put("taskName", task.getName());

                //2.根据任务查询流程定义(流程定义名称,流程定义版本)
                ProcessDefinition processDefinition = repositoryService
                        .createProcessDefinitionQuery()
                        .processDefinitionId(task.getProcessDefinitionId())
                        .singleResult();

                map.put("procDefName", processDefinition.getName());
                map.put("procDefVersion", processDefinition.getVersion());

                //3.根据任务查询流程实例(根据流程实例的id查询流程单,查询用户信息)
                Member member = ticketService.getMemberByPiId(task.getProcessInstanceId());
                map.put("member",member);
                data.add(map);
            }

            page.setDatas(data);

            Long count = taskQuery.count();
            page.setTotalsize(count.intValue());

            result.setPage(page);

            result.setSuccess(true);
        } catch (Exception e) {
            result.setSuccess(false);
            result.setMessage("任务查询列表失败!");
            e.printStackTrace();
        }

        return result;
    }

/*    //模糊查询
    @ResponseBody
    @RequestMapping("/AuthCertLike")
    public Object AuthCertLike(@RequestParam(value="pageno",required=false,defaultValue="1") Integer pageno, @RequestParam(value="pagesize",required=false,defaultValue="8") Integer pagesize, String queryText){
        AjaxResult result = new AjaxResult();

        try {

            Page page = new Page(pageno,pagesize);

            //1.查询后台backuser委托组的任务
            TaskQuery taskQuery = taskService.createTaskQuery().processDefinitionKey("auth")
                    .taskCandidateGroup("backuser");
            List<Task> listPage = taskQuery
                    .listPage(page.getStartIndex(), pagesize);

            List<Map<String,Object>> data = new ArrayList<Map<String,Object>>();

            for (Task task : listPage) {
                Map<String,Object> map = new HashMap<String,Object>();
                map.put("taskid", task.getId());
                map.put("taskName", task.getName());

                //2.根据任务查询流程定义(流程定义名称,流程定义版本)
                ProcessDefinition processDefinition = repositoryService
                        .createProcessDefinitionQuery()
                        //.processDefinitionNameLike("%" + queryText + "%")
                        .processDefinitionId(task.getProcessDefinitionId())
                        .singleResult();

                map.put("procDefName", processDefinition.getName());
                map.put("procDefVersion", processDefinition.getVersion());


                //3.根据任务查询流程实例(根据流程实例的id查询流程单,查询用户信息)
                Member member = ticketService.getMemberByPiId(task.getProcessInstanceId());


                map.put("member",member);

                data.add(map);

            }

            page.setDatas(data);

            Long count = taskQuery.count();
            page.setTotalsize(count.intValue());

            result.setPage(page);

            result.setSuccess(true);
        } catch (Exception e) {
            result.setSuccess(false);
            result.setMessage("任务查询列表失败!");
            e.printStackTrace();
        }

        return result;
    }*/


    //跳转到显示资料页面，并且显示会员信息
    @RequestMapping("/show")
    public String show(Integer memberid,Map<String,Object> map){

        //根据会员id查询会员信息
        Member member = memberService.getMemberById(memberid);

        //查询会员资质信息
        List<Map<String,Object>> list = memberService.queryCertByMemberId(memberid);

        map.put("member", member);
        map.put("certimgs", list);
        return "authCert/show";
    }

    //通过申请
    @ResponseBody
    @RequestMapping("/pass")
    public Object pass( String taskid, Integer memberid ) {
        AjaxResult result = new AjaxResult();

        try {
            taskService.setVariable(taskid, "flag", true);
            taskService.setVariable(taskid, "memberid", memberid);
            // 传递参数，让流程继续执行
            taskService.complete(taskid);
            result.setSuccess(true);
        } catch ( Exception e ) {
            e.printStackTrace();
            result.setSuccess(false);
        }

        return result;
    }

    //拒绝申请
    @ResponseBody
    @RequestMapping("/refuse")
    public Object refuse(String taskid, Integer memberid) {
        AjaxResult result = new AjaxResult();

        try {
            taskService.setVariable(taskid, "flag", false);
            taskService.setVariable(taskid, "memberid", memberid);
            // 传递参数，让流程继续执行
            taskService.complete(taskid);
            result.setSuccess(true);
        } catch ( Exception e ) {
            e.printStackTrace();
            result.setSuccess(false);
        }

        return result;
    }

}






















