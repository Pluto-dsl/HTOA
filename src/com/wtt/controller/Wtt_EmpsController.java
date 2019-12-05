package com.wtt.controller;

import com.alibaba.fastjson.JSONObject;
import com.publics.vo.empModel.WeeklogVo;
import com.wtt.service.Wtt_EmpService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
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
        return "emp_wtt/selectmynewpaper";
    }
    //周报查询
    @RequestMapping(value = "/selectEmpPaper")
    public void toEmpPaper(HttpServletResponse response){
        response.setContentType("text/html;charset=utf-8");
        List<Map> list = empService.weekpaper();
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("msg","提示");
        jsonObject.put("code",0);
        jsonObject.put("data",list);
        jsonObject.put("count",1);
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
        return "emp_wtt/addmynewpaper";
    }
    //新增我的周报
    @RequestMapping(value = "/addEmpPaper")
    public String addEmpPaper(WeeklogVo weeklogVo){
        weeklogVo.setWorkday(new Date());
        empService.add(weeklogVo);
        return "redirect:/emp/toEmpPaper";
    }

    //根据id查找对象
    @RequestMapping(value = "/updateEmpPaper")
    public void updateEmpPaperPage(int id,HttpServletResponse response,ModelMap modelMap){
        List list = (List) empService.wekk(id);
        System.out.println(list);/*
        modelMap.addAttribute("list",list);*/
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("list",list);
        System.out.println("aaaaaaa");
        try {
            PrintWriter pw = response.getWriter();
            pw.println(jsonObject.toJSONString());
            pw.flush();
            pw.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
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
}