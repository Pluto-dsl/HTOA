package com.zero.controller;

import com.alibaba.fastjson.JSONArray;
import com.publics.utills.StringUtill;
import com.publics.vo.studentModel.StudentClassVo;
import com.publics.vo.studentModel.StudentFallVo;
import com.zero.service.StudentService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

@Controller
@RequestMapping("zeroStudent")
public class Zero_StudentClass {
    @Resource
    StudentService service;

    @RequestMapping(value = "/toClass")
    public String toClass(Model model){//去班级管理页面
        //所有届别
        model.addAttribute("level",service.allLevel());
        //授课老师,班主任
        model.addAttribute("teacher",service.teacher());
        //班级类别
        model.addAttribute("classtype",service.classtype());
        //系名称
        model.addAttribute("dept",service.dept());
        //专业名称
        model.addAttribute("major",service.major());

        return "student_zero/studentClass";
    }

    @RequestMapping(value = "/tofall")
    public String tofall(){//去届别管理页面
        return "student_zero/studentFall";
    }

    @RequestMapping(value = "/StudentFall")
    @ResponseBody//届别表格数据
    public Map StudentFall(){
        Map map = new HashMap();
        List list = service.allLevel();
        map.put("code",0);
        map.put("msg","");
        map.put("count",list.size());
        map.put("data",list);
        return map;
    }

    @RequestMapping(value = "/allClass")
    @ResponseBody
    public Map allClass(){//查询所有班级
        Map map = new TreeMap();
        List clist = service.allClas();
        map.put("code",0);
        map.put("msg","");
        map.put("count",clist.size());
        map.put("data",clist);
        return map;
    }
    //新增或修改届别
    @RequestMapping(value = "/addFall")
    public void addFall(StudentFallVo fallVo, HttpServletResponse response) throws IOException {
        service.addFall(fallVo);
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter writer = response.getWriter();
        writer.print("ok");
        writer.flush();
        writer.close();
    }
    @RequestMapping(value = "/seek")
    @ResponseBody
    public Map seek(int level,String grade,int ctype){//筛选届别
        Map map = new TreeMap();
        List clist = service.seek(level,grade,ctype);
        map.put("code",0);
        map.put("msg","");
        map.put("count",clist.size());
        map.put("data",clist);
        return map;
    }

    @RequestMapping(value = "/deleteClass")
    @ResponseBody
    public void deleteClass(int classId,HttpServletResponse response) throws IOException {//删除班级
        service.deleteClass(classId);
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter writer = response.getWriter();
        writer.flush();
        writer.close();
        writer.write("ok");
    }

    @RequestMapping(value = "classStudent")
    @ResponseBody
    public Map classStudent(int classId){//查看当前班级的学生
        Map map = new TreeMap();
        List slist = service.classStudent(classId);
        map.put("code",0);
        map.put("msg","");
        map.put("count",slist.size());
        map.put("data",slist);
        return map;
    }

    @RequestMapping(value = "addClass")
    public String addClass(StudentClassVo classVo){//新增or修改班级
        service.addClass(classVo);
        return "redirect:toClass";
    }

    @RequestMapping("/toNo")
    public String toNo(){
        return "controller_pluto/NO";
    }

    @RequestMapping("/toallot")//去班级分配页面
    public String toallot(){
        return "student_zero/classAllot";
    }


}
