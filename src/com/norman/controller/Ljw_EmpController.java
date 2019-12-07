package com.norman.controller;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.norman.service.Ljw_EmpService;
import com.publics.vo.empModel.ChatRecordVo;
import com.publics.vo.empModel.WeeklogVo;
import com.publics.vo.empModel.emp.EmpVo;
import com.publics.vo.studentModel.StudentVo;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.*;

@Controller
@RequestMapping(value = "/ljw")
public class Ljw_EmpController {
    @Resource
    private Ljw_EmpService empService;

    @RequestMapping(value = "/toChatRecordPage")
    public String toChatRecordPage(HttpServletRequest request){
        List<EmpVo> empList = empService.getEmpList();
        List<StudentVo> stuList = empService.getStudentList();
        request.setAttribute("empList",empList);
        request.setAttribute("stuList",stuList);
        return "emp_ljw/chatRecord";
    }

    @RequestMapping(value = "/toWeekLogPage")
    public String toWeekLogPage(){
        return "emp_ljw/weekLog";
    }
    @ResponseBody
    @RequestMapping(value = "/getChatRecordData")
    public void getChatRecordData(HttpServletResponse response, HttpServletRequest request,int page,int limit) throws IOException {
        JSONObject jsonObject = new JSONObject();

        int count =empService.getChatRecordSize();
        jsonObject.put("code",0);
        jsonObject.put("msg","提示");
        jsonObject.put("count",count);
        jsonObject.put("data",empService.getData(page,limit));

        response.setContentType("text/html;charset=utf-8");
        System.out.println("发送到前台");
        PrintWriter out = response.getWriter();
        out.print(jsonObject.toJSONString());
        out.flush();
        out.close();
    }
    @ResponseBody
    @RequestMapping(value = "/getWeekLogData")
    public void getWeekLogData(HttpServletResponse response, HttpServletRequest request,int page,int limit) throws IOException {
        JSONObject jsonObject = new JSONObject();

        int count =empService.getWeekLogSize();
        jsonObject.put("code",0);
        jsonObject.put("msg","提示");
        jsonObject.put("count",count);
        jsonObject.put("data",empService.getWeekLogData(page,limit));

        response.setContentType("text/html;charset=utf-8");
        System.out.println("发送到前台");
        PrintWriter out = response.getWriter();
        out.print(jsonObject.toJSONString());
        out.flush();
        out.close();
    }

    @ResponseBody
    @RequestMapping(value = "/getChatRecordSelData")
    public void getChatRecordSelData(HttpServletResponse response) throws IOException {
        List<EmpVo> empList = empService.getEmpList();
        List<StudentVo> stuList = empService.getStudentList();
        JSONArray stuJA = new JSONArray();
        for (StudentVo stu:stuList) {
            JSONObject stuJO = new JSONObject();
            stuJO.put("id",stu.getStudid());
            stuJO.put("name",stu.getStuname());
            stuJA.add(stuJO);
        }
        JSONArray empJA = new JSONArray();
        for (EmpVo empVo:empList) {
            JSONObject empJO = new JSONObject();
            empJO.put("id",empVo.getEmpId());
            empJO.put("name",empVo.getEmpName());
            empJA.add(empJO);
        }
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("empList",empJA);
        jsonObject.put("stuList",stuJA);
        response.setContentType("text/html;charset=utf-8");
        PrintWriter out = response.getWriter();
        out.print(jsonObject.toJSONString());
        out.flush();
        out.close();
    }

    @RequestMapping(value = "/newChatRecord")
    public String newChatRecord(ChatRecordVo vo){
        System.out.println(vo);
        if (vo.getChatid()==0){
            empService.addChatRecord(vo);
        }else {
            empService.setChatRecord(vo);
        }
        return "redirect:/ljw/toChatRecordPage";
    }

    @RequestMapping(value = "/delChatRecord")
    public void delChatRecord(HttpServletResponse response,int id) throws IOException {
        empService.delChatRecord(id);
        response.setContentType("text/html;charset=utf-8");
        PrintWriter out = response.getWriter();
        out.print("1");
        out.flush();
        out.close();
    }

    //去到查看周报页面
    @RequestMapping(value = "/lookEmpPaperPage/{id}")
    public String lookEmpPaperPage(@PathVariable(value = "id") int id, ModelMap modelMap){

        modelMap.addAttribute("weekLog",empService.getWeekLog(id));
        return "emp_ljw/weekLogInfo";
    }
}
