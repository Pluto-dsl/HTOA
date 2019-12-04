package com.zero.controller;

import com.zero.service.EmpsService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;

@Controller
public class EmpController {
    @Resource
    EmpsService empService;

    @RequestMapping(value = "allemp")
    @ResponseBody
    public String allemp() {
        return String.valueOf(empService.selectEmp());
    }
}
