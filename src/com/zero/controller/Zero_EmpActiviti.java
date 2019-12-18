package com.zero.controller;

import com.publics.vo.empModel.HolidayVo;
import com.publics.vo.empModel.emp.EmpVo;
import com.zero.service.EmpActivitiService;
import org.activiti.engine.*;
import org.activiti.engine.history.HistoricVariableInstance;
import org.activiti.engine.impl.identity.Authentication;
import org.activiti.engine.impl.persistence.entity.ProcessDefinitionEntity;
import org.activiti.engine.impl.pvm.PvmTransition;
import org.activiti.engine.impl.pvm.process.ActivityImpl;
import org.activiti.engine.runtime.ProcessInstance;
import org.activiti.engine.task.Comment;
import org.activiti.engine.task.Task;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

@Controller
@RequestMapping("zeroLeave")
public class Zero_EmpActiviti {
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
    EmpActivitiService service;

    @RequestMapping("/toleave")
    public String toLeave(){
        return "emp/leave";
    }

    @RequestMapping("/returnData")
    @ResponseBody//查询所有请假
    public void responseData(HttpServletResponse response) throws IOException {
        response.setContentType("text/html;charset=utf-8");
        String json = service.getLeaveList("select h.*,e.empName from holiday h" +
                " left join emp e on e.empId = h.Empid");
        PrintWriter out = response.getWriter();
        out.print(json);
        out.close();
    }

