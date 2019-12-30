package com.wtt.controller;

import com.alibaba.fastjson.JSONObject;
import com.publics.vo.feedback.FeedbackVo;
import com.publics.vo.studentModel.StudentClassVo;
import com.publics.vo.studentModel.StudentLeaveVo;
import com.publics.vo.studentModel.StudentVo;
import com.wtt.service.Wtt_StuDuanService;
import org.activiti.engine.*;
import org.activiti.engine.history.HistoricVariableInstance;
import org.activiti.engine.runtime.ProcessInstance;
import org.activiti.engine.task.Comment;
import org.activiti.engine.task.Task;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

@Controller
@RequestMapping("/studentduan")
public class Wtt_StuDuanController {
    @Resource
    Wtt_StuDuanService wtt_stuDuanService;
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

    //无权时跳转页面
    @RequestMapping("/toNo")
    public String toNo(){
        return "controller_pluto/NO";
    }

    @RequestMapping(value = "/problem_feedback")
    public String problem_feedback(ModelMap modelMap,HttpSession session){
        List deplist = wtt_stuDuanService.dep();
        modelMap.addAttribute("list",deplist);
        return "student_wtt/problem_feedback";
    }
    //学生端查询问题反馈
    @RequestMapping(value = "/selectproblem")
    public void selectproblem(HttpServletResponse response, int page, int limit,HttpSession session){
        response.setContentType("text/html;charset=utf-8");
        //获取存在session中的用户(电话号码)
        StudentVo studentVo = (StudentVo) session.getAttribute("user");
        int stuid = studentVo.getStudid();
        //当前页
        List<FeedbackVo> list = wtt_stuDuanService.feedback(stuid,page,limit);
        //获取总行数
        int rows =wtt_stuDuanService.pagecount(stuid);
        /* //System.out.println("总行数:"+rows);*/
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

    //新增学生问题反馈
    @RequestMapping(value = "/addproblems",method = RequestMethod.POST)
    public String addproblem(FeedbackVo feedbackVo, /*@RequestParam(value = "file")*/ MultipartFile images, HttpServletRequest request,HttpSession session){
        /* //System.out.println("部门id:"+request.getParameter("depId"));*/
        //获取旧文件名
        String oldname = images.getOriginalFilename();
       /*  //System.out.println("获取旧文件名:"+oldname);*/
        //获取旧文件名的后缀名
        String substr = oldname.substring(oldname.indexOf("."));
       /*  //System.out.println("后缀名:"+substr);*/
        //给上传文件加上年月日
        Date date = new Date(new java.util.Date().getTime());
        //设计新文件名
        String newname = UUID.randomUUID().toString();
        //拼接全文件名
        String allpath = newname+substr;
        //获取文件的绝对路径
        String path =request.getSession().getServletContext().getRealPath("\\");
        path+="WEB-INF\\static\\imgs\\problem\\"+date;
        File file = new File(path);
        if(!file.exists()){
            file.mkdirs();
        }
        File file1 = new File(path,allpath);
        try {
            images.transferTo(file1);
            feedbackVo.setImage("..\\imgs\\problem\\"+date+"\\"+allpath);
        } catch (IOException e) {
            e.printStackTrace();
        }
        feedbackVo.setFeedBackType(1);
        feedbackVo.setFeedbackTime(new java.util.Date());
        //获取存在session中的用户(电话号码)
        StudentVo studentVo = (StudentVo) session.getAttribute("user");
        int studentid = studentVo.getStudid();
        Map map = wtt_stuDuanService.student(studentid);
        /*int id = (int) map.get("Studid");*/
        feedbackVo.setEmpId(studentid);
        feedbackVo.setStatus(1);
        String classname = (String) map.get("className");
        /* //System.out.println("班级名称:"+classname);*/
        feedbackVo.setEmpName(classname);
        wtt_stuDuanService.add(feedbackVo);
        return "redirect:/studentduan/problem_feedback";
    }

    //去到学生申请请假页面
    @RequestMapping(value = "/studentleaves")
    public String studentleave(){
        return "student_wtt/apply_leave";
    }

    //查询学生请假
    @RequestMapping(value = "studentselectleave")
    public void studentselectleave(int page,int limit,HttpServletResponse response,HttpSession session){
        //获取存在session中的用户(电话号码)
        StudentVo studentVo = (StudentVo) session.getAttribute("user");
        int stuid = studentVo.getStudid();
        response.setContentType("text/html;charset=utf-8");
        List<StudentLeaveVo> list = wtt_stuDuanService.studentleave(stuid,page,limit);
        //获取总行数
        int rows =wtt_stuDuanService.leavepagecount();
        JSONObject jsonObjects = new JSONObject();
        jsonObjects.put("msg","提示");
        jsonObjects.put("code",0);
        jsonObjects.put("data",list);
        jsonObjects.put("count",rows);
        try {
            PrintWriter pw = response.getWriter();
            pw.print(jsonObjects.toJSONString());
            pw.flush();
            pw.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    //新增学生请假
    @RequestMapping(value = "/addstudentleave")
    public String addstuedntleave(StudentLeaveVo studentLeaveVo,HttpSession session){
        //获取存在session中的用户(电话号码)
        StudentVo studentVo = (StudentVo) session.getAttribute("user");
        int id = studentVo.getStudid();
        studentLeaveVo.setStudentId(id);
        studentLeaveVo.setStatus("审批中");
        wtt_stuDuanService.leaveadd(studentLeaveVo);

        //设置流程实例变量集合
        Map<String,Object> map =new HashMap<>();
        map.put("holidayid",studentLeaveVo.getHolidayid());
        map.put("StudentId",studentLeaveVo.getStudentId());
        map.put("day",studentLeaveVo.getHolidayDay());
        //根据用户设置下一个办理人
        int studentid = studentVo.getStudid();
        Map map1 = wtt_stuDuanService.selectteacher(studentid);
        /*System.out.println(map1);*/
        int teacherid = (int) map1.get("teacher");
        System.out.println("授课老师Id:"+teacherid);
        map.put("assignee",teacherid);
        //启动实例(通过流程定义的Key来启动一个实例)
        ProcessInstance processInstance = runtimeService. startProcessInstanceByKey(studentLeaveVo.getTitle(),map);
        /* //System.out.println(studentLeaveVo.getTitle());*/
        //根据流程实例ID获取当前实例正在执行的任务
        Task task =taskService.createTaskQuery().processInstanceId(processInstance.getId()).orderByProcessInstanceId().desc().singleResult();
        //通过任务ID完成任务
        taskService.complete(task.getId(),map);
        return "redirect:/studentduan/studentleaves";
    }

    //查看我的批注
    @RequestMapping(value = "/pizhu/{id}")
    public String selectmypizhu(@PathVariable(value = "id") int id, Model model){
        /* //System.out.println("Saaaaaaa");*/
        /* //System.out.println("id:"+holidayid);*/
        //根据单据id查询历史变量对象
        HistoricVariableInstance historicVariableInstance = historyService.createHistoricVariableInstanceQuery().variableValueEquals("holidayid",id).singleResult();
        //查询历史批注
        List<Comment> comments =taskService.getProcessInstanceComments(historicVariableInstance.getProcessInstanceId());
        model.addAttribute("commentlist",comments);
        return "student_wtt/mypizhu";
    }

    //主页面点击用户，查看用户信息
    @RequestMapping(value = "/usermessage")
    public String usermessage(HttpSession session,ModelMap modelMap){
        //获取当前登录用户
        StudentVo studentVo = (StudentVo) session.getAttribute("user");
        int id = studentVo.getStudid();
        String classname = wtt_stuDuanService.classname(id);
        String hourname = wtt_stuDuanService.hourname(id);
        modelMap.addAttribute("studentlist",studentVo);
        modelMap.addAttribute("classname",classname);
        modelMap.addAttribute("hourname",hourname);
        return "student_wtt/usermssage";
    }

    //修改密码
    @RequestMapping(value = "/updatepwd")
    public void updatepwd(String pwd,String pwd1,HttpSession session,HttpServletResponse response) throws IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter writer = response.getWriter();
        StudentVo studentVo = (StudentVo) session.getAttribute("user");
        if(!pwd.equals(studentVo.getPassword())){//原密码错误
            writer.print("error");
            writer.flush();
            writer.close();
        }else {//密码正确
            wtt_stuDuanService.updatePwd(studentVo.getStudid(),pwd1);
        }
        writer.print("ok");
        writer.flush();
        writer.close();
    }
}