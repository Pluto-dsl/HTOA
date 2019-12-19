package com.publics.controller;

import com.pluto.service.Pluto_StudentMsg;
import com.publics.vo.empModel.emp.EmpVo;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

@Controller
public class ForwordController {
    @Resource
    Pluto_StudentMsg service;

    @RequestMapping("/toPage/{path}")
    public String tomain(@PathVariable("path") String path, HttpSession session){
        /*EmpVo emp = service.getemp(13);
        session.setAttribute("admin",emp);*/
        return path;
    }
}