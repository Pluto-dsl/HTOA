package com.zero.controller;

import com.alibaba.fastjson.JSONArray;
import com.zero.service.EmpInfo;
import com.zero.service.EmpsService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Map;
import java.util.TreeMap;

@Controller
@RequestMapping("zeroEmpInfo")
@SessionAttributes("empId")
public class Zero_EmpOtherInfo {
    @Resource
    EmpInfo service;
    @RequestMapping(value = "/topage")//所有员工资料页
    public String toemp(Model model, int empId) {//去员工资料页
        model.addAttribute("empId",empId);
        return "emp/empOtherInfo";
    }
    //工作经历
    @RequestMapping(value = "/job")//所有员工资料页
    public void job(HttpServletResponse response,int empId) throws IOException {
        Map map = new TreeMap();
        map.put("code",0);
        map.put("msg","");
        map.put("count",1);
        map.put("data",service.jobs(empId));
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter writer = response.getWriter();
        writer.print(JSONArray.toJSONString(map));
        writer.flush();
        writer.close();
    }
    //教育背景
    @RequestMapping(value = "/education")//所有员工资料页
    public void education(HttpServletResponse response,int empId) throws IOException {
        Map map = new TreeMap();
        map.put("code",0);
        map.put("msg","");
        map.put("count",1);
        map.put("data",service.education(empId));
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter writer = response.getWriter();
        writer.print(JSONArray.toJSONString(map));
        writer.flush();
        writer.close();
    }
    //家庭联系人
    @RequestMapping(value = "/familyInfo")//所有员工资料页
    public void familyInfo(HttpServletResponse response,int empId) throws IOException {
        Map map = new TreeMap();
        map.put("code",0);
        map.put("msg","");
        map.put("count",1);
        map.put("data",service.education(empId));
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter writer = response.getWriter();
        writer.print(JSONArray.toJSONString(map));
        writer.flush();
        writer.close();
    }
    //员工考核

    //证件上传
}
