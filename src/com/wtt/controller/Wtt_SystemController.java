package com.wtt.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/system")
public class Wtt_SystemController {
    @RequestMapping(value = "/systemPage")
    public String systemPage(){
        return "emp_wtt/system_set";
    }
}