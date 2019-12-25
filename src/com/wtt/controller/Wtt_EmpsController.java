package com.wtt.controller;

import com.alibaba.fastjson.JSONObject;
import com.publics.service.LoggingService;
import com.publics.vo.empModel.WeeklogVo;
import com.publics.vo.empModel.emp.EmpVo;
import com.wtt.service.Wtt_EmpService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
/*import java.util.Date;*/
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("/emp")
public class Wtt_EmpsController {
    @Resource
    Wtt_EmpService empService;
    @Resource
    private LoggingService log;
    //无权时跳转页面
    @RequestMapping("/toNo")
    public String toNo(){
        return "controller_pluto/NO";
    }

    //去到我的周报查询主页面
    @RequestMapping(value = "/toEmpPaper")
    public String toEmpPaper(){
        return "emp_wtt/selectMynewpaper";
    }
    //周报查询
    @RequestMapping(value = "/selectEmpPaper")
    public void toEmpPaper(HttpSession session,HttpServletResponse response, int page, int limit, HttpServletRequest request){
        response.setContentType("text/html;charset=utf-8");
        EmpVo empVo = (EmpVo) session.getAttribute("admin");
        int empid = empVo.getEmpId();
        //当前页
        List<WeeklogVo> list = empService.weekpaper(empid,request,page,limit);
        //获取总行数
        int rows =empService.pagecount(empid,request);
        /*System.out.println("总行数:"+rows);*/
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("msg","提示");
        jsonObject.put("code",0);
        jsonObject.put("data",list);
        jsonObject.put("count",rows);
        try {
            PrintWriter pw = response.getWriter();
            pw.print(jsonObject.toJSONString());
            pw.flush();
            pw.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    //去到我的周报新增页面
    @RequestMapping(value = "/addEmpPaperPage")
    public String addEmpPaperPage(){
        return "emp_wtt/addMynewpaper";
    }
    //新增我的周报
    @RequestMapping(value = "/addEmpPaper")
    public String addEmpPaper(HttpSession session,WeeklogVo weeklogVo){
        EmpVo empVo = (EmpVo) session.getAttribute("admin");
        int id = empVo.getEmpId();
        weeklogVo.setWorkday(new Date());
        weeklogVo.setEmpid(id);
        empService.add(weeklogVo);
        log.addLog(empVo.getEmpId(),empVo.getEmpName()+"新增了我的周报");
        return "redirect:/emp/toEmpPaper";
    }

    //修改我的周报操作
    @RequestMapping(value = "/update")
    public String update(WeeklogVo weeklogVo,HttpSession session) throws ParseException {
        EmpVo empVo = (EmpVo) session.getAttribute("admin");
        int id = weeklogVo.getWeeklogid();

        WeeklogVo weeklogVo1 = empService.weeklogvo(id);
        weeklogVo.setEmpid(weeklogVo1.getEmpid());
        weeklogVo.setWorkday(weeklogVo1.getWorkday());
        empService.update(weeklogVo);
        log.addLog(empVo.getEmpId(),empVo.getEmpName()+"修改了我的周报");
        return "redirect:/emp/toEmpPaper";
    }

    //删除
    @RequestMapping(value = "/deleteEmpPaper")
    public String deleteEmpPaperPage(HttpServletResponse response,int id,HttpSession session){
        EmpVo empVo = (EmpVo) session.getAttribute("admin");
        empService.delete(id);
        try {
            PrintWriter printWriter = response.getWriter();
            printWriter.println("");
            printWriter.flush();
            printWriter.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
        log.addLog(empVo.getEmpId(),empVo.getEmpName()+"删除了我的周报");
        return "redirect:/emp/selectEmpPaper";
    }

    //去到查看周报页面
    @RequestMapping(value = "/lookEmpPaperPage/{id}")
    public String lookEmpPaperPage(@PathVariable(value = "id") int id, ModelMap modelMap){
        modelMap.addAttribute("list",empService.wekk(id));
        return "emp_wtt/mynewpaper";
    }

    //查询当前用户信息
    @RequestMapping(value = "selectusermessage")
    public String selectusermessage(ModelMap modelMap, HttpSession session){
        //获取当前登录用户
        EmpVo empVo = (EmpVo) session.getAttribute("admin");
        int id = empVo.getEmpId();
        /*System.out.println("员工Id:"+id);*/
        String name = empService.name(id);

        List edlist = empService.edmap(id);
        List joblist = empService.jobmap(id);
        List familylist = empService.familymap(id);
        modelMap.addAttribute("list",empVo);
        modelMap.addAttribute("depname",name);
        modelMap.addAttribute("education",edlist);
        modelMap.addAttribute("joblist",joblist);
        modelMap.addAttribute("famliy",familylist);
        return "emp_wtt/userMessage";
    }
}