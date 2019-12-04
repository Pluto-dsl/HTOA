package com.zero.controller;

import com.zero.service.EmpService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;

@Controller
public class EmpController {
    @Resource
    EmpService empService;

    @RequestMapping(value = "/allemp")
    @ResponseBody
    public String allemp() {
        return String.valueOf(empService.selectEmp());
    }
}
