package com.norman.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping(value = "/ljw")
public class Ljw_EmpController {
    @RequestMapping(value = "/toChatRecordPage")
    public String toChatRecordPage(){
        return "emp_ljw/chatRecord";
    }
}
