package com.pluto.controller;

import com.pluto.service.Pluto_StudentMsg;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@Controller
@RequestMapping("/student")
public class Pluto_StudentController {

    @Resource
    private Pluto_StudentMsg service;

    @RequestMapping("/stuList")
    public String getStudentList(){
        return "student_pluto/student_list";
    }

    @RequestMapping("/toAddStu")
    public String toAddStudentPage(Model model){
        List clist = service.getClassList("from StudentClassVo");
        List mList = service.getMajor("from MajorVo");
        model.addAttribute("zyList",mList);
        model.addAttribute("classList",clist);
        return "student_pluto/addStudent";
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
