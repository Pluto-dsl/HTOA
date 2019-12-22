package com.norman.controller;

import com.alibaba.fastjson.JSONObject;
import com.norman.service.Ljw_EchartsService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Calendar;
import java.util.Date;

@Controller
@RequestMapping(value = "/echarts")
public class Ljw_EchartsController {
    @Resource
    Ljw_EchartsService service;

    @RequestMapping("/toNo")
    public String toNo(){
        return "controller_pluto/NO";
    }

    @ResponseBody
    @RequestMapping(value = "/getEmpBarData")//获取所有员工的请假次数
    public void getEmpBarData(HttpServletResponse response) throws IOException {
        response.setContentType("text/html;charset=utf-8");
        JSONObject result = service.getEmpHolidayCount();
        PrintWriter out = response.getWriter();
        out.print(result);
        out.flush();
        out.close();
    }

    @ResponseBody
    @RequestMapping(value = "/getEmpLineData")//获取所有员工的请假次数
    public void getEmpLineData(HttpServletResponse response) throws IOException {
        response.setContentType("text/html;charset=utf-8");
        JSONObject result = service.getEmpLineDataCount();
        PrintWriter out = response.getWriter();
        out.print(result);
        out.flush();
        out.close();
    }

    @ResponseBody
    @RequestMapping(value = "/getTitleBingData")//获取请假原因比例
    public void getTitleBingData(HttpServletResponse response) throws IOException {
        response.setContentType("text/html;charset=utf-8");
        JSONObject result = service.getTitleBingData();
        PrintWriter out = response.getWriter();
        out.print(result);
        out.flush();
        out.close();
    }
}
