package com.wtt.controller;

import com.wtt.service.Wtt_EmpService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import java.util.List;

@Controller
@RequestMapping(name = "/emp")
public class Wtt_EmpsController {
    @Resource
    Wtt_EmpService empService;
    @RequestMapping(value = "/toEmppaper")
    public String toEmpPaper(ModelMap modelMap){
        List list = empService.weekpaper();
        System.out.println(list);
        modelMap.addAttribute("list",list);
        return "mynewpaper";
    }
}