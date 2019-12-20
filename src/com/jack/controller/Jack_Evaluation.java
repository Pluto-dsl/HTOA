package com.jack.controller;

import com.alibaba.fastjson.JSONObject;
import com.jack.service.Jack_Service;
import com.publics.vo.empModel.emp.EmpVo;
import com.publics.vo.empModel.evaluationVo;
import com.publics.vo.empModel.teacherTotalVo;
import com.publics.vo.studentModel.StudentVo;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.*;

@Controller
@RequestMapping(value = "jack")
public class Jack_Evaluation {

    @Resource
    private Jack_Service service;

    @RequestMapping(value = "toEvaluationContext")
    public String toEvaluationContext(){
        return "emp_xzq/evaluation";
    }

    @RequestMapping(value = "/headmasterList")
    @ResponseBody
    public Map headmasterList(){
        Map map = new HashMap();
        List list = service.selHeadmasterList();
        map.put("msg","提示");
        map.put("code","0");
        map.put("data",list);
        return map;
    }
    @RequestMapping(value = "/teacherList")
    @ResponseBody
    public Map teacherList(){
        Map map = new HashMap();
        List list = service.selTeacherList();
        System.out.println(list+"================");
        map.put("msg","提示");
        map.put("code","0");
        map.put("data",list);
        return map;
    }

    @RequestMapping(value = "/addEvaluation")
    @ResponseBody
    public String addEvaluation(String evaluationName,String evaluationType,String remark){
        System.out.println(evaluationName+evaluationType+remark+"---------------");
        evaluationVo evaluation = new evaluationVo();
        evaluation.setEvaluationName(evaluationName);
        evaluation.setEvaluationType(Integer.parseInt(evaluationType));
        evaluation.setScore(10);
        evaluation.setIsOpen(2);
        int a = service.addAevaluation(evaluation);
        System.out.println(a+"-===-=-=-==-=-");
        return "成功";
    }

    @RequestMapping(value = "/delEvaluation")
    @ResponseBody
    public String delEvaluation(String evaluationid){
        service.delAevaluation(Integer.parseInt(evaluationid));
        return "成功";
    }

    /** 教师考评 */
    @RequestMapping(value = "toTeacherListE")
    public String toTeacherListE(){
        return "emp_xzq/teacherEvaluation";
    }
    @RequestMapping(value = "/teacherListE")
    @ResponseBody
    public void teacherListE(String Name,String duties, HttpServletRequest request, HttpServletResponse response) throws IOException {
        int currPage = Integer.parseInt(request.getParameter("page"));
        int pageSize = Integer.parseInt(request.getParameter("limit"));
        response.setContentType("text/html;charset=utf-8");
        System.out.println(Name+"fwfewf"+duties+"---------------");
        List list = service.selTeacherListE(Name,duties,currPage,pageSize);
        PrintWriter out = response.getWriter();
        JSONObject json = new JSONObject();
        json.put("msg","提示");
        json.put("code","0");
        json.put("data",list);
        json.put("count",list.size());
        System.out.println(json.toJSONString());
        out.print(json);
        out.close();
    }
    /** 考评报表 */
    @RequestMapping(value = "/toReportForm")
    public String toReportForm(){
        return "emp_xzq/ReportForm";
    }

    @RequestMapping(value = "/ReportForm")
    @ResponseBody
    public void ReportForm(HttpServletResponse response) throws IOException {
        List list = service.selReportForm();
        response.setContentType("text/html;charset=utf-8");
        PrintWriter out = response.getWriter();
        JSONObject json = new JSONObject();
        json.put("msg","提示");
        json.put("code","0");
        json.put("data",list);
        System.out.println(json.toJSONString());
        out.print(json);
        out.close();
    }


    String tid = "";
    String cid = "";
    @RequestMapping(value = "/toScoreDetails")
    public  String toScoreDetails(String teacherid,String classid){
        tid = teacherid;
        cid = classid;
        return "emp_xzq/ScoreDetails";
    }

