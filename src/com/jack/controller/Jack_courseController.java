package com.jack.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.jack.service.Jack_Service;
import com.publics.vo.educ.CourseTypeVo;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

/**  课程类别 、课程管理公用控制层  */

@Controller
@RequestMapping(value = "/jack")
public class Jack_courseController {

    @Resource
    private Jack_Service service;

    @RequestMapping(value = "/toCourseList")
    public String toCourse(){
        return "emp_xzq/courseTypePage";
    }

    @RequestMapping(value = "/addCourse")
    @ResponseBody
    public int addCourse(CourseTypeVo course,HttpServletRequest request, HttpServletResponse response){
        System.out.println(course+"-------------------");
        int a = service.AddCurse(course);
        return a;
    }

    @RequestMapping(value = "/editCourse")
    @ResponseBody
    public int editCourse(CourseTypeVo course,HttpServletRequest request, HttpServletResponse response){
        System.out.println(course);
        int b = service.UpdateCourse(course);
        return 22222;
    }

    @RequestMapping(value = "/delCourse")
    @ResponseBody
    public int delCourse(HttpServletRequest request, HttpServletResponse response){
        int cid = Integer.parseInt(request.getParameter("cid"));
        System.out.println(cid+"=======");
        int c = service.delCourse(cid);

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
}
