package com.norman.controller;

import com.norman.service.LoginService;
import com.publics.service.LoggingService;
import com.publics.vo.empModel.emp.EmpVo;
import com.publics.vo.studentModel.StudentVo;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;

@Controller
public class LoginController {
    @Resource
    private LoginService loginService;


    @Resource
    private LoggingService loggingService;

    @RequestMapping("/asd/toNo")
    public String toNo(){
        return "controller_pluto/NO";
    }

    @RequestMapping(value = "/login")
    public void login(HttpServletRequest request,HttpServletResponse response,String phone, String pwd) throws IOException {
        HttpSession session = request.getSession();

        EmpVo emp = loginService.empByAcc(phone);
        StudentVo stu = loginService.stuByAcc(phone);

        PrintWriter out = response.getWriter();
        String result = "";
        if (emp != null){
            if (emp.getPassword() != null && emp.getPassword().equals(pwd)){
                if (emp.getStatus()==0){
                    result = "{\"code\":\"ban\"}";
                }else if (emp.getStatus() == 1){
                    EmpVo empVo = (EmpVo) session.getAttribute("admin");
                    loggingService.addLog(emp.getEmpId(),"登录了");
                    session.setAttribute("admin",emp);
                    result = "{\"code\":\"admin\"}";
                }
            }else {
                result = "{\"code\":\"notPwd\"}";
            }
        }else if (stu != null) {
            if (stu.getPassword() != null && stu.getPassword().equals(pwd)){
                session.setAttribute("user",stu);
                result = "{\"code\":\"user\"}";
            }else {
                result = "{\"code\":\"notPwd\"}";
            }
        }else {
            result = "{\"code\":\"notPhone\"}";
        }
        out.print(result);
        out.flush();
        out.close();
    }

    @RequestMapping(value = "/logout")
    public void logout(HttpServletRequest request,HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession();
        session.setAttribute("admin",null);
        session.invalidate();
        response.sendRedirect(request.getContextPath()+"/toPage/login");
    }
}