    @RequestMapping(value = "/ScoreDetails")
    @ResponseBody
    public void ScoreDetails(HttpServletResponse response) throws IOException {
        response.setContentType("text/html;charset=utf-8");
        System.out.println(tid+"fwfewf"+cid+"---------------");
        List list = service.selScoreDetails(tid,cid);
        PrintWriter out = response.getWriter();
        JSONObject json = new JSONObject();
        json.put("msg","提示");
        json.put("code","0");
        json.put("data",list);
        System.out.println(json.toJSONString());
        out.print(json);
        out.close();
    }

    /** 学生端——教师考评 */
    @RequestMapping("/toTeacharEva")
    public String toTeacharEva(){
        return "emp_xzq/stu_selectWindows";
    }

    @RequestMapping("/toHeadmasterEva")
    public String toHeadmasterEva(HttpServletRequest request, HttpServletResponse response,HttpSession session) throws IOException {
        String type = request.getParameter("type");
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html,charset=utf-8");
        StudentVo stu = (StudentVo) session.getAttribute("user");
        //进入班主任考评
        if("Headmaster".equals(type)){
            List evaluate = service.selHeadmasterTest(stu.getStudid());
            List problem = service.selHeadmasterType();
            System.out.println(evaluate);
            Map json = new HashMap();
            for(int a=0;a<evaluate.size();a++){
                Map map=(Map)evaluate.get(a);
                json.put("empId",map.get("empId"));
                json.put("classId",map.get("classId"));
                json.put("className",map.get("className"));
                json.put("empName",map.get("empName"));
            }
            request.setAttribute("teacher","班主任");
            request.setAttribute("evaluate",json);
            System.out.println(problem);
            request.setAttribute("problem",problem);
            return "emp_xzq/HeadmasterEva";
        }else if("Teachar".equals(type)){ //进入教师考评
            List evaluate = service.selTeacherTest(stu.getStudid());
            List problem = service.selTeacherType();
            Map json = new HashMap();
            for(int a=0;a<evaluate.size();a++){
                Map map=(Map)evaluate.get(a);
                json.put("empId",map.get("empId"));
                json.put("classId",map.get("classId"));
                json.put("className",map.get("className"));
                json.put("empName",map.get("empName"));
            }
            request.setAttribute("teacher","授课老师");
            request.setAttribute("evaluate",json);
            System.out.println(problem);
            request.setAttribute("problem",problem);
            return "emp_xzq/HeadmasterEva";
        }
        return "error";
    }

    @RequestMapping(value = "/ajax")
    @ResponseBody
    public String ajax(HttpServletRequest request,HttpSession session){
        String type = request.getParameter("type");
        StudentVo stu = (StudentVo) session.getAttribute("user");
        if("headM".equals(type)){
            List list = service.selMonthly_assessment(stu.getStudid(),2);
            if(list.size() > 0){
                return "2";
            }
        }
        if("teacherM".equals(type)){
            List list = service.selMonthly_assessment(stu.getStudid(),1);
            if(list.size() > 0){
                return "1";
            }
        }
        return "";
    }
    //插入教师考评-

