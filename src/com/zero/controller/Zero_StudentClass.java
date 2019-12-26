package com.zero.controller;

import com.alibaba.fastjson.JSONArray;
import com.pluto.service.Pluto_StudentMsg;
import com.publics.service.LoggingService;
import com.publics.utills.StringUtill;
import com.publics.vo.empModel.EnrollmentVo;
import com.publics.vo.empModel.emp.EmpVo;
import com.publics.vo.studentModel.MajorVo;
import com.publics.vo.studentModel.StudentClassVo;
import com.publics.vo.studentModel.StudentFallVo;
import com.publics.vo.studentModel.StudentVo;
import com.zero.service.EmpsService;
import com.zero.service.StudentService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
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
    @Resource
    EmpsService empsService;
    @Resource
    Pluto_StudentMsg pluto;
    @Resource
    LoggingService log;
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
    public void addFall(StudentFallVo fallVo, HttpServletResponse response,HttpSession session) throws IOException {
        service.addFall(fallVo);
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter writer = response.getWriter();
        EmpVo emp = (EmpVo) session.getAttribute("admin");
        if (fallVo.getFallid()==0){
            log.addLog(emp.getEmpId(),emp.getEmpName()+"新增了届别,操作:"+fallVo.getLevel());
        }else {
            log.addLog(emp.getEmpId(),emp.getEmpName()+"修改了届别,操作:"+fallVo.getFallid());
        }
        writer.print("ok");
        writer.flush();
        writer.close();
    }

    @RequestMapping(value = "/judgeLevel")
    @ResponseBody
    public String judgeLevel(String level){//判断届别重复
        if (service.judgeLevel(level).size()>0){
            return "1";
        }
        return "0";
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
    public void deleteClass(int classId,HttpServletResponse response,HttpSession session) throws IOException {//删除班级
        service.deleteClass(classId);
        EmpVo emp = (EmpVo) session.getAttribute("admin");
        log.addLog(emp.getEmpId(),emp.getEmpName()+"删除班级,操作id:"+classId);
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
    public String addClass(StudentClassVo classVo,HttpSession session){//新增or修改班级
        EmpVo emp = (EmpVo) session.getAttribute("admin");
        if (classVo.getClassId()==0){
            log.addLog(emp.getEmpId(),emp.getEmpName()+"新增班级,操作:"+classVo.getClassName());
        }else {
            log.addLog(emp.getEmpId(),emp.getEmpName()+"修改班级,操作:"+classVo.getClassId());
        }
        service.addClass(classVo);
        return "redirect:toClass";
    }

    @RequestMapping("/toNo")
    public String toNo(){
        return "controller_pluto/NO";
    }

    @RequestMapping("/toallot")//去班级分配页面
    public String toallot(Model model,int cid){
        //班级类别
        model.addAttribute("classtype",service.classtype());
        model.addAttribute("cid",cid);//分配的班级id
        model.addAttribute("dorm",pluto.getHourList("from StudentDormitoryVo"));//宿舍
        return "student_zero/classAllot";
    }

    @RequestMapping("/allotStu")//所有要分配的学生
    @ResponseBody
    public Map allotStu(){
        Map map = new TreeMap();
        List elist = service.enroStu();
        map.put("code",0);
        map.put("msg","");
        map.put("count",elist.size());
        map.put("data",elist);
        return map;
    }

    @RequestMapping("/seekStu")//搜索学生
    @ResponseBody
    public Map seekStu(String stuname,String Phone,int ctype){
        Map map = new TreeMap();
        List stulist = service.seekStu(stuname,Phone,ctype);
        map.put("code",0);
        map.put("msg","");
        map.put("count",stulist.size());
        map.put("data",stulist);
        return map;
    }

    @RequestMapping("/entrance")//学生入学
    @ResponseBody
    public String entrance(int cid,int sid,int dorm,HttpSession session){
        //查询试学学生
        EnrollmentVo en =  service.enStu(sid);
        StudentVo stu = new StudentVo();
        stu.setStudid(0);
        stu.setStuname(en.getStudName());
        stu.setPassword("123456");
        stu.setMiddleschool(en.getSchool());
        stu.setSex(en.getSex());
        stu.setPhone(en.getTell());
        stu.setClazz(cid);
        stu.setEntertime(en.getStartTime());
        if(en.getEmpid()!=0){//介绍人
            Map map = empsService.toemp(en.getEmpid());
            stu.setIntroduretech(map.get("empName").toString());
        }else {
            stu.setIntroduretech(en.getNegativeName());
        }
        stu.setStat(en.getStatus());
        stu.setCardid(en.getCard());
        if(en.getMajorId()!=0){//就读专业
            MajorVo majorVo = service.marjov(en.getMajorId());
            stu.setProfessional(majorVo.getMajorName());//专业名称
        }
        stu.setProlevel(en.getStudType());//专业类别:1.中技  2.高技  3.3+2 4.成人教育
        stu.setStudytype(1);//是否全日制
        stu.setTuixue("否");//默认没退学
        stu.setXiuxue("否");//是否休学
        stu.setZhuxiao("是");//默认住校
        stu.setSoldier("否");//是否当兵
        stu.setCollar("否");//是否领用
        stu.setDibao("否");//低保
        stu.setComputer("是");//领电脑
        stu.setGrants("否");//助学金
        stu.setHuor(dorm);//宿舍
        pluto.addStudent(stu);//新增学生
        EmpVo emp = (EmpVo) session.getAttribute("admin");
        log.addLog(emp.getEmpId(),emp.getEmpName()+"分配了学生到"+cid+"班级id,招生id"+sid);
        return "ok";
    }
}
