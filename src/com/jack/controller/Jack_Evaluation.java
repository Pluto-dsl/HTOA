package com.jack.controller;

import com.jack.service.Jack_Service;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;

@Controller
@RequestMapping(value = "jack")
public class Jack_Evaluation {

    @Resource
    private Jack_Service service;

    @RequestMapping(value = "toEvaluationContext")
    public String toEvaluationContext(){
        return "emp_xzq/evaluation";
    }
}
