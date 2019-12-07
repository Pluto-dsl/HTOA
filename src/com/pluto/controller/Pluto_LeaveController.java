package com.pluto.controller;

import com.alibaba.fastjson.JSONObject;
import com.pluto.service.Pluto_LeaveService;
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
    public void addLeave(){


    }

    @RequestMapping("/returnData")
    @ResponseBody
    public void responseData(HttpServletResponse response){
        response.setContentType("text/html;charset=utf-8");
        JSONObject json = new JSONObject();
        json.put("code",0);
        json.put("msg","员工请假表");
        json.put("count",1000);
        System.out.println(json.toJSONString());
        try {
            PrintWriter out = response.getWriter();
            out.print(json.toJSONString());
            out.flush();
            out.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}