package com.jack.controller;

import com.alibaba.fastjson.JSONObject;
import com.jack.service.Jack_Service;
/*import com.publics.vo.empModel.EnrollmentVo;*/
import com.publics.vo.empModel.emp.EmpVo;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@Controller
@RequestMapping(value = "/jack")
public class Jack_Enrollment {

    @Resource
    private Jack_Service service;

    /*@RequestMapping(value = "toEnrollment")

    public String toEnrollment(){
        EnrollmentVo enrollmentVo = new EnrollmentVo();
        return "emp_xzq/EnrollmentPage";
    }*/

    @RequestMapping(value = "Enrollment")
    @ResponseBody
    public void Enrollment(HttpSession session, HttpServletResponse response, HttpServletRequest request) throws IOException {
        int currPage = Integer.parseInt(request.getParameter("page"));
        int pageSize = Integer.parseInt(request.getParameter("limit"));
        response.setContentType("text/html;charset=utf-8");
        System.out.println(currPage+"----"+pageSize);
        List list = service.selEnrollmentList(currPage,pageSize);
        int pageCount = service.selEnrollmentCount();
        PrintWriter out = response.getWriter();
        JSONObject json = new JSONObject();
        json.put("msg","提示");
        json.put("code","0");
        json.put("data",list);
        json.put("count",pageCount);
        System.out.println(json.toJSONString());
        out.print(json);
        out.close();
    }


}
