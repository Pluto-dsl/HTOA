package com.wtt.controller;

import com.alibaba.fastjson.JSONObject;
import com.publics.vo.empModel.WeeklogVo;
import com.publics.vo.empModel.emp.EmpVo;
import com.publics.vo.empModel.emp.JobVo;
import com.publics.vo.sys.DepVo;
import com.wtt.service.Wtt_EmpService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
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
import java.util.Date;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/emp")
public class Wtt_EmpsController {
    @Resource
    Wtt_EmpService empService;
    //去到我的周报查询主页面
    @RequestMapping(value = "/toEmpPaper")
    public String toEmpPaper(){
        return "emp_wtt/selectMynewpaper";
    }
    //周报查询
    @RequestMapping(value = "/selectEmpPaper")
    public void toEmpPaper(HttpServletResponse response, int page, int limit, HttpServletRequest request){
        response.setContentType("text/html;charset=utf-8");
        //当前页
        List<WeeklogVo> list = empService.weekpaper(request,page,limit);
        //获取总行数
        int rows =empService.pagecount(request);
        System.out.println("总行数:"+rows);
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
    public String addEmpPaper(WeeklogVo weeklogVo){
        weeklogVo.setWorkday(new Date());
        weeklogVo.setEmpid(1);
        empService.add(weeklogVo);
        return "redirect:/emp/toEmpPaper";
    }

    //修改操作
    @RequestMapping(value = "/update")
    public String update(WeeklogVo weeklogVo){
        empService.update(weeklogVo);
        return "redirect:/emp/toEmpPaper";
    }

    //删除
    @RequestMapping(value = "/deleteEmpPaper")
    public String deleteEmpPaperPage(HttpServletResponse response,int id){
        empService.delete(id);
        try {
            PrintWriter printWriter = response.getWriter();
            printWriter.println("");
            printWriter.flush();
            printWriter.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
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
        System.out.println("员工Id:"+id);
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