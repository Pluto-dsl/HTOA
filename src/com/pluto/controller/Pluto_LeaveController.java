package com.pluto.controller;

import com.alibaba.fastjson.JSONObject;
import com.pluto.service.Pluto_LeaveService;
import com.publics.vo.empModel.HolidayVo;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/empLeave")
public class Pluto_LeaveController {

    @Resource
    Pluto_LeaveService service;

    @RequestMapping("/toleave")
    public String toLeave(){
        return "emp_pluto/leave";
    }

    @RequestMapping("/addLeave")
    @ResponseBody
    public void addLeave(HttpServletResponse response,HttpServletRequest request) throws IOException {
        System.out.println("添加请假方法!");
        service.addLeave(request);
        PrintWriter out = response.getWriter();
        out.print("1");
        out.flush();
        out.close();
    }

    @RequestMapping("/returnData")
    @ResponseBody
    public void responseData(HttpServletResponse response) throws IOException {
        response.setContentType("text/html;charset=utf-8");
        String json = service.getLeaveList("select * from holiday");
        PrintWriter out = response.getWriter();
        out.print(json);
        out.close();
    }

}