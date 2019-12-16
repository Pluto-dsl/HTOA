package com.jack.controller;

import com.jack.service.Jack_Service;
import com.publics.vo.empModel.evaluationVo;
import com.publics.vo.empModel.headTeacherVo;
import com.publics.vo.empModel.teacherTotalVo;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
        evaluation.setRemark(remark);
        int a = service.addAevaluation(evaluation);
        System.out.println(a+"-===-=-=-==-=-");
        return "成功";
    }

    @RequestMapping(value = "/delEvaluation")
    @ResponseBody
    public String delEvaluation(String evaluationid){
        service.delAevaluation(Integer.parseInt(evaluationid));
        headTeacherVo head = new headTeacherVo();
        teacherTotalVo teacherTotal = new teacherTotalVo();
        return "成功";
    }

    @RequestMapping("/toTeacharEva")
    public String toTeacharEva(){
        return "emp_xzq/stu_selectWindows";
    }
}
