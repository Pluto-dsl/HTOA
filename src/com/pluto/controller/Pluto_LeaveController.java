package com.pluto.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/empLeave")
public class Pluto_LeaveController {

    @RequestMapping("/toleave")
    public String toLeave(){
        return "emp_pluto/leave";
    }


}
