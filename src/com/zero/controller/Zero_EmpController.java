package com.zero.controller;

import com.alibaba.fastjson.JSONArray;
import com.publics.service.LoggingService;
import com.publics.vo.empModel.WeeklogVo;
import com.publics.vo.empModel.emp.EmpVo;
import com.publics.utills.StringUtill;
import com.zero.service.EmpsService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.*;

@Controller
@RequestMapping("zeroEmp")
public class Zero_EmpController {
    @Resource
    EmpsService empService;
    @Resource
    LoggingService log;
    @RequestMapping(value = "/toemp")//所有员工资料页
    public String toemp(Model model) {//去员工资料页
        //查询所有部门
        model.addAttribute("dep",empService.allDep());
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
        List elist = empService.selectEmp();
        map.put("code",0);
        map.put("msg","");
        map.put("count",elist.size());
        map.put("data",elist);
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter writer = response.getWriter();
        writer.print(JSONArray.toJSONString(map));
        writer.flush();
        writer.close();
    }

    @RequestMapping(value = "/addemp")//添加员工
    public String addemp(EmpVo empVo,HttpSession session){
        empVo.setEmpId(0);
        empVo.setStatus(1);//设置启用状态
        empVo.setPassword("123456");
        empVo.setPostId(101);
        empService.addEmp(empVo);
        //保存日志
        EmpVo emp = (EmpVo) session.getAttribute("admin");
        log.addLog(emp.getEmpId(),emp.getEmpName()+"新增了一个员工:"+empVo.getEmpName());
        return "redirect:toemp";
    }

    @RequestMapping(value = "/updateEmp")//修改员工
    public String updateEmp(EmpVo empVo,HttpSession session){
        empService.update(empVo);
        //保存日志
        EmpVo emp = (EmpVo) session.getAttribute("admin");
        log.addLog(emp.getEmpId(),emp.getEmpName()+"修改员工资料:"+empVo.getEmpName());
        return "redirect:toemp";
    }
    @RequestMapping(value = "/deleteEmp")//删除员工
    @ResponseBody
    public String delete(int empId,String depName,String empName,HttpSession session){
        EmpVo empVo = new EmpVo();//员工
        empVo.setEmpId(empId);
        int flag=0;
        int depI = empService.selDep(empName,depName);//查部门
        int stuClassI = empService.selStudentClass(empId);//查询班级中的职务

        if(depI>0){
            flag+=1;
        }
        if(stuClassI >0){
            flag+=1;
        }
        if(flag>0){
            return "0";
        }else{
            empService.deleteWeekLog(empId);//删除周报
            empService.deleteWeekArrange(empId);//删除值班管理
            empService.deleteChatRecord(empId);//删除谈心记录
            empService.deleteAssTotal(empId);//删除考核
            empService.deleteEmp(empVo);//删除员工表中的数据

            //保存日志
            EmpVo emp = (EmpVo) session.getAttribute("admin");
            log.addLog(emp.getEmpId(),emp.getEmpName()+"删除了一条员工资料id为:"+empId);
            return "1";
        }
    }

    @RequestMapping(value = "/toupdate/{empId}")//去修改员页
    public String toupdate(@PathVariable("empId") int empId, Model model){
        Map emp = empService.toemp(empId);//查询当前员工
        //查询所有部门
        model.addAttribute("dep",empService.allDep());
        model.addAttribute("emp",emp);
        return "emp/updateEmp";
    }

    @RequestMapping(value = "/resetPwd/{empId}")//重置密码
    @ResponseBody
    public String resetPwd(@PathVariable("empId") int empId,HttpSession session){
        empService.resetPwd(empId);
        //保存日志
        EmpVo emp = (EmpVo) session.getAttribute("admin");
        log.addLog(emp.getEmpId(),emp.getEmpName()+"重置员工的密码,id:"+empId);
        return "true";
    }
    @RequestMapping(value = "/seek")
    @ResponseBody//根据条件搜索员工
    public void seek(int depId,String empName,String Phone,int status,HttpServletResponse response) throws IOException {
        String tiaojian = "where 1=1 ";
        empName = StringUtill.tostring(empName);
        //拼装搜索条件
        if (depId!=0){
            tiaojian += " and e.depId = "+depId;
        }
        if(!"".equals(empName)){
            tiaojian +=" and e.empName like '%"+empName+"%'";
        }
        if(!"".equals(Phone)){
            tiaojian +=" and e.Phone like '%"+Phone+"%'";
        }
        if(status!=100){
            tiaojian += " and e.status = "+status;
        }
        List tlist =  empService.seekEmp(tiaojian);
        Map map = new TreeMap();
        map.put("code",0);
        map.put("msg","");
        map.put("count",tlist.size());
        map.put("data",tlist);
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter writer = response.getWriter();
        writer.print(JSONArray.toJSONString(map));
        writer.flush();
        writer.close();
    }
    @RequestMapping(value = "/status")
    @ResponseBody
    public void status(int empId,HttpSession session){//修改员工状态
        //先查询当前用户的状态
        int state = empService.statue(empId) == 1?0:1;
        //保存日志
        EmpVo emp = (EmpVo) session.getAttribute("admin");
        log.addLog(emp.getEmpId(),emp.getEmpName()+"修改了员工状态,id为:"+empId);
        //修改状态
        empService.status(state,empId);
    }

    @RequestMapping(value = "/editpwd")
    public void editpsd(String pwd,String pwd1,HttpSession session,HttpServletResponse response) throws IOException {//修改员工密码
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter writer = response.getWriter();
        //输入的原密码是否正确
        EmpVo emp =(EmpVo)session.getAttribute("admin");
        if(!pwd.equals(emp.getPassword())){//原密码错误
            log.addLog(emp.getEmpId(),emp.getEmpName()+"修改了一次密码,失败了!");
            writer.print("error");
            writer.flush();
            writer.close();
        }else {//密码正确
            log.addLog(emp.getEmpId(),emp.getEmpName()+"修改了一次密码,成功了!");
            empService.updatePwd(emp.getEmpId(),pwd1);
        }
        writer.print("ok");
        writer.flush();
        writer.close();
    }


    @RequestMapping("/toNo")
    public String toNo(){
        return "controller_pluto/NO";
    }
}
