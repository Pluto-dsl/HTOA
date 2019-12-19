package com.zero.controller;

import com.alibaba.fastjson.JSONArray;
import com.publics.vo.empModel.HolidayVo;
import com.publics.vo.empModel.emp.EmpVo;
import com.zero.service.EmpActivitiService;
import org.activiti.engine.*;
import org.activiti.engine.history.HistoricActivityInstance;
import org.activiti.engine.history.HistoricProcessInstance;
import org.activiti.engine.history.HistoricVariableInstance;
import org.activiti.engine.impl.identity.Authentication;
import org.activiti.engine.impl.persistence.entity.ProcessDefinitionEntity;
import org.activiti.engine.impl.pvm.PvmTransition;
import org.activiti.engine.impl.pvm.process.ActivityImpl;
import org.activiti.engine.repository.ProcessDefinition;
import org.activiti.engine.runtime.ProcessInstance;
import org.activiti.engine.task.Comment;
import org.activiti.engine.task.Task;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
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
        return "emp/leave/leave";
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
        int startday = startDate.getDate();
        int endday = endDate.getDate();
        EmpVo emp = (EmpVo)session.getAttribute("admin");
        String day = request.getParameter("holidayDay");
        String hour = request.getParameter("hour");
        String Remark = request.getParameter("Remark");
        HolidayVo holidayVo = new HolidayVo();
        holidayVo.setTitle(title);
        holidayVo.setStartTime(startDate);
        holidayVo.setEndTime(endDate);
        holidayVo.setHolidayDay(Integer.parseInt(day));
        holidayVo.setHour((endday-startday)*24+Integer.parseInt(hour));
        holidayVo.setRemark(Remark);
        holidayVo.setStatus(1);//状态 1:审批中 2：已完成 3：不批准
        holidayVo.setEmpid(emp.getEmpId());//设置请假员工

        service.addLeave(holidayVo);//上传员工请假
        //设置流程实例变量集合
        Map<String,Object> variables = new HashMap<>();
        variables.put("user",(emp.getEmpName()));//用户名称
        variables.put("hour",holidayVo.getHour());//小时天数
        variables.put("holiday",holidayVo.getHolidayid());//单据ID

        //动态办理人 根据用户设置第一个办理人
        variables.put("assignee",service.assignName(emp.getEmpId()));

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
        System.out.println("任务集合"+mytask);
        List<Map> holidays = new ArrayList<>();
        for(Task task: mytask){
            //根据任务id取得单据id
            Object sid = taskService.getVariable(task.getId(),"holiday");
            System.out.println("sid"+sid);
            //如果有任务进入判断里面
            if(service.mytask(Integer.parseInt((sid+""))).size()>0){
                Map map = (Map) service.mytask(Integer.parseInt((sid+""))).get(0);
                //任务Id
                map.put("taskid",task.getId());
                //流程实例id
                map.put("processInstanceId",task.getProcessInstanceId());
                holidays.add(map);
            }
        }
        model.addAttribute("tasklist",holidays);
        return "emp/leave/mytask";
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
        int holidayid = Integer.parseInt(taskService.getVariable(taskId,"holiday").toString());
        //根据id查询对象
        HolidayVo holidayVo = service.seleHoliday(holidayid);
        model.addAttribute("taskId",taskId);
        model.addAttribute("commentList",commentList);//批注list
        model.addAttribute("plist",plist);
        model.addAttribute("ho",holidayVo);
        return "emp/leave/detail";
    }

    @RequestMapping(value = "/taskImg")//查看办理进度 流程图执行节点（红色框高亮）
    public String logout(String holidayid,String instanceid,Model model){
        String processInstanceId = "";//流程实例ID
        if(holidayid!=null&&!"".equals(holidayid)){
            //通过单据id查找实例对象
            HistoricVariableInstance hvi = historyService.createHistoricVariableInstanceQuery().variableValueEquals("holiday", Integer.parseInt(holidayid)).singleResult();
            //通过历史流程变量查询变量对象(获取流程实例ID)
            processInstanceId = hvi.getProcessInstanceId();
        }
        //我的任务（查看办理进度）
        if(instanceid!=null&&!"".equals(instanceid)){
            processInstanceId=instanceid;
        }
        //获取历史任务实例
        HistoricProcessInstance historicProcessInstance = historyService.createHistoricProcessInstanceQuery()
                .processInstanceId(processInstanceId).singleResult();

        if(historicProcessInstance!=null){
            //获取流程定义信息
            ProcessDefinition pd = repositoryService.getProcessDefinition(historicProcessInstance.getProcessDefinitionId());
            // 获取流程定义的实体（包含了流程中的任务节点信息，连线信息）
            ProcessDefinitionEntity processDefinition = (ProcessDefinitionEntity)pd;
            // 获取流程历史中已执行节点，并按照节点在流程中执行先后顺序排序
            List<HistoricActivityInstance> historicActivityInstanceList = historyService.createHistoricActivityInstanceQuery()
                    .processInstanceId(processInstanceId).orderByHistoricActivityInstanceId().asc().list();
            // 已经激活的节点ID集合
            //激活的节点（1.任务已经完成；2.任务已经开始，但还未结束）
            List mapList = new ArrayList();
            //获取已经激活的节点ID
            for (HistoricActivityInstance activityInstance : historicActivityInstanceList) {
                //getActivityId方法获取已经激活的节点id
                ActivityImpl activityImpl = processDefinition.findActivity(activityInstance.getActivityId());
                //获取当前节点在图片中的坐标位置，左上角坐标及长宽
                int x = activityImpl.getX();
                int y = activityImpl.getY();
                int height = activityImpl.getHeight();
                int width = activityImpl.getWidth();
                Map<String, Object> map = new HashMap<String, Object>();
                map.put("x", x);
                map.put("y", y);
                map.put("height", height);
                map.put("width", width);
                mapList.add(map);
            }
            model.addAttribute("pd",pd);
            model.addAttribute("mapList",mapList);
        }
        return "emp/leave/taskImg";
    }

    @RequestMapping(value = "/selectProgressDefineimg")
    public String img(String did,String imageName,HttpServletResponse response) {//查看流程图
        InputStream in = repositoryService.getResourceAsStream(did,imageName);
        try {
            OutputStream out = response.getOutputStream();
            // 把图片的输入流程写入resp的输出流中
            byte[] b = new byte[1024];
            for (int len = -1; (len= in.read(b))!=-1; ) {
                out.write(b, 0, len);
            }
            // 关闭流
            out.close();
            in.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return null;
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
        mflow.put("assignee",service.xiaassignName(Integer.valueOf(holidayVo.getEmpid())));
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
        return "redirect: mytask";
    }
    //查看批注
    @RequestMapping(value = "/mycomment")
    public String mycomment(int holidayid,Model model){
        //通过jobId查询历史变量对象
        HistoricVariableInstance hvi = historyService.createHistoricVariableInstanceQuery().variableValueEquals("holiday", holidayid).singleResult();
        System.out.println("实例id"+hvi.getProcessInstanceId());
        System.out.println("批注"+taskService.getProcessInstanceComments(hvi.getProcessInstanceId()).size());
        //获取流程实例id （查询历史批注）
        List<Comment> commentList = taskService.getProcessInstanceComments(hvi.getProcessInstanceId());
        model.addAttribute("commentList",commentList);
        return "emp/leave/mycomment";
    }
}
