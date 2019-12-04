package com.wtt.controller;

import com.publics.vo.empModel.WeeklogVo;
import com.wtt.service.Wtt_EmpService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("/emp")
public class Wtt_EmpsController {
    @Resource
    Wtt_EmpService empService;
    //去到我的周报查询主页面
    @RequestMapping(value = "/toEmpPaper")
    public String toEmpPaper(ModelMap modelMap){
        List list = empService.weekpaper();
        /*System.out.println("我的周报:"+list);*/
        modelMap.addAttribute("list",list);
        return "emp_wtt/selectmynewpaper";
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
        System.out.println("新增周报:"+weeklogVo);
        empService.add(weeklogVo);
        return "redirect:/emp/toEmpPaper";
    }

    //点击修改弹出修改页面
    @RequestMapping(value = "/updateEmpPaperPage")
    public String updateEmpPaperPage(){
        return "emp_wtt/updatemynewpaper";
    }
}