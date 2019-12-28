package com.norman.controller;

import com.alibaba.fastjson.JSONObject;
import com.norman.service.Ljw_EmpService;
import com.norman.service.Ljw_SystemLogService;
import com.publics.vo.empModel.emp.EmpVo;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@Controller
@RequestMapping(value = "/loa")
public class Ljw_OamainController {
    @Resource
    Ljw_SystemLogService systemLogService;

    @Resource
    private Ljw_EmpService empService;

    @RequestMapping("/toNo")
    public String toNo(){
        return "controller_pluto/NO";
    }

    @ResponseBody
    @RequestMapping(value = "/getAduitData")
    public void getAduitData(HttpSession session , HttpServletResponse response) throws IOException {
        response.setContentType("text/html;charset=utf-8");
        EmpVo emp = (EmpVo) session.getAttribute("admin");
        List list = systemLogService.getEveryListById(emp.getEmpId());
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
}
