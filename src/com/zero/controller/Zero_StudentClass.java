package com.zero.controller;

import com.publics.vo.studentModel.StudentClassVo;
import com.zero.service.StudentService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
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

    @RequestMapping(value = "/allClass")
    @ResponseBody
    public Map allClass(){//查询所有班级
        Map map = new TreeMap();
        map.put("code",0);
        map.put("msg","");
        map.put("count",1);
        map.put("data",service.allClas());
        return map;
    }

    @RequestMapping(value = "/seek")
    @ResponseBody
    public Map seek(int level){//筛选届别
        Map map = new TreeMap();
        map.put("code",0);
        map.put("msg","");
        map.put("count",1);
        map.put("data",service.seek(level));
        return map;
    }

    @RequestMapping(value = "/deleteClass")
    @ResponseBody
    public String deleteClass(int classId){//删除班级
        service.deleteClass(classId);
        return "ok";
    }

    @RequestMapping(value = "classStudent")
    @ResponseBody
    public Map classStudent(int classId){//查看当前班级的学生
        Map map = new TreeMap();
        map.put("code",0);
        map.put("msg","");
        map.put("count",1);
        map.put("data",service.classStudent(classId));
        return map;
    }

    @RequestMapping(value = "addClass")
    public String addClass(StudentClassVo classVo){//新增or修改班级
        System.out.println("新增班级:"+classVo);
        service.addClass(classVo);
        return "redirect:toClass";
    }

}
