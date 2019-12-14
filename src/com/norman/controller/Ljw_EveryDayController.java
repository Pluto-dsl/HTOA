package com.norman.controller;

import com.alibaba.fastjson.JSONObject;
import com.norman.service.Ljw_EmpService;
import com.norman.service.Ljw_SystemLogService;
import com.publics.vo.assess.AduitLogVo;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/systemLog")
public class Ljw_EveryDayController {
    @Resource
    Ljw_SystemLogService systemLogService;
    @Resource
    private Ljw_EmpService empService;

    @RequestMapping("/toEveryDayPage")//去往员工日常考勤
    public String toEveryDayPage(Model model){
        model.addAttribute("depList",empService.getDepList());
        return "systemLog/everyday";
    }

    @ResponseBody
    @RequestMapping("/getEveryDayData")//获取员工日常考核数据
    public void getEveryDayData(HttpServletResponse response,int page,int limit) throws IOException {
        response.setContentType("text/html;charset=utf-8");
        JSONObject result = new JSONObject();
        List<Map> list = systemLogService.getEmpList(page,limit);
        int count = systemLogService.getEmpListSize();
        result.put("code",0);
        result.put("msg","");
        result.put("count",count);
        result.put("data",list);
        PrintWriter out = response.getWriter();
        out.print(result);
        out.flush();
        out.close();
    }

    @ResponseBody
    @RequestMapping(value = "/getEveryList")
    public void getEveryList(int empId,HttpServletResponse response) throws IOException {
        response.setContentType("text/html;charset=utf-8");
        List<AduitLogVo> list = systemLogService.getEveryListById(empId) ;
        PrintWriter out = response.getWriter();
        out.print(list);
        out.flush();
        out.close();
    }
}
