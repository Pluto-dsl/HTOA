package com.zero.controller;

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
        model.addAttribute("level",service.allLevel());
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

    @RequestMapping(value = "/deleteClass")
    @ResponseBody
    public String deleteClass(int classId){//删除班级
        service.deleteClass(classId);
        return "ok";
    }

}
