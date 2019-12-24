package com.publics.controller;

import com.pluto.service.Pluto_StudentMsg;
import com.publics.service.LoggingService;
import com.publics.vo.empModel.emp.EmpVo;
import com.publics.vo.sys.SystemLogVo;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.net.InetAddress;
import java.net.UnknownHostException;

@Controller
public class ForwordController {

    @Resource
    private static LoggingService service;

    @RequestMapping("/toPage/{path}")
    public String tomain(@PathVariable("path") String path, HttpSession session){
        return path;
    }

    public static void addLog(SystemLogVo logVo){
        service.addLog(logVo);
    }
}