package com.norman.controller;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.norman.service.Ljw_LogsService;
import com.publics.service.LoggingService;
import com.publics.vo.empModel.emp.EmpVo;
import com.publics.vo.logistics.EquipmentRepairVo;
import org.hibernate.Session;
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
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping(value = "/logs")
public class Ljw_LogisticsController {
    @Resource
    private Ljw_LogsService logsService;

    @Resource
    private LoggingService loggingService;

    @RequestMapping("/toNo")
    public String toNo(){
        return "controller_pluto/NO";
    }

    /**
     * 报修申请相关方法
     * */
    @RequestMapping(value = "/toMyRepair")
    public String toMyRepair(){
        return "repair_ljw/myRepair";
    }

    @RequestMapping(value = "/addRepair")
    public String addRepair(HttpServletRequest request,String equipmentType,String remark){
        HttpSession session = request.getSession();
        int user = ((EmpVo) session.getAttribute("admin")).getEmpId();
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
        loggingService.addLog(user,"添加了一条报修申请");
        return "redirect:/logs/toMyRepair";
    }

    @ResponseBody
    @RequestMapping(value = "/getEmpRepairData")
    public void getEmpRepairData(HttpServletResponse response,HttpServletRequest request,int page,int limit) throws IOException {
        int count;
        JSONArray data;
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
//        System.out.println(page);
        HttpSession session = request.getSession();
        EmpVo vo = (EmpVo) session.getAttribute("admin");
        int user = vo.getEmpId();
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
    @RequestMapping(value = "/manageRepair")
    public String updRepair(int repairId,String result,HttpServletRequest request,HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession();
        EmpVo empVo = (EmpVo) session.getAttribute("admin");
        EquipmentRepairVo vo = logsService.getRepair(repairId);
        vo.setStatus(1);
        vo.setEndTime(new Date());
        vo.setResult(result);
        vo.setEmpId(empVo.getEmpId());
        logsService.updRepair(vo);
        loggingService.addLog(empVo.getEmpId(),"完成了一条报修申请");
        return "redirect:/logs/toRepairPage";
    }

    @ResponseBody
    @RequestMapping(value = "/delRepair")
    public String delRepair(int delRepairId,HttpServletRequest request){
        HttpSession session = request.getSession();
        EmpVo empVo = (EmpVo) session.getAttribute("admin");
        logsService.delRepair(delRepairId);
        loggingService.addLog(empVo.getEmpId(),"删除了一条报修管理");
        return "200";
    }

    /**
     * 报修管理相关方法
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