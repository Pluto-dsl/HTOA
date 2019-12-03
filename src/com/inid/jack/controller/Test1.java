package com.inid.jack.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/test1")
public class Test1 {

    @RequestMapping("/toTest1")
    public String toTest1(){
        return "test1";
    }

}
