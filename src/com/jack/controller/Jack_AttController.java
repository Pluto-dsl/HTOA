package com.jack.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/test1")
public class Jack_AttController {

    @RequestMapping("/toTest1")
    public String toTest1(){
        return "test1";
    }

    @RequestMapping("/toMain")
    public String toMain(){
        return "oamain";
    }

}
