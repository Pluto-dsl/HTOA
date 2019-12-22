package com.wtt.controller;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.norman.service.LoginService;
import com.publics.utills.StringUtill;
import com.publics.vo.empModel.emp.EmpVo;
import com.publics.vo.feedback.Collect_OpinionsVo;
import com.publics.vo.feedback.FeedbackVo;
import com.publics.vo.studentModel.ClassCategoryVo;
import com.publics.vo.studentModel.StudentLeaveVo;
import com.publics.vo.studentModel.StudentVo;
import com.sun.deploy.net.HttpResponse;
import com.wtt.service.Wtt_StuDuanService;
import com.wtt.service.Wtt_StudentService;
import org.activiti.bpmn.model.Activity;
import org.activiti.engine.*;
import org.activiti.engine.history.HistoricVariableInstance;
import org.activiti.engine.impl.identity.Authentication;
import org.activiti.engine.impl.persistence.entity.ProcessDefinitionEntity;
import org.activiti.engine.impl.pvm.PvmActivity;
import org.activiti.engine.impl.pvm.PvmTransition;
import org.activiti.engine.impl.pvm.process.ActivityImpl;
import org.activiti.engine.runtime.ProcessInstance;
import org.activiti.engine.task.Comment;
import org.activiti.engine.task.Task;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.util.*;

@Controller
@RequestMapping("/student")
public class Wtt_StudentController {
    @Resource
    Wtt_StudentService studentService;
    @Resource
    LoginService loginService;
    @Resource
    private ProcessEngine processEngine;
    @Resource
    private TaskService taskService;
    @Resource
    private RuntimeService runtimeService;
    @Resource
    private HistoryService historyService;
    @Resource
    private RepositoryService repositoryService;
    @Resource
    private Wtt_StuDuanService wtt_stuDuanService;

    //无权时跳转页面
    @RequestMapping("/toNo")
    public String toNo(){
        return "controller_pluto/NO";
    }