    @RequestMapping("/addLeave")
    @ResponseBody//提交请假
    public void addLeave(HttpServletResponse response, HttpServletRequest request,String type, HttpSession session) throws IOException {
        String title = request.getParameter("Title");
        String stime = request.getParameter("startTime");
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        Date startDate = new Date();
        String etime = request.getParameter("endTime");
        Date endDate = new Date();
        try {
            startDate = sdf.parse(stime);
            endDate = sdf.parse(etime);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        EmpVo emp = (EmpVo)session.getAttribute("admin");
        String day = request.getParameter("holidayDay");
        String hour = request.getParameter("hour");
        String Remark = request.getParameter("Remark");
        HolidayVo holidayVo = new HolidayVo();
        holidayVo.setTitle(title);
        holidayVo.setStartTime(startDate);
        holidayVo.setEndTime(endDate);
        holidayVo.setHolidayDay(Integer.parseInt(day));
        holidayVo.setHour(Integer.parseInt(hour));
        holidayVo.setRemark(Remark);
        holidayVo.setStatus(1);//状态 1:审批中 2：已完成 3：不批准
        holidayVo.setEmpid(emp.getEmpId());//设置请假员工

        service.addLeave(holidayVo);//上传员工请假
        //设置流程实例变量集合
        Map<String,Object> variables = new HashMap<>();
        variables.put("user",(emp.getEmpName()));//用户名称
        variables.put("day",holidayVo);//天数
        variables.put("holiday",holidayVo.getHolidayid());//单据ID

        //动态办理人 根据用户设置第一个办理人
        String assigneeName = service.assignName(emp.getEmpId());
        variables.put("assignee",assigneeName);


        //启动实例（通过流程定义的key来启动一个实例）
        ProcessInstance processInstance = runtimeService.startProcessInstanceByKey(type,variables);
        System.out.println("流程实例 "+processInstance.getId());

        //根据流程实例ID获取当前实例正在执行的任务
        Task task = taskService.createTaskQuery().processInstanceId(processInstance.getId()).orderByProcessInstanceId().desc().singleResult();
        System.out.println("任务ID："+task.getId());

        //完成任务(通过任务ID完成该任务)
        taskService.complete(task.getId(),variables);
        PrintWriter out = response.getWriter();
        out.print("1");
        out.flush();
        out.close();
    }

    @RequestMapping(value = "/mytask")//我的任务
    public String mytask(HttpSession session,Model model){
        EmpVo emp = (EmpVo)session.getAttribute("admin");
        String user = emp.getEmpName();
        //通过办理人查询任务集合
        List<Task> mytask = taskService.createTaskQuery().taskAssignee(user).list();
        model.addAttribute("tasklist",mytask);
        return "emp/mytask";
    }

    @RequestMapping(value = "/taskDetaill")//查看任务详情
    public String taskDetaill(Model model, String taskId, String instanceid){
        //根据流程实例ID查询流程实例
        ProcessInstance pi = runtimeService.createProcessInstanceQuery().processInstanceId(instanceid).singleResult();
        //根据任务ID 查询任务实例
        Task task = taskService.createTaskQuery().taskId(taskId).singleResult();
        //历史审批信息
        List<Comment> commentList = taskService.getProcessInstanceComments(taskId);
        //获取流程定义id
        String processDefineId = task.getProcessDefinitionId();
        //查询流程定义实体对象
        ProcessDefinitionEntity pdentity = (ProcessDefinitionEntity)processEngine.getRepositoryService().getProcessDefinition(processDefineId);
        //获取当前活动id
        String activeId = pi.getActivityId();
        System.out.println("当前活动ID "+activeId);
        //获取当前活动(usertask2)
        ActivityImpl impl = pdentity.findActivity(activeId);
        //获取当前活动的连线
        List<PvmTransition> pvmlist = impl.getOutgoingTransitions();
        List plist = new ArrayList();
        for(PvmTransition pvm:pvmlist){
            Map map = new HashMap();
            if(pvm.getProperty("name")==null){//如果没有设置连线名称，给一个默认的选项
                map.put("id",0);
                map.put("name","审批");
            }else{
                map.put("id",pvm.getId());
                map.put("name",pvm.getProperty("name"));
            }

            plist.add(map);
        }

        //获取请假id
        int holidayid = Integer.parseInt(taskService.getVariable(taskId,"holidayid").toString());
        //根据id查询对象
        HolidayVo holidayVo = service.seleHoliday(holidayid);
        model.addAttribute("taskId",taskId);//批注list
        model.addAttribute("commentList",commentList);
        model.addAttribute("plist",plist);
        model.addAttribute("holiday",holidayVo);
        return "emp/detail";
    }

    @RequestMapping(value = "/ratify")//审批任务
    public String taskDetaill(HttpSession session,String holidayid,String taskId,String flow,String comment){
        //根据任务id得到任务对象
        Task task = taskService.createTaskQuery().taskId(taskId).singleResult();
        //通过任务对象获取流程实例id
        String processInstId = task.getProcessInstanceId();
        //根据单据id查询单据对象
        HolidayVo holidayVo = service.seleHoliday(Integer.parseInt(holidayid));
        EmpVo emp = (EmpVo)session.getAttribute("admin");
        //获得用户
        String user = emp.getEmpName();
        //设置当前任务办理人
        Authentication.setAuthenticatedUserId(user);
        //设置备注信息(任务ID，实例ID，页面上的备注)
        taskService.addComment(taskId,processInstId,comment);
        //添加任务变量
        Map mflow = new HashMap();
        mflow.put("flow",flow);
        //动态办理人，设置以后下一个办理人
        mflow.put("assignee",service.xiaassignName(Integer.valueOf(holidayid)));
        //完成当前任务
        taskService.complete(taskId,mflow);
        //根据流程实例获取实例对象(完成流程的实例依然会存放在数据库中 但是查询出来是null的)
        ProcessInstance pi = runtimeService.createProcessInstanceQuery().processInstanceId(processInstId).singleResult();
        if(pi == null){
            if(flow.equals("拒绝")){
                //修改
                holidayVo.setStatus(3);
                service.updateholiday(holidayVo);
            }else {
                holidayVo.setStatus(2);
                service.updateholiday(holidayVo);
            }
        }
        return "redirect: emp/mytask";
    }
    //查看批注
    @RequestMapping(value = "/mycomment")
    public String mycomment(int holidayid,Model model){
        //通过jobId查询历史变量对象
        HistoricVariableInstance hvi = historyService.createHistoricVariableInstanceQuery().variableValueEquals("holidayid", holidayid).singleResult();
        System.out.println("实例id"+hvi.getProcessInstanceId());
        System.out.println("批注"+taskService.getProcessInstanceComments(hvi.getProcessInstanceId()).size());
        //获取流程实例id （查询历史批注）
        List<Comment> commentList = taskService.getProcessInstanceComments(hvi.getProcessInstanceId());
        model.addAttribute("commentList",commentList);
        return "emp/mycomment";
    }
}
