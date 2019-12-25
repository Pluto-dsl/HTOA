package com.pluto.controller;

import com.alibaba.fastjson.JSONArray;
import com.pluto.service.Pluto_LogService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.Map;

@Controller
@RequestMapping("/log")
public class LoggingController {

    @Resource
    Pluto_LogService service;

    @RequestMapping("/getLogData")
    @ResponseBody
    public Map getLogData(int page,int limit){
        Map m = service.getLogData("select s.*,e.empName from systemLog s INNER JOIN emp e on s.empId = e.empId",page,limit);
        return m;
    }

    @RequestMapping("/toLogList")
    public String toLogList(){
        return "log_pluto/logging";
    }


}
