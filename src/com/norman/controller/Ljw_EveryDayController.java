package com.norman.controller;

import com.alibaba.fastjson.JSONArray;
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
import java.util.ArrayList;
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
    @RequestMapping(value = "/getEveryList")//获取员工的考勤列表
    public void getEveryList(Integer empId,HttpServletResponse response) throws IOException {
        response.setContentType("text/html;charset=utf-8");

        List<Map> list;
        if (empId ==null || empId == 0){
            list = new ArrayList<>();
        }else {
            list = systemLogService.getEveryListById(empId);
        }
        JSONObject obj = new JSONObject();
        obj.put("code",0);
        obj.put("msg","");
        obj.put("count",list.size());
        obj.put("data",list);
        PrintWriter out = response.getWriter();
        out.print(obj);
        out.flush();
        out.close();
    }

    @ResponseBody
    @RequestMapping(value = "/getImg/{aduitLogId}")//获取图片
    public void getImg(@PathVariable(value = "aduitLogId") Integer aduitLogId,HttpServletResponse response) throws IOException {
        response.setContentType("text/html;charset=utf-8");
        AduitLogVo vo = systemLogService.getAduitLog(aduitLogId);
        JSONObject obj = new JSONObject();
        JSONArray data = new JSONArray();

        JSONObject jo = new JSONObject();
        jo.put("alt","");
        jo.put("pid",666);
        jo.put("src",vo.getImage());
        jo.put("thumb",vo.getImage());
        data.add(jo);

        obj.put("title","");
        obj.put("id",123);
        obj.put("start",0);
        obj.put("data",data);

        System.out.println(obj.toJSONString());

        PrintWriter out = response.getWriter();
        out.print(obj);
        out.flush();
        out.close();
    }
}
