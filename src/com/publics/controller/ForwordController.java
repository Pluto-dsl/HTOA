package com.publics.controller;

import com.pluto.service.Pluto_StudentMsg;
import com.publics.service.LoggingService;
import com.publics.vo.empModel.emp.EmpVo;
import org.apache.log4j.Logger;
import com.publics.vo.sys.SystemLogVo;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.net.InetAddress;
import java.net.UnknownHostException;

@Controller
public class ForwordController {

//    @Resource
//    private static LoggingService service;

    @RequestMapping("/toPage/{path}")
    public String tomain(@PathVariable("path") String path, HttpServletRequest request, HttpServletResponse response) throws IOException {
        if ("login".equals(path) && request.getParameter("lang") == null){
            Cookie[] cookies = request.getCookies();
            for (Cookie coo:
                 cookies) {
                if ("loginSize".equals(coo.getName())){
                    String uri = request.getRequestURI();
                    uri = uri+"?lang="+coo.getValue();
                    response.sendRedirect(uri);
                }
            }
        }
        return path;
    }

//    public static void addLog(SystemLogVo logVo){
//        service.addLog(logVo);
//    }
}