package com.norman.controller;

import com.alibaba.fastjson.JSONObject;
import com.norman.service.Ljw_LogsService;
import com.publics.vo.empModel.emp.EmpVo;
import com.publics.vo.logistics.EquipmentRepairVo;
import com.publics.vo.studentModel.StudentVo;
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
@RequestMapping(value = "/myRepair")
public class Ljw_StuRepairController {
    @Resource
    private Ljw_LogsService logsService;

    @RequestMapping(value = "/toStuRepair")
    public String toMyRepair(){
        System.out.println("学生");
        return "repair_ljw/stuRepair";
    }

    @RequestMapping(value = "/addRepair")
    public String addRepair(HttpServletRequest request, String equipmentType, String remark){
        HttpSession session = request.getSession();
        int user = ((StudentVo) session.getAttribute("user")).getStudid();
        int clazz = logsService.getStuVo(user).getClazz();
        EquipmentRepairVo repair = new EquipmentRepairVo();
        repair.setEquipmentType(equipmentType);
        repair.setRemark(remark);
        repair.setStudent(user);
        repair.setStatus(0);
        repair.setClasses(clazz);
        repair.setUserType(1);
        repair.setStartTime(new Date());
        logsService.newRepair(repair);
        return "redirect:/myRepair/toMyRepair";
    }

    @ResponseBody
    @RequestMapping(value = "/getMyRepairData")
    public void getMyRepairData(HttpServletResponse response, HttpServletRequest request, int page, int limit) throws IOException {
        HttpSession session = request.getSession();
        StudentVo vo = (StudentVo) session.getAttribute("user");
        int user = vo.getStudid();
        response.setContentType("text/html;charset=utf-8");
        PrintWriter out = response.getWriter();
        JSONObject result = new JSONObject();
        result.put("code",0);
        result.put("count",logsService.getMyStuRepairSize(user));
        result.put("msg","提示");
        result.put("data",logsService.getMyStuRepairData(request,user,page,limit));
        out.print(result.toJSONString());
        out.flush();
        out.close();
    }
}
