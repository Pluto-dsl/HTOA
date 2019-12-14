package com.zero.controller;


import com.zero.service.StudentScoreService;
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
@RequestMapping("StudentScore")
public class Zero_StudentScore {
    @Resource
    StudentScoreService service;
    @Resource
    StudentService studentService;
    @RequestMapping(value = "/toreply")
    public String toreply(Model model){//去答辩成绩页
        //所有项目名称
        model.addAttribute("project",service.allProject());
        //班级名称
        model.addAttribute("claes",service.allclass());
        //评分人员
        model.addAttribute("teacher",studentService.teacher());

        return "student_zero/ReplyScore";
    }

    @RequestMapping(value = "/replyScore")
    @ResponseBody
    public Map replyScore(int page,int limit){//分页
        List<Map> list = service.ReplyScore(page,limit);
        Map map = new TreeMap();
        map.put("code",0);
        map.put("msg","");
        map.put("count",service.pagecount());
        map.put("data",list);
        return map;
    }

    @RequestMapping(value = "/seek")
    @ResponseBody
    public Map seek(int projectId,int classId,int empId,int page,int limit){//条件搜索加分页
        String sql = "";
        if (classId!=0){
            sql+=" and sc.classId = "+classId;
        }
        if (empId!=0){
            sql+=" and sr.empId = "+empId;
        }
        if (projectId!=0){
            sql+=" and p.projectId = "+projectId;
        }
        List<Map> list = service.ReplyScore(sql,page,limit);
        Map map = new TreeMap();
        map.put("code",0);
        map.put("msg","");
        map.put("count",service.pagecount(sql));
        map.put("data",list);
        return map;
    }


    @RequestMapping(value = "/toscore")
    public String toscore(Model model){//去考试成绩
        //班级名称
        model.addAttribute("claes",service.allclass());
        //在读学期
        model.addAttribute("term",service.term());
        //课程名称
        model.addAttribute("course",service.course());
        return "student_zero/score";
    }

    @RequestMapping(value = "/score")
    @ResponseBody
    public Map score(int page,int limit){//学生成绩
        List<Map> list = service.score(page,limit);
        Map map = new TreeMap();
        map.put("code",0);
        map.put("msg","");
        map.put("count",service.scorecount());
        map.put("data",list);
        return map;
    }

    @RequestMapping(value = "/scoreseek")
    @ResponseBody
    public Map seek(int term,int classId,int type,int course,int page,int limit){//分页
        System.out.println("进入方法");
        String sql = "";
        if (classId!=0){
            sql+=" and s.clazz = "+classId;
        }
        if (type!=0){
            sql+=" and sc.testType = "+type;
        }
        if (term!=0){
            sql+=" and t.termid = "+term;
        }
        if (course!=0){
            sql+=" and sc.courseId = "+course;
        }

        List<Map> list = service.score(sql,page,limit);
        Map map = new TreeMap();
        map.put("code",0);
        map.put("msg","");
        map.put("count",service.scorepagecount(sql));
        map.put("data",list);
        return map;
    }
}
