package com.wtt.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/system")
public class Wtt_SystemController {
    //无权时跳转页面
    @RequestMapping("/toNo")
    public String toNo(){
        return "controller_pluto/NO";
    }

    @RequestMapping(value = "/systemPage")
    public String systemPage(){
        return "emp_wtt/system_set";
    }
}