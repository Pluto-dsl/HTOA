package com.jack.controller;

import com.alibaba.fastjson.JSONObject;
import com.jack.service.Jack_Service;
import com.publics.service.LoggingService;
import com.publics.vo.empModel.EnrollmentVo;
import com.publics.vo.empModel.emp.EmpVo;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping(value = "/jack")
public class Jack_Enrollment {

    @Resource
    private Jack_Service service;
    @Resource
    private LoggingService log;

    @RequestMapping(value = "/toEnrollment")

    public String toEnrollment(){
        EnrollmentVo enrollmentVo = new EnrollmentVo();
        return "emp_xzq/EnrollmentPage";
    }

    @RequestMapping(value = "/Enrollment")
    @ResponseBody
    public void Enrollment(HttpSession session, HttpServletResponse response, HttpServletRequest request) throws IOException {
        int currPage = Integer.parseInt(request.getParameter("page"));
        int pageSize = Integer.parseInt(request.getParameter("limit"));
        response.setContentType("text/html;charset=utf-8");
        System.out.println(currPage+"----"+pageSize);
        List list = service.selEnrollmentList(currPage,pageSize);
        int pageCount = service.selEnrollmentCount();
        PrintWriter out = response.getWriter();
        JSONObject json = new JSONObject();
        json.put("msg","提示");
        json.put("code","0");
        json.put("data",list);
        json.put("count",pageCount);
        System.out.println(json.toJSONString());
        out.print(json);
        out.close();
    }

    @RequestMapping(value = "/toAddEnrollmentPage")
    public String toAddEnrollmentPage(){
        return "emp_xzq/addEnrollmentPage";
    }

    @RequestMapping(value = "/toClassTypeList")
    @ResponseBody
    public Map toClassTypeList(){ //班级类别列表查询
        Map map = new HashMap<>();
        List list = service.selClassTypeList();
        map.put("names",list);
        return map;
    }

    @RequestMapping(value = "/toMajorList")  //专业列表查询
    @ResponseBody
    public Map toMajorList(){
        Map map = new HashMap<>();
        List list = service.selMajorList();
        map.put("names",list);
        return map;
    }

    @RequestMapping(value = "/addEnrollment")
    public String addEnrollment(EnrollmentVo enroll,HttpSession session){
        EmpVo empVo = (EmpVo) session.getAttribute("admin");
        enroll.setAmount(0);
        enroll.setEmpid(empVo.getEmpId());
        enroll.setIsClass("否");
        enroll.setSigndate(new Date());
        service.addEnrollment(enroll);

        EmpVo emp = (EmpVo) session.getAttribute("admin");
        log.addLog(emp.getEmpId(),emp.getEmpName()+"新增了招生信息");

        return "emp_xzq/EnrollmentPage";
    }

    @RequestMapping(value = "/delEnrollment")
    @ResponseBody
    public void delEnrollment(String id,HttpSession session){
        service.delEnrollment(Integer.parseInt(id));
        EmpVo emp = (EmpVo) session.getAttribute("admin");
        log.addLog(emp.getEmpId(),emp.getEmpName()+"删除了招生信息");
    }

    @RequestMapping(value = "/toEditEnrollment")
    public String toeditEnrollment(){
        return "emp_xzq/editEnrollmentPage";
    }

    @RequestMapping(value = "/EditEnrollment")
    public String EditEnrollment(EnrollmentVo enroll,HttpSession session){
        service.editEnrollment(enroll);
        EmpVo emp = (EmpVo) session.getAttribute("admin");
        log.addLog(emp.getEmpId(),emp.getEmpName()+"修改了招生信息");
        return "emp_xzq/editEnrollmentPage";
    }
}
