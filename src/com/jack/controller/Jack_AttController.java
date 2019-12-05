package com.jack.controller;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.jack.service.AttService;
import com.publics.vo.empModel.AttendanceVo;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@Controller
@RequestMapping("/jack")
public class Jack_AttController {

    @Resource
    private AttService service;

    @RequestMapping("/toAtt")
    public String toTest1(){
        return "emp_xzq/AttendancePage";
    }

    @RequestMapping("/test")
    public String test(){
        return "emp_xzq/xxx";
    }

    @RequestMapping("/Attadd")
    public String Attadd(AttendanceVo att,String timeing){
        System.out.println(att);
        System.out.println(timeing);
        return "";
    }
    @RequestMapping("/Att")
    @ResponseBody
    public void Att(HttpServletResponse response, HttpServletRequest request) throws IOException {
        int currPage = Integer.parseInt(request.getParameter("page"));
        int pageSize = Integer.parseInt(request.getParameter("limit"));
        List list = service.selAtt(currPage,pageSize);
        int pageCount = service.selAttCount();

        response.setContentType("text/json;charset=utf-8");
        PrintWriter out = response.getWriter();
        JSONObject json = new JSONObject();
        json.put("msg","提示");
        json.put("code","0");
        json.put("data",list);
        json.put("count",pageCount);
        System.out.println(json.toJSONString());
        out.print(json);

    }

}
