package com.zero.controller;


import com.alibaba.fastjson.JSONArray;
import com.publics.vo.empModel.emp.EmpVo;
import com.publics.vo.studentModel.ReplyScoreVo;
import com.publics.vo.studentModel.StudentScoreVo;
import com.zero.service.StudentScoreService;
import com.zero.service.StudentService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
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

    @RequestMapping(value = "/havescore")
    @ResponseBody
    public void havescore(int classid, int courseid, int scoreType, int termid, HttpServletResponse response) throws IOException {//去新增成绩页
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter writer = response.getWriter();
        //查询此班是否有成绩
        int i = service.haveScore(classid,courseid,scoreType,termid);
        if(i>0){//有成绩
            writer.write("no");
        }else {//没有成绩
            writer.write("ok");
        }
    }

    @RequestMapping(value = "/haveReplyscore")
    @ResponseBody
    public void havescore(int classid, int projectId, HttpServletResponse response) throws IOException {//去新增成绩页
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter writer = response.getWriter();
        //查询此班是否有成绩
        int i = service.haveReplyScore(classid,projectId);
        if(i>0){//有成绩
            writer.write("have");
        }else {//没有成绩
            writer.write("no");
        }
    }
    @RequestMapping(value = "/toaddscore")//去新增学生成绩页
    public String toaddscore(int classid, int courseid, int scoreType, int termid, String scoreTime, Model model) throws ParseException {//去新增成绩页
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        Date date = sdf.parse(scoreTime);
        model.addAttribute("scoreTime",date.getTime());//考试时间
        model.addAttribute("stu", JSONArray.toJSONString(service.stu(classid)));//学生信息
        model.addAttribute("course",service.nowcourse(courseid));//课程
        model.addAttribute("term",service.nowterm(termid));//学期
        model.addAttribute("scoreType",scoreType);//考试类别
        return "student_zero/addscore";
    }

    @RequestMapping(value = "/toaddReply")//去新增学生答辩成绩页
    public String toaddReply(int classid, int projectId, Model model) throws ParseException {//去新增成绩页
        model.addAttribute("stu", JSONArray.toJSONString(service.stu(classid)));//学生信息
        model.addAttribute("project",service.nowproject(projectId));//项目
        model.addAttribute("teacher",studentService.teacher());//评分人员
        return "student_zero/addReply";
    }

    @RequestMapping(value = "/toeditscore")//去编辑学生成绩页
    public String toeditscore(int classid, int courseid, int scoreType, int termid, Model model) throws ParseException {
        model.addAttribute("stu", JSONArray.toJSONString(service.toeditScore(classid,courseid,scoreType,termid)));//学生成绩信息
        model.addAttribute("course",service.nowcourse(courseid));//课程
        model.addAttribute("term",service.nowterm(termid));//学期
        model.addAttribute("scoreType",scoreType);//考试类别
        return "student_zero/editscore";
    }

    @RequestMapping(value = "/addscore")
    @ResponseBody//去新增成绩页
    public void toaddscore(float score, String Rescore,String remark,int courseId,String testType, int termid, String scoreTime,int Studid, HttpServletResponse response, HttpSession session) throws ParseException, IOException {
        String sql = "(0,";
        sql+=((EmpVo) session.getAttribute("admin")).getEmpId(); //session获取录入人员
        sql+=(1+",");
        if (Rescore!=""){
            sql+=(Rescore+",");
        }else {
            sql+="null,";
        }
        sql+=(courseId+",");
        sql+=("'"+remark+"',");
        sql+=(score+",");
        sql+=("'"+scoreTime+"',");
        sql+=(Studid+",");
        sql+=(termid+",");
        sql+=(testType+")");
        service.addscore(sql);
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter writer = response.getWriter();
        writer.write("ok");
    }

    @RequestMapping(value = "/addReplyScore")
    @ResponseBody//去新增成绩页
    public void toaddscore(ReplyScoreVo scoreVo, HttpServletResponse response) throws ParseException, IOException {
        scoreVo.setScore7(scoreVo.getScore1()+scoreVo.getScore2()+scoreVo.getScore3()+scoreVo.getScore4()+scoreVo.getScore5()+scoreVo.getScore6());
        service.addReplyscore(scoreVo);
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter writer = response.getWriter();
        writer.write("ok");
    }

    @RequestMapping(value = "/toeditReply")//去修改学生答辩成绩页
    public String toeditscore(int classid,int projectId, Model model) throws ParseException {
        List<Map> tea =  service.toeditReplyscore(classid,projectId);//成绩数据
        model.addAttribute("stu",JSONArray.toJSONString(tea));
        model.addAttribute("cls",service.nowclass(classid));//班级信息
        model.addAttribute("project",service.nowproject(projectId));//项目信息
        //评分人员
        model.addAttribute("emp",tea.get(0).get("empId"));
        model.addAttribute("teacher",studentService.teacher());
        return "student_zero/editReply";
    }

    @RequestMapping(value = "/editscore")
    @ResponseBody//修改学生答辩成绩
    public void editscore(String res,StudentScoreVo studentScoreVo, HttpServletResponse response, HttpSession session) throws ParseException, IOException {//去新增成绩页
        //studentScoreVo.setEmpid(1);//从session里获取
        studentScoreVo.setEmpid(((EmpVo) session.getAttribute("admin")).getEmpId());//从session里获取
        if("".equals(res)){
            res="null";
        }
        service.editscore(res,studentScoreVo);
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter writer = response.getWriter();
        writer.write("ok");
    }

    @RequestMapping(value = "/editReplyscore")
    @ResponseBody
    public void editReply(ReplyScoreVo scoreVo,HttpServletResponse response) throws ParseException, IOException {//修改答辩成绩页
        scoreVo.setScore7(scoreVo.getScore1()+scoreVo.getScore2()+scoreVo.getScore3()+scoreVo.getScore4()+scoreVo.getScore5()+scoreVo.getScore6());
        service.editReply(scoreVo);
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter writer = response.getWriter();
        writer.write("ok");
    }

}
