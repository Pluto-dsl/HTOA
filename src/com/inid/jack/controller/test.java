package com.inid.jack.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/my/test")
public class test {

    @RequestMapping("/toTest")
    public String toTest(){
        return "test";
    }
}
