package com.zero.controller;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.publics.vo.empModel.emp.EmpVo;
import com.zero.service.EmpsService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.*;

@Controller
@RequestMapping("zero")
public class Zero_EmpController {
    @Resource
    EmpsService empService;

    @RequestMapping(value = "/toemp")
    public String toemp() {//去员工资料页
        return "emp/emp";
    }

    @RequestMapping(value = "/toaddemp")
    public String toaddemp() {//去新增员工页
        return "emp/addEmp";
    }

    @RequestMapping(value = "/allemp")
    @ResponseBody
    public void allemp(HttpServletResponse response) throws IOException {
        Map map = new TreeMap();
        map.put("code",0);
        map.put("msg","");
        map.put("count",1);
        map.put("data",empService.selectEmp());
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter writer = response.getWriter();
        writer.print(JSONArray.toJSONString(map));
        writer.flush();
        writer.close();
    }

    @RequestMapping(value = "/addemp")
    public String addemp(EmpVo empVo){
        empVo.setStatus(1);//设置启用状态
        empVo.setPassword("123456");
        empVo.setPostId(101);
        empService.addEmp(empVo);
        return "redirect:toemp";
    }
}
