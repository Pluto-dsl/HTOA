package com.zero.controller;

import com.alibaba.fastjson.JSONArray;
import com.publics.vo.empModel.emp.EducationVo;
import com.publics.vo.empModel.emp.FamilyInfoVo;
import com.publics.vo.empModel.emp.JobVo;
import com.zero.service.EmpInfo;
import com.zero.service.EmpsService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
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
    @ResponseBody
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

    @RequestMapping(value = "/addjob")//添加或修改工作经历
    @ResponseBody
    public void addjob(int Empid,int Jobid,String companyName,String degree,String startDate,String endDate,String reason,String Remark,HttpServletResponse response) throws IOException, ParseException {
        JobVo jobVo = new JobVo();//重新拼装job对象
        jobVo.setEmpid(Empid);
        jobVo.setJobid(Jobid);
        jobVo.setCompanyName(companyName);
        jobVo.setDegree(degree);
        DateFormat fmt =new SimpleDateFormat("yyyy-MM-dd");
        jobVo.setStartDate(fmt.parse(startDate));
        jobVo.setEndDate(fmt.parse(endDate));
        jobVo.setReason(reason);
        jobVo.setRemark(Remark);
        service.addjob(jobVo);
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter writer = response.getWriter();
        writer.print("yes");
        writer.flush();
        writer.close();
    }
    @RequestMapping(value = "/delJob")//删除工作经历
    @ResponseBody
    public void deljob(String allid,HttpServletResponse response) throws IOException, ParseException {
        service.deljob(allid);
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter writer = response.getWriter();
        writer.print("yes");
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
    @RequestMapping(value = "/addeducation")//添加或修改教育背景
    @ResponseBody
    public void addeducation(int Empid,int collegeid,String collegeName,String degree,String startDate,String endDate,String Remark,HttpServletResponse response) throws IOException, ParseException {
        EducationVo educationVo = new EducationVo();//重新拼装job对象
        educationVo.setEmpid(Empid);
        educationVo.setCollegeid(collegeid);
        educationVo.setEmpid(Empid);
        educationVo.setCollegeName(collegeName);
        educationVo.setDegree(degree);
        DateFormat fmt =new SimpleDateFormat("yyyy-MM-dd");
        educationVo.setStartDate(fmt.parse(startDate));
        educationVo.setEndDate(fmt.parse(endDate));
        educationVo.setRemark(Remark);
        service.addeducation(educationVo);
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter writer = response.getWriter();
        writer.print("yes");
        writer.flush();
        writer.close();
    }
    @RequestMapping(value = "/deleducation")//删除工作经历
    @ResponseBody
    public void deleducation(String allid,HttpServletResponse response) throws IOException, ParseException {
        service.deleducation(allid);
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter writer = response.getWriter();
        writer.print("yes");
        writer.flush();
        writer.close();
    }

    //家庭联系人
    @RequestMapping(value = "/familyInfo")//所有家庭联系人
    public void familyInfo(HttpServletResponse response,int empId) throws IOException {
        Map map = new TreeMap();
        map.put("code",0);
        map.put("msg","");
        map.put("count",1);
        map.put("data",service.familyInfo(empId));
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter writer = response.getWriter();
        writer.print(JSONArray.toJSONString(map));
        writer.flush();
        writer.close();
    }

    @RequestMapping(value = "/addfamilyInfo")//添加或修改家庭联系人
    @ResponseBody
    public void addfamilyInfo(FamilyInfoVo familyInfoVo,HttpServletResponse response) throws IOException, ParseException {
        service.addfamilyInfo(familyInfoVo);
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter writer = response.getWriter();
        writer.print("yes");
        writer.flush();
        writer.close();
    }
    @RequestMapping(value = "/delfamilyInfo")//删除家庭联系人
    @ResponseBody
    public void delfamilyInfo(String allid,HttpServletResponse response) throws IOException, ParseException {
        service.delfamilyInfo(allid);
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter writer = response.getWriter();
        writer.print("yes");
        writer.flush();
        writer.close();
    }

    //员工考核

    //证件上传
}
