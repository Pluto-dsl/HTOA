package com.jack.controller;

import com.jack.service.Jack_Service;
import com.publics.vo.empModel.evaluationVo;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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
    @RequestMapping(value = "/teacherListE")
    public String teacherListE(){
        return "";
    }

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
            List  problem = service.selHeadmasterType();
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
        List number = new ArrayList();
        List evaluationid = new ArrayList();
        for (int a=0;a<list1.length;a++){
            number.add(list1[a]);
        }
        for (int b=0;b<list2.length;b++){
            evaluationid.add(list2[b]);
        }
        System.out.println(number);
        System.out.println(evaluationid);
        return "emp_xzq/stu_selectWindows";
    }
}