    //学生请假查询
    @RequestMapping(value = "selectleave")
    public String toEmpPaper(HttpServletResponse response,Map map2, HttpSession session, ModelMap modelMap){
        response.setContentType("text/html;charset=utf-8");
        //获取当前登录用户,根据用户名去查询任务列表
        EmpVo empVo = (EmpVo) session.getAttribute("admin");
        String name = empVo.getEmpName();
        int empid = empVo.getEmpId();
        List<Task> tasks =taskService.createTaskQuery().taskAssignee(name).list();
        //单据
        List studentleave = new ArrayList();
        for(Task task:tasks){
            /*System.out.println(task.getId());*/
            //根据任务id取得单据id
            Object sid = taskService.getVariable(task.getId(),"holidayid");
            //如果有任务进入判断里面
            if(studentService.studentleave(Integer.parseInt((sid+""))).size()>0){
                Map map = (Map) studentService.studentleave(Integer.parseInt((sid+""))).get(0);
                //任务Id
                map.put("taskid",task.getId());
                //流程实例id
                map.put("processInstanceId",task.getProcessInstanceId());
                studentleave.add(map);
            }
        }
        map2.put("studentleavelist",studentleave);
        return "emp_wtt/studentleave";
    }
    //根据选中的请假id去到审批页面
    @RequestMapping(value = "/studentexamine")
    public String studentexamine(String taskid,String instance,Model model){
        /*System.out.println("我进来了，你拦我啊！！");*/
        //根据流程实例Id查询流程实例
        ProcessInstance processInstance =runtimeService.createProcessInstanceQuery().processInstanceId(instance).singleResult();
        //根据任务ID查询任务实例
        Task task = taskService.createTaskQuery().taskId(taskid).singleResult();
        /*System.out.println("任务实例："+task);*/
        //历史审批信息
        List<Comment> comments = taskService.getProcessInstanceComments(instance);
        /*System.out.println("历史审批信息:"+comments);*/
        //获取流程定义ID
        String defindid =task.getProcessDefinitionId();
        /*System.out.println("流程定义ID:"+defindid);*/
        //根据流程定义ID查询流程定义实体对象
        ProcessDefinitionEntity processDefinitionEntity = (ProcessDefinitionEntity) processEngine.getRepositoryService().getProcessDefinition(defindid);
        //根据流程实例对象获取活动ID
        String activityid =processInstance.getActivityId();
        /*System.out.println("当前活动ID:"+activityid);*/
        //查询当前活动
        ActivityImpl activityimpl = processDefinitionEntity.findActivity(activityid);
        //获取当前活动的连线
        List<PvmTransition> pvmTransitions =activityimpl.getOutgoingTransitions();
        List list = new ArrayList();
        for(PvmTransition pvmTransition:pvmTransitions){
            Map map = new HashMap();
            if(pvmTransition.getProperty("name")==null  ){
                map.put("id",0);
                map.put("name","审批");
            }else {
                map.put("id",pvmTransition.getId());
                map.put("name",pvmTransition.getProperty("name"));
            }
            list.add(map);
        }
        //获取单据Id
        int danjuid = Integer.parseInt(taskService.getVariable(taskid,"holidayid").toString());
        /*System.out.println("单据id:"+danjuid);*/
        StudentLeaveVo studentLeaveVo= studentService.leavelist(danjuid);
        /*System.out.println(studentLeaveVo);*/
        String name = studentService.name(danjuid);
        model.addAttribute("name",name);
        //任务ID
        model.addAttribute("taskid",taskid);
        //备注
        model.addAttribute("comment",comments);
        //实体对象
        model.addAttribute("leavevo",studentLeaveVo);
        //连线
        model.addAttribute("opinion",list);
        return "emp_wtt/examineStudent";
    }
    //审批
    @RequestMapping(value = "/complete")
    public String complete(int id,String taskid,String comment,String opinion,HttpSession session){
        //根据任务id查找任务对象
        Task task =taskService.createTaskQuery().taskId(taskid).singleResult();
        /*System.out.println("任务对象："+task);*/
        //根据任务对象得到流程实例ID
        String processinstanceid= task.getProcessInstanceId();
        //根据单据ID得到实体对象
        StudentLeaveVo studentLeaveVo =studentService.leavelist(id);
        EmpVo empVo = (EmpVo) session.getAttribute("admin");
        String name_bl = empVo.getEmpName();//办理人姓名
        int empid = empVo.getEmpId();
        //当前办理人
        Authentication.setAuthenticatedUserId(name_bl);
        //设置备注信息（任务ID,实例ID,备注的信息）
        taskService.addComment(taskid,processinstanceid,comment);
        //判断当前审批人是否为班主任
        String assignee = "";
        List clist = studentService.selclassteacher("select * from emp where postName like '班主任'");
        /*System.out.println("班主任:"+clist);*/
        for(int i = 0;i < clist.size(); i++){
            Map map = (Map) clist.get(i);
            System.out.println("----"+map.get("empName"));
            if(name_bl.equals(map.get("empName"))){
                String name = studentService.chairman(empid);
                System.out.println("部门负责人："+name);
                assignee = name;
                break;
            }
        }

        Map map = new HashMap();
        map.put("opinion",opinion);
        if(!"".equals(assignee)){
            map.put("assignee",assignee);
        }else {
            Map studnetmap = studentService.studentid(id);
            int studentid = (int) studnetmap.get("Studid");
            Map map1 = wtt_stuDuanService.selectteacher(studentid);
            System.out.println("班主任姓名："+map1);
            String names = (String) map1.get("classTeacher");
            System.out.println("names");
            map.put("assignee",names);
        }

        //完成任务
        taskService.complete(taskid,map);
        //根据流程实例获取实例对象
        ProcessInstance processInstance =runtimeService.createProcessInstanceQuery().processInstanceId(processinstanceid).singleResult();
        if(processInstance==null){
            if(opinion.equals("拒绝")){
                studentLeaveVo.setStatus("审批不通过");
                System.out.println("审批不通过");
            }else{
                studentLeaveVo.setStatus("审批通过");
            }
            studentService.updateleave(studentLeaveVo);
        }
        return "redirect:/student/selectleave";
    }

