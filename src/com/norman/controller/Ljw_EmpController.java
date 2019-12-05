package com.norman.controller;

import com.alibaba.fastjson.JSONObject;
import com.norman.service.Ljw_EmpService;
import com.publics.vo.empModel.ChatRecordVo;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping(value = "/ljw")
public class Ljw_EmpController {
    @Resource
    private Ljw_EmpService empService;

    @RequestMapping(value = "/toChatRecordPage")
    public String toChatRecordPage(){
        return "emp_ljw/chatRecord";
    }

    @ResponseBody
    @RequestMapping(value = "/getChatRecordData")
    public String getChatRecordData(HttpServletResponse response, HttpServletRequest request) throws IOException {
        int page = Integer.parseInt(request.getParameter("page"));
        int limit = Integer.parseInt(request.getParameter("limit"));

        JSONObject jsonObject = new JSONObject();
        List<ChatRecordVo> list = empService.getChatRecordList();
        int count =empService.getChatRecordSize();
        jsonObject.put("code",0);
        jsonObject.put("msg","提示");
        jsonObject.put("count",count);
        jsonObject.put("data",list);

        response.setContentType("text/html;charset=utf-8");
        PrintWriter out = response.getWriter();
        out.print(jsonObject.toJSONString());
        out.flush();
        out.close();
        return "";
    }

    @RequestMapping(value = "/delChatRecord")
    public void delChatRecord(HttpServletResponse response,int id) throws IOException {
        empService.delChatRecord(id);
        response.setContentType("text/html;charset=utf-8");
        PrintWriter out = response.getWriter();
        out.print("1");
        out.flush();
        out.close();
    }
}
