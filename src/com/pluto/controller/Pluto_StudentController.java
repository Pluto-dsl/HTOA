package com.pluto.controller;

import com.pluto.service.Pluto_StudentMsg;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@Controller
@RequestMapping("/student")
public class Pluto_StudentController {

    @Resource
    private Pluto_StudentMsg service;

    @RequestMapping("/stuList")
    public String getStudentList(){
        return "student_pluto/student_list";
    }

    @RequestMapping("/returnData")
    @ResponseBody
    public void getList(HttpServletResponse response) throws IOException {
        response.setContentType("text/html;charset=utf-8");
        String json = service.getStudentList("select * from student");
        PrintWriter pw = response.getWriter();
        pw.print(json);
        pw.close();
    }
}
