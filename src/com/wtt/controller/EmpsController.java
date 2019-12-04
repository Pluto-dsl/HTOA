package com.wtt.controller;

import com.wtt.service.EmpService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import java.util.List;

@Controller
@RequestMapping(name = "/emp")
public class EmpsController {
    @Resource
    EmpService empService;
    @RequestMapping(value = "/toEmppaper")
    public String toEmpPaper(ModelMap modelMap){
        List list = empService.weekpaper();

        modelMap.addAttribute("list",list);
        return "mynewpaper";
    }
}