    @RequestMapping(value = "/ajaxEvaluate")
    public String ajaxEvaluate(HttpServletRequest request,HttpSession session){
        String [] list1  = request.getParameterValues("number");
        String [] list2  = request.getParameterValues("evaluationid");
        int classid = Integer.parseInt(request.getParameter("classid"));
        int teacherid = Integer.parseInt(request.getParameter("teacherid"));
        String sugges = request.getParameter("sugges");
        String type = request.getParameter("type");
        StudentVo stu = (StudentVo) session.getAttribute("user");
        teacherTotalVo teacher = new teacherTotalVo();
        teacher.setClassid(classid);
        teacher.setClassTeacher(teacherid);
        teacher.setSugges(sugges);
        teacher.setStudentId(stu.getStudid());
        List number = new ArrayList();
        List evaluationid = new ArrayList();
        String number1 = "";
        String evaluation = "";
        teacher.setOptime(new Date());
        if ("班主任".equals(type)){
            teacher.setEvaluationType(2);
            for (int i = 0; i < list1.length; i++) {
                number.add(list1[i]);
                evaluationid.add(list2[i]);
                System.out.println(number);
                System.out.println(evaluationid);
                evaluation = (String) evaluationid.get(i);
                number1 = (String) number.get(i);
                teacher.setTeacherScore(Integer.parseInt(number1));
                teacher.setEvaluationid(Integer.parseInt(evaluation));
                service.addHeadmaster(teacher);
                System.out.println(teacher);
            }
        }else if("授课老师".equals(type)) {
            teacher.setEvaluationType(1);
            for (int i = 0; i < list1.length; i++) {
                number.add(list1[i]);
                evaluationid.add(list2[i]);
                System.out.println(number);
                System.out.println(evaluationid);
                evaluation = (String) evaluationid.get(i);
                number1 = (String) number.get(i);
                teacher.setTeacherScore(Integer.parseInt(number1));
                teacher.setEvaluationid(Integer.parseInt(evaluation));
                service.addTeacher(teacher);
                System.out.println(teacher);
            }
        }

        return "emp_xzq/stu_selectWindows";
    }
    @RequestMapping(value = "/MyMission")
    @ResponseBody
    public Map MyMission(HttpSession session){
        EmpVo emp = (EmpVo) session.getAttribute("admin");
        Map map = new HashMap();
        int talk = service.selChatRecordCount(emp.getEmpId());
        int clock = service.selClockCount(emp.getEmpName());
        int Notice = service.selUnreadCountemp(emp.getEmpId());
        map.put("emp",0);
        map.put("stu",0);
        map.put("clock",clock);
        map.put("Notice",Notice);
        map.put("weekly","未完成");
        map.put("talk",talk);
        return map;
    }

    /** 学生端——我的公告 */
    @RequestMapping(value = "/toMyAnno")
    public String toMyAnno(Model model,HttpServletRequest request,HttpSession session){
        StudentVo stu = (StudentVo) session.getAttribute("user");
        List<Map> list = service.selNoticeList(stu.getStudid());
        model.addAttribute("list",list);
        return "emp_xzq/stu_MyAnnouncement";
    }
    @RequestMapping(value = "/MyAnno")
    @ResponseBody
    public Map MyAnno(HttpSession session){
        Map map = new HashMap();
        StudentVo stu = (StudentVo) session.getAttribute("user");
        int count = service.selNoticeCount(stu.getStudid());
        map.put("count",count);
        return map;
    }
    @RequestMapping(value = "/MyAddRead")
    @ResponseBody
    public String MyAnno(String noticeId,HttpSession session,HttpServletResponse response){
        StudentVo stu = (StudentVo) session.getAttribute("user");
        service.UpdateRead(stu.getStudid(),Integer.parseInt(noticeId));
        return noticeId;
    }

    /** 教师端——我的公告 */
    @RequestMapping(value = "/toMyAnnoEmp")
    public String toMyAnnoEmp(Model model,HttpServletRequest request,HttpSession session){
        EmpVo emp = (EmpVo) session.getAttribute("admin");
        List<Map> list = service.selNoticeListemp(emp.getEmpId());
        model.addAttribute("list",list);
        return "emp_xzq/emp_MyAnnouncement";
    }
    @RequestMapping(value = "/MyAnnoEmp")
    @ResponseBody
    public Map MyAnnoEmp(HttpSession session){
        Map map = new HashMap();
        //公告总数
        EmpVo emp = (EmpVo) session.getAttribute("admin");
        int count = service.selNoticeCountemp(emp.getEmpId());
        map.put("count",count);
        //未读取的数据
        int UnreadCount = service.selUnreadCountemp(emp.getEmpId());
        map.put("UnreadCount",UnreadCount);

        return map;
    }
    @RequestMapping(value = "/MyAddReadEmp")
    @ResponseBody
    public String MyAddReadEmp(String noticeId,HttpSession session,HttpServletResponse response){
        EmpVo emp = (EmpVo) session.getAttribute("admin");
        service.UpdateReademp(emp.getEmpId(),Integer.parseInt(noticeId));
        return noticeId;
    }
}
