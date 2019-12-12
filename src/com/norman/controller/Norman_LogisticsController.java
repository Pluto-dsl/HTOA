package com.norman.controller;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.norman.service.Ljw_LogsService;
import com.publics.vo.logistics.EquipmentRepairVo;
import org.hibernate.Session;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;

@Controller
@RequestMapping(value = "/logs")
public class Norman_LogisticsController {
    @Resource
    private Ljw_LogsService logsService;
    /**
     * 保修申请相关方法
     * */
    @RequestMapping(value = "/toMyRepair")
    public String toMyRepair(){
        return "repair_ljw/myRepair";
    }
    @RequestMapping(value = "/addRepair")
    public String addRepair(HttpServletRequest request,String equipmentType,String remark){
        HttpSession session = request.getSession();
        session.setAttribute("user",1);
        int user = (int) session.getAttribute("user");
        int depId = logsService.getEmpVo(user).getDepId();
        EquipmentRepairVo repair = new EquipmentRepairVo();
        repair.setEquipmentType(equipmentType);
        repair.setRemark(remark);
        repair.setStudent(user);
        repair.setStatus(0);
        repair.setDepId(depId);
        repair.setUserType(2);
        repair.setStartTime(new Date());
        logsService.newRepair(repair);
        return "redirect:/logs/toMyRepair";
    }

    @ResponseBody
    @RequestMapping(value = "/getEmpRepairData")
    public void getEmpRepairData(HttpServletResponse response,HttpServletRequest request,int page,int limit) throws IOException {
        int count;
        JSONArray data;
        System.out.println("员工");
        count = logsService.getRepairSize(2);
        data = logsService.getRepairData(request,2,page,limit);

        response.setContentType("text/html;charset=utf-8");
        PrintWriter out = response.getWriter();
        JSONObject result = new JSONObject();
        result.put("code",0);
        result.put("count",count);
        result.put("msg","提示");
        result.put("data",data);
        out.print(result.toJSONString());
        out.flush();
        out.close();
    }

    @ResponseBody
    @RequestMapping(value = "/getStuRepairData")
    public void getStuRepairData(HttpServletResponse response,HttpServletRequest request,int page,int limit) throws IOException {
        int count;
        JSONArray data;
        System.out.println("学生");
        count = logsService.getRepairSize(1);
        data = logsService.getRepairData(request,1,page,limit);
        response.setContentType("text/html;charset=utf-8");
        PrintWriter out = response.getWriter();
        JSONObject result = new JSONObject();
        result.put("code",0);
        result.put("count",count);
        result.put("msg","提示");
        result.put("data",data);
        out.print(result.toJSONString());
        out.flush();
        out.close();
    }

    @ResponseBody
    @RequestMapping(value = "/getMyRepairData")
    public void getMyRepairData(HttpServletResponse response,HttpServletRequest request,int page,int limit) throws IOException {
        int user = 1;
        response.setContentType("text/html;charset=utf-8");
        PrintWriter out = response.getWriter();
        JSONObject result = new JSONObject();
        result.put("code",0);
        result.put("count",logsService.getMyEmpRepairSize(user));
        result.put("msg","提示");
        result.put("data",logsService.getMyEmpRepairData(request,user,page,limit));
        out.print(result.toJSONString());
        out.flush();
        out.close();
    }
    @ResponseBody
    @RequestMapping(value = "/manageRepair")
    public void updRepair(int repairId,String result){
        System.out.println(repairId);
        System.out.println(result);
        EquipmentRepairVo vo = logsService.getRepair(repairId);
        System.out.println(vo);
        vo.setStatus(1);
        vo.setEndTime(new Date());
        vo.setResult(result);
        vo.setEmpId(1);
        System.out.println(vo);
        logsService.updRepair(vo);
    }

    @RequestMapping(value = "/delRepair")
    public void delRepair(int delRepairId){
        logsService.delRepair(delRepairId);
    }

    /**
     * 保修管理相关方法
     * */
    @RequestMapping(value = "/toRepairPage")
    public String toRepairPage(){
        return "/repair_ljw/repairList";
    }
    @ResponseBody
    @RequestMapping(value = "/getRepairData")
    public void getRepairData(){

    }
}