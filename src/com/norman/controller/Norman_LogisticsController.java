package com.norman.controller;

import com.alibaba.fastjson.JSONObject;
import com.norman.service.Ljw_LogsService;
import com.publics.vo.logistics.EquipmentRepairVo;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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
        EquipmentRepairVo repair = new EquipmentRepairVo();
        repair.setEquipmentType(equipmentType);
        repair.setRemark(remark);
        repair.setStatus(0);
        repair.setClasses(1);
        repair.setDepId(1);
        repair.setUserType(2);
        repair.setStartTime(new Date());
        logsService.newRepair(repair);
        return "redirect:/logs/toMyRepair";
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