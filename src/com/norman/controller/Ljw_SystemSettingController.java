package com.norman.controller;

import com.alibaba.fastjson.JSONObject;
import com.norman.service.Ljw_sysSetService;
import com.publics.vo.studentModel.MajorVo;
import com.publics.vo.sys.DeptVo;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@Controller
@RequestMapping(value = "/sysSet")
public class Ljw_SystemSettingController {
    @Resource
    private Ljw_sysSetService service;

    @RequestMapping(value = "/toMajorPage")
    public String toMajorPage(Model model){
        model.addAttribute("list",service.selDeptList());
        return "systemSet_ljw/majorList";
    }

    @RequestMapping(value = "/toDeptList")
    public String toDeptList(){
        return "systemSet_ljw/deptList";
    }

    /*
    * 院系设置
    * */

    @RequestMapping(value = "/newDept")
    public String newDept(Integer deptIds,DeptVo vo){
        if (deptIds != null && deptIds != 0){
            vo.setDeptid(deptIds);
            service.updDept(vo);
        }else {
            service.insDept(vo);
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

    @RequestMapping(value = "/delDept")
    public void delDept(HttpServletResponse response,int id) throws IOException {
        service.delDept(id);
        response.setContentType("text/html;charset=utf-8");
        PrintWriter out = response.getWriter();
        out.print("200");
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
    public String newMajor(Integer majorids, MajorVo vo){
        if (majorids != null && majorids != 0){
            vo.setMajorid(majorids);
            service.updMajor(vo);
        }else {
            service.insMajor(vo);
        }
        return "redirect:/sysSet/toMajorPage";
    }
}
