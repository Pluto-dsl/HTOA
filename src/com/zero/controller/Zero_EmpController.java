package com.zero.controller;

import com.alibaba.fastjson.JSONArray;
import com.publics.vo.empModel.emp.EmpVo;
import com.zero.service.EmpsService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.*;

@Controller
@RequestMapping("zero")
public class Zero_EmpController {
    @Resource
    EmpsService empService;

    @RequestMapping(value = "/toemp")//所有员工资料页
    public String toemp() {//去员工资料页
        return "emp/emp";
    }

    @RequestMapping(value = "/toaddemp")//去员工修改页
    public String toaddemp(Model model) {//去新增员工页
        //查询所有部门
        model.addAttribute("dep",empService.allDep());
        return "emp/addEmp";
    }

    @RequestMapping(value = "/allemp")//展示所有员工
    @ResponseBody
    public void allemp(HttpServletResponse response) throws IOException {
        Map map = new TreeMap();
        map.put("code",0);
        map.put("msg","");
        map.put("count",1);
        map.put("data",empService.selectEmp());
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter writer = response.getWriter();
        writer.print(JSONArray.toJSONString(map));
        writer.flush();
        writer.close();
    }

    @RequestMapping(value = "/addemp")//添加修改员工
    public String addemp(EmpVo empVo){
        empVo.setStatus(1);//设置启用状态
        empVo.setPassword("123456");
        empVo.setPostId(101);
        empService.addEmp(empVo);
        return "redirect:toemp";
    }

    @RequestMapping(value = "/updateEmp")//添加修改员工
    public String updateEmp(EmpVo empVo){
        //System.out.println("修改的员工:"+empVo);
        empService.update(empVo);
        return "redirect:toemp";
    }
    @RequestMapping(value = "/deleteEmp")//添加员工
    @ResponseBody
    public String delete(int empId){
        EmpVo empVo = new EmpVo();
        empVo.setEmpId(empId);
        empService.deleteEmp(empVo);
        return "true";
    }

    @RequestMapping(value = "/toupdate/{empId}")//去修改员页
    public String toupdate(@PathVariable("empId") int empId, Model model){
        Map emp = empService.toemp(empId);//查询当前员工
        System.out.println("emp"+emp);
        //查询所有部门
        model.addAttribute("dep",empService.allDep());
        model.addAttribute("emp",emp);
        return "emp/updateEmp";
    }
}
