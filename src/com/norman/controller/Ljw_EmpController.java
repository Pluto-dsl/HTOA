package com.norman.controller;

import com.alibaba.fastjson.JSONObject;
import com.norman.service.Ljw_EmpService;
import com.publics.vo.empModel.ChatRecordVo;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

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
    public String getChatRecordData(HttpServletResponse response) throws IOException {
        /*List list = new ArrayList();
        ChatRecordVo c1 = new ChatRecordVo();
        c1.setChatid(1);
        c1.setSayface(2);
        c1.setTeacher(3);
        c1.setAddr("地址");
        c1.setSayscon("内容");
        list.add(c1);*/

        List<ChatRecordVo> list = empService.getChatRecordList();
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("code",0);
        jsonObject.put("msg","提示");
        jsonObject.put("count",1);
        jsonObject.put("data",list);

        response.setContentType("text/html;charset=utf-8");
        PrintWriter out = response.getWriter();
        System.out.println(jsonObject.toJSONString());
        out.print(jsonObject.toJSONString());
        out.flush();
        out.close();
        return "";
    }
}
