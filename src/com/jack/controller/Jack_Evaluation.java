package com.jack.controller;

import com.alibaba.fastjson.JSONObject;
import com.jack.service.Jack_Service;
import com.publics.vo.empModel.evaluationVo;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
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
    public String toHeadmasterEva(HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException {
        String type = request.getParameter("type");
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html,charset=utf-8");
        //进入班主任考评
        if("Headmaster".equals(type)){
            List evaluate = service.selHeadmasterTest(2);
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
            request.setAttribute("evaluate",json);
            System.out.println(problem);
            request.setAttribute("problem",problem);
            return "emp_xzq/HeadmasterEva";
        }else if("Teachar".equals(type)){ //进入教师考评
            request.setAttribute("Te","Te");
            return "emp_xzq/HeadmasterEva";
        }
        return "error";
    }

    @RequestMapping(value = "/ajaxEvaluate")
    public String ajaxEvaluate(HttpServletRequest request){
        String [] list1  = request.getParameterValues("number");
        String [] list2  = request.getParameterValues("evaluationid");
        String classid = request.getParameter("classid");
        String teacherid = request.getParameter("teacherid");
        String sugges = request.getParameter("sugges");
        List number = new ArrayList();
        List evaluationid = new ArrayList();
        for (int i=0;i<list1.length;i++){
            number.add(list1[i]);
            evaluationid.add(list2[i]);

        }
        System.out.println(number+"----------------");
        System.out.println(evaluationid);
        System.out.println(classid);
        System.out.println(teacherid);
        System.out.println(sugges);
        return "emp_xzq/stu_selectWindows";
    }
}
