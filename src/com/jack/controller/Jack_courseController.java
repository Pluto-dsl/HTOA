package com.jack.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.jack.service.Jack_Service;
import com.publics.service.LoggingService;
import com.publics.vo.educ.CourseTypeVo;
import com.publics.vo.educ.CourseVo;
import com.publics.vo.empModel.emp.EmpVo;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.swing.plaf.SpinnerUI;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**  课程类别 、课程管理公用控制层  */

@Controller
@RequestMapping(value = "/jack")
public class Jack_courseController {

    @Resource
    private Jack_Service service;
    @Resource
    private LoggingService log;


    /**
     * 课程类型部分
     * */
    @RequestMapping(value = "/toCourseList")
    public String toCourse(){
        return "emp_xzq/courseTypePage";
    }

    /** 新增课程类型 */
    @RequestMapping(value = "/addCourse")
    @ResponseBody
    public int addCourse(CourseTypeVo course, HttpServletRequest request, HttpServletResponse response, HttpSession session){
         //System.out.println(course+"-------------------");
        int a = service.AddCurse(course);
        EmpVo emp = (EmpVo) session.getAttribute("admin");
        log.addLog(emp.getEmpId(),emp.getEmpName()+"新增了课程类型");
        return a;
    }

    /** 修改课程类型 */
    @RequestMapping(value = "/editCourse")
    @ResponseBody
    public int editCourse(CourseTypeVo course,HttpSession session,HttpServletRequest request, HttpServletResponse response){
         //System.out.println(course);
        int b = service.UpdateCourse(course);
        EmpVo emp = (EmpVo) session.getAttribute("admin");
        log.addLog(emp.getEmpId(),emp.getEmpName()+"修改了课程类型");
        return b;
    }

    /** 删除课程类型 */
    @RequestMapping(value = "/delCourse")
    @ResponseBody
    public int delCourse(HttpSession session,HttpServletRequest request, HttpServletResponse response){
        int cid = Integer.parseInt(request.getParameter("cid"));
         //System.out.println(cid+"=======");
        int c = service.delCourse(cid);
        EmpVo emp = (EmpVo) session.getAttribute("admin");
        log.addLog(emp.getEmpId(),emp.getEmpName()+"删除了课程类型");
        return c;
    }

    /** 查询课程类型列表 */
    @RequestMapping(value = "/courseList")
    public void courseList(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int currPage = Integer.parseInt(request.getParameter("page"));
        int pageSize = Integer.parseInt(request.getParameter("limit"));
        response.setContentType("text/html;charset=utf-8");
        List list = service.selCourse(currPage,pageSize);
        int count = service.selCouCount();
        PrintWriter out = response.getWriter();
        JSONObject json = new JSONObject();
        json.put("msg","提示");
        json.put("code","0");
        json.put("data",list);
        json.put("count",count);
        out.print(json.toJSONString());
        out.close();
    }

    /**
     * 课程管理部分
     * */
    @RequestMapping(value = "/toCourseManagement")
    public String toCourseManagement(){
        return "emp_xzq/course";
    }
    /** 查询课程类型 */
    @RequestMapping(value = "/list")
    public void list(HttpServletRequest request, HttpServletResponse response) throws IOException {
        List list = service.selCourseName();
        response.setContentType("text/html;charset=utf-8");
        PrintWriter out = response.getWriter();
        JSONObject json = new JSONObject();
        json.put("names",list);
         //System.out.println(list);
        out.print(json.toJSONString());
        out.close();
    }
    /**  添加课程 */
    @RequestMapping(value = "/addCourseMgt")
    @ResponseBody
    public String addCourseMgt(CourseVo courseVo,HttpSession session){
         //System.out.println("进来了-------------");
         //System.out.println(courseVo);
        service.addCourseMgt(courseVo);
        EmpVo emp = (EmpVo) session.getAttribute("admin");
        log.addLog(emp.getEmpId(),emp.getEmpName()+"添加了课程");
        return "";
    }
    /**  编辑课程 */
    @RequestMapping(value = "/editCourseMgt")
    public String editCourseMgt(HttpSession session,CourseVo courseVo){
        service.updateCourseMgt(courseVo);

        EmpVo emp = (EmpVo) session.getAttribute("admin");
        log.addLog(emp.getEmpId(),emp.getEmpName()+"修改了课程");
        return "emp_xzq/course";
    }
    /** 删除课程 */
    @RequestMapping(value = "/delCourseMgt")
    @ResponseBody
    public int delCourseMgt(int cid,HttpSession session){
        int d = service.delCourseMgt(cid);
        EmpVo emp = (EmpVo) session.getAttribute("admin");
        log.addLog(emp.getEmpId(),emp.getEmpName()+"删除了课程");
        return d;
    }

    /** 查询课程 */
    @RequestMapping(value = "/courseMgt")
    public void courseMgtList(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int currPage1 = Integer.parseInt(request.getParameter("page"));
        int pageSize1 = Integer.parseInt(request.getParameter("limit"));
        response.setContentType("text/html;charset=utf-8");
        List list = service.selCourseMgt(currPage1,pageSize1);
        int count = service.selCouCountM();
         //System.out.println(list.toString());
        PrintWriter out = response.getWriter();
        JSONObject json = new JSONObject();
        json.put("msg","提示");
        json.put("code","0");
        json.put("data",list);
        json.put("count",count);
        out.print(json.toJSONString());
        out.close();
    }

    @RequestMapping(value = "/Norepeat")
    @ResponseBody
    public String Norepeat(String Name,String type){
        if("course".equals(type)) {
            List list = service.selRepeatCourse(Name);
            if(list.size() > 0){
                return "1";
            }
        }else if("courseType".equals(type)){
            List list = service.selRepeatCourseType(Name);
            if(list.size() > 0){
                return "2";
            }
        }
        return "0";
    }
}
