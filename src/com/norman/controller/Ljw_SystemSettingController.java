package com.norman.controller;

import com.alibaba.fastjson.JSONObject;
import com.norman.service.Ljw_sysSetService;
import com.publics.service.LoggingService;
import com.publics.vo.empModel.emp.EmpVo;
import com.publics.vo.studentModel.MajorVo;
import com.publics.vo.studentModel.TermVo;
import com.publics.vo.sys.DeptVo;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;

@Controller
@RequestMapping(value = "/sysSet")
public class Ljw_SystemSettingController {
    @Resource
    private Ljw_sysSetService service;

    @Resource
    private LoggingService loggingService;

    @RequestMapping("/toNo")
    public String toNo(){
        return "controller_pluto/NO";
    }

    @RequestMapping(value = "/toDeptList")
    public String toDeptList(){
        return "systemSet_ljw/deptList";
    }

    @RequestMapping(value = "/toMajorPage")
    public String toMajorPage(Model model){
        model.addAttribute("list",service.selDeptList());
        return "systemSet_ljw/majorList";
    }

    @RequestMapping(value = "/toTermPage")
    public String toTermPage(){
        return "systemSet_ljw/termList";
    }

    /*
    * 院系设置
    * */

    @RequestMapping(value = "/newDept")
    public String newDept(HttpServletRequest request,Integer deptIds, DeptVo vo){
        HttpSession session = request.getSession();
        EmpVo empVo = (EmpVo) session.getAttribute("admin");
        if (deptIds != null && deptIds != 0){
            vo.setDeptid(deptIds);
            service.updDept(vo);
            loggingService.addLog(empVo.getEmpId(),"更新了一条院系数据");
        }else {
            service.insDept(vo);
            loggingService.addLog(empVo.getEmpId(),"添加了一条院系数据");
        }
        return "redirect:/sysSet/toDeptList";
    }

    @ResponseBody
    @RequestMapping(value = "/getDeptData")
    public void getDeptData(HttpServletResponse response,int page ,int limit) throws IOException {
        response.setContentType("text/html;charset=utf-8");
        JSONObject result = new JSONObject();
        result.put("code",0);
        result.put("msg","成功");
        result.put("count",service.selDeptSize());
        result.put("data",service.selDeptList(page,limit));

        PrintWriter out = response.getWriter();
        out.print(result);
        out.flush();
        out.close();
    }

    @ResponseBody
    @RequestMapping(value = "/delDept")
    public void delDept(HttpServletRequest request,HttpServletResponse response,int id) throws IOException {
        HttpSession session = request.getSession();
        EmpVo empVo = (EmpVo) session.getAttribute("admin");
        String result = service.delDept(id);
        if (!"isUsed".equals(result)){
            loggingService.addLog(empVo.getEmpId(),"刪除了一条院系数据");
        }
        response.setContentType("text/html;charset=utf-8");
        PrintWriter out = response.getWriter();
        out.print(result);
        out.flush();
        out.close();
    }

    /*
    * 专业设置
    * */

    @ResponseBody
    @RequestMapping(value = "/getMajorData")
    public void getMajorData(HttpServletResponse response,int page ,int limit) throws IOException {
        response.setContentType("text/html;charset=utf-8");
        JSONObject result = new JSONObject();
        result.put("code",0);
        result.put("msg","成功");
        result.put("count",service.selMajorSize());
        result.put("data",service.selMajorList(page,limit));

        PrintWriter out = response.getWriter();
        out.print(result);
        out.flush();
        out.close();
    }

    @RequestMapping(value = "/newMajor")
    public String newMajor(HttpServletRequest request,Integer majorids, MajorVo vo){
        HttpSession session = request.getSession();
        EmpVo empVo = (EmpVo) session.getAttribute("admin");
        if (majorids != null && majorids != 0){
            vo.setMajorid(majorids);
            service.updMajor(vo);
            loggingService.addLog(empVo.getEmpId(),"修改了一条专业数据");
        }else {
            service.insMajor(vo);
            loggingService.addLog(empVo.getEmpId(),"添加了一条专业数据");
        }
        return "redirect:/sysSet/toMajorPage";
    }

    @ResponseBody
    @RequestMapping(value = "/delMajor")
    public void delMajor(HttpServletRequest request,HttpServletResponse response,int id) throws IOException {
        HttpSession session = request.getSession();
        EmpVo empVo = (EmpVo) session.getAttribute("admin");
        String result = service.delMajor(id);
        if (!"isUsed".equals(result)){
            loggingService.addLog(empVo.getEmpId(),"删除了一条专业数据");
        }
        response.setContentType("text/html;charset=utf-8");
        PrintWriter out = response.getWriter();
        out.print(result);
        out.flush();
        out.close();
    }

    /*
    * 学期设置
    * */
    @RequestMapping(value = "/newTerm")
    public String newTerm(HttpServletRequest request,Integer termIds, TermVo vo){
        HttpSession session = request.getSession();
        EmpVo empVo = (EmpVo) session.getAttribute("admin");
        if (termIds != null && termIds != 0){
            vo.setTermid(termIds);
            service.updTerm(vo);
            loggingService.addLog(empVo.getEmpId(),"修改了一条学期数据");
        }else {
            service.insTerm(vo);
            loggingService.addLog(empVo.getEmpId(),"添加了一条学期数据");
        }
        return "redirect:/sysSet/toTermPage";
    }
    @ResponseBody
    @RequestMapping(value = "/getTermData")
    public void getTermData(HttpServletResponse response,int page ,int limit) throws IOException {
        response.setContentType("text/html;charset=utf-8");
        JSONObject result = new JSONObject();
        result.put("code",0);
        result.put("msg","成功");
        result.put("count",service.selTermSize());
        result.put("data",service.selTermList(page,limit));

        PrintWriter out = response.getWriter();
        out.print(result);
        out.flush();
        out.close();
    }

    @ResponseBody
    @RequestMapping(value = "/delTerm")
    public void delTerm(HttpServletRequest request,HttpServletResponse response,int id) throws IOException {
        HttpSession session = request.getSession();
        EmpVo empVo = (EmpVo) session.getAttribute("admin");
        String result = service.delTerm(id);
        if (!"isUsed".equals(result)){
            loggingService.addLog(empVo.getEmpId(),"删除了一条学期数据");
        }
        response.setContentType("text/html;charset=utf-8");
        PrintWriter out = response.getWriter();
        out.print(result);
        out.flush();
        out.close();
    }

    @ResponseBody
    @RequestMapping(value = "/getTeamName")
    public String getTeamName(String teamName , HttpServletResponse response){
        response.setContentType("text/html;charset=utf-8");
        int size = service.selTermName(teamName);
        if (size >= 1){
            return "true";
        }else {
            return "false";
        }
    }
}