    //去到问题反馈查询页面
    @RequestMapping(value = "/questionPage")
    public String question(){
        return "emp_wtt/question";
    }
    //问题反馈查询
    @RequestMapping(value = "/selectquestion")
    public void selectquestion(HttpServletResponse response, int page, int limit){
        response.setContentType("text/html;charset=utf-8");
        //当前页
        List<FeedbackVo> list = studentService.feedback(page,limit);
        //获取总行数
        int rows =studentService.wentipagecounts();
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("msg","提示");
        jsonObject.put("code",0);
        jsonObject.put("data",list);
        jsonObject.put("count",rows);
        try {
            PrintWriter pw = response.getWriter();
            pw.print(jsonObject.toJSONString());
            pw.flush();
            pw.close();
        }catch (IOException e) {
            e.printStackTrace();
        }
    }

    //查询意见
    @RequestMapping(value ="/selectcollect")
    @ResponseBody
    public void selectcollect(HttpServletRequest request,HttpServletResponse response) throws IOException {
        response.setContentType("text/html;charset=utf-8");
        int ids = Integer.parseInt(request.getParameter("wid"));
        /*System.out.println("id为："+ids);*/
        List<Collect_OpinionsVo> list = studentService.selectyijian(ids);
        /*System.out.println("查询意见:"+list);*/
        PrintWriter pw = response.getWriter();
        pw.print(JSONArray.toJSONString(list));
        pw.close();
    }
    //新增意见
    @RequestMapping(value = "/addcollect")
    public String addcollect(Collect_OpinionsVo collect_opinionsVo,HttpServletRequest request, HttpServletResponse response, HttpSession session) throws UnsupportedEncodingException {
        int id = Integer.parseInt(request.getParameter("feedbackId"));
        collect_opinionsVo.setWid(id);
        collect_opinionsVo.setPuttime(new Date());
        //获取当前登录用户
        EmpVo empVo = (EmpVo) session.getAttribute("admin");
        String username = empVo.getEmpName();
        collect_opinionsVo.setEmpname(username);
        collect_opinionsVo.setContent(StringUtill.tostring(collect_opinionsVo.getContent()));
        //根据问题反馈Id去查找数据
        FeedbackVo feedbackVo = studentService.feedbackvo(id);
        //重新设置状态
        feedbackVo.setStatus(2);
        //在新增意见的时候改变问题反馈的状态（已处理）
        studentService.update(feedbackVo);
        //新增意见
        studentService.add(collect_opinionsVo);
        return "redirect:/student/questionPage";
    }

    //去到班级类别页面
    @RequestMapping(value = "/classCategory")
    public String classCategory(){
        return "emp_wtt/classCategory";
    }

    //查询班级类别
    @RequestMapping(value = "/selectCategory")
    public void selectCategory(HttpServletResponse response,int page, int limit){
        response.setContentType("text/html;charset=utf-8");
        List<ClassCategoryVo> list = studentService.selectclasscate(page,limit);
        //获取总行数
        int rows =studentService.pagecount("select count(*) from classType");
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("msg","提示");
        jsonObject.put("code",0);
        jsonObject.put("data",list);
        jsonObject.put("count",rows);
        try {
            PrintWriter printWriter = response.getWriter();
            printWriter.print(jsonObject.toJSONString());
            printWriter.flush();
            printWriter.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    //新增班级类别
    @RequestMapping(value = "/addcate")
    public String addcate(ClassCategoryVo classCategoryVo){
        studentService.addcategory(classCategoryVo);
        return "redirect:/student/classCategory";
    }

    //编辑班级类别
    @RequestMapping(value = "/updatecate")
    public String updatecate(ClassCategoryVo classCategoryVo){
        studentService.updatecate(classCategoryVo);
        return "redirect:/student/classCategory";
    }
}