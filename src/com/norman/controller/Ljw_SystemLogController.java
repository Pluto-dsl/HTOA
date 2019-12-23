package com.norman.controller;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.norman.service.Ljw_EmpService;
import com.norman.service.Ljw_SystemLogService;
import com.publics.vo.assess.AduitLogVo;
import com.publics.vo.empModel.AttendanceVo;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/systemLog")
public class Ljw_SystemLogController {
    @Resource
    Ljw_SystemLogService systemLogService;
    @Resource
    private Ljw_EmpService empService;

    @RequestMapping("/toNo")
    public String toNo(){
        return "controller_pluto/NO";
    }

    @RequestMapping("/toEveryDayPage")//去往员工日常考核
    public String toEveryDayPage(Model model){
        model.addAttribute("depList",empService.getDepList());
        return "systemLog/everyday";
    }

    @ResponseBody
    @RequestMapping("/getEveryDayData")//获取员工日常考核数据
    public void getEveryDayData(HttpServletRequest request,HttpServletResponse response,int page,int limit) throws IOException {
        response.setContentType("text/html;charset=utf-8");
        JSONObject result = new JSONObject();
        List<Map> list = systemLogService.getEmpList(request,page,limit);
        int count = systemLogService.getEmpListSize();
        result.put("code",0);
        result.put("msg","");
        result.put("count",count);
        result.put("data",list);
        PrintWriter out = response.getWriter();
        out.print(result);
        out.flush();
        out.close();
    }

    @ResponseBody
    @RequestMapping(value = "/getEveryList")//获取员工的考核列表
    public void getEveryList(Integer empId,HttpServletResponse response) throws IOException {
        response.setContentType("text/html;charset=utf-8");

        List<Map> list;
        if (empId ==null || empId == 0){
            list = new ArrayList<>();
        }else {
            list = systemLogService.getEveryListById(empId);
        }
        JSONObject obj = new JSONObject();
        obj.put("code",0);
        obj.put("msg","");
        obj.put("count",list.size());
        obj.put("data",list);
        PrintWriter out = response.getWriter();
        out.print(obj);
        out.flush();
        out.close();
    }

    @ResponseBody
    @RequestMapping(value = "/getImg/{aduitLogId}")//获取图片
    public void getImg(@PathVariable(value = "aduitLogId") Integer aduitLogId, HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("text/html;charset=utf-8");
        AduitLogVo vo = systemLogService.getAduitLog(aduitLogId);
        JSONObject obj = new JSONObject();
        JSONArray data = new JSONArray();
        String imgPath = vo.getImage();
        imgPath = imgPath.substring(2,imgPath.length());

        JSONObject jo = new JSONObject();
        jo.put("alt","");
        jo.put("pid",666);
        jo.put("src",request.getContextPath()+imgPath);
        jo.put("thumb",vo.getImage());
        data.add(jo);

        obj.put("title","");
        obj.put("id",123);
        obj.put("start",0);
        obj.put("data",data);

         //System.out.println(obj.toJSONString());

        PrintWriter out = response.getWriter();
        out.print(obj);
        out.flush();
        out.close();
    }

    @RequestMapping(value = "/toHolidayPage")//去员工请假列表
    public String toHolidayPage(Model model){
        JSONObject result = new JSONObject();
        Calendar cal = Calendar.getInstance();
        int month = cal.get(Calendar.MONTH);
        result.put("lastMonth",month);
        result.put("thisMonth",month +1);
        model.addAttribute("month",result);
        return "systemLog/holidayEmp";
    }

    @ResponseBody
    @RequestMapping(value = "/getHolidayEmp")//获取所有员工请假列表
    public void getHolidayEmp(HttpServletRequest request,HttpServletResponse response,int page,int limit) throws IOException {
        response.setContentType("text/html;charset=utf-8");
        JSONObject result = new JSONObject();
        List<Map> list = systemLogService.getHolidayEmp(request,page,limit);
        int count = systemLogService.getHolidayEmpSize(request);
        result.put("code",0);
        result.put("msg","");
        result.put("count",count);
        result.put("data",list);
        PrintWriter out = response.getWriter();
        out.print(result);
        out.flush();
        out.close();
    }

    @ResponseBody
    @RequestMapping(value = "/getHolidayByEmp")//通过员工id获取对应的员工请假记录
    public void getHolidayBayEmp(HttpServletRequest request,HttpServletResponse response,int page,int limit) throws IOException {
        response.setContentType("text/html;charset=utf-8");
        JSONObject result = new JSONObject();
        List<Map> list = systemLogService.getHolidayListByEmp(request,page,limit);
        int count = systemLogService.getHolidayListByEmpSize(request);
        result.put("code",0);
        result.put("msg","");
        result.put("count",count);
        result.put("data",list);
        PrintWriter out = response.getWriter();
        out.print(result);
        out.flush();
        out.close();
    }

    @RequestMapping(value = "/toHolidayStuPage")//去学生请假列表
    public String toHolidayStuPage(Model model){
        JSONObject result = new JSONObject();
        Calendar cal = Calendar.getInstance();
        int month = cal.get(Calendar.MONTH);
        result.put("lastMonth",month);
        result.put("thisMonth",month +1);
        model.addAttribute("month",result);
        return "systemLog/holidayStu";
    }

    @ResponseBody
    @RequestMapping(value = "/getHolidayStu")//获取所有学生请假列表
    public void getHolidayStu(HttpServletRequest request,HttpServletResponse response,int page,int limit) throws IOException {
        response.setContentType("text/html;charset=utf-8");
        JSONObject result = new JSONObject();
        List<Map> list = systemLogService.getHolidayStu(request,page,limit);
        int count = systemLogService.getHolidayStuSize(request);
        result.put("code",0);
        result.put("msg","");
        result.put("count",count);
        result.put("data",list);
        PrintWriter out = response.getWriter();
        out.print(result);
        out.flush();
        out.close();
    }

    @ResponseBody
    @RequestMapping(value = "/getHolidayByStu")//通过学生id获取学生请假记录
    public void getHolidayBayStu(HttpServletRequest request,HttpServletResponse response,int page,int limit) throws IOException {
        response.setContentType("text/html;charset=utf-8");
        JSONObject result = new JSONObject();
        List<Map> list = systemLogService.getHolidayListByStu(request,page,limit);
        int count = systemLogService.getHolidayListByStuSize(request);
        result.put("code",0);
        result.put("msg","");
        result.put("count",count);
        result.put("data",list);
        PrintWriter out = response.getWriter();
        out.print(result);
        out.flush();
        out.close();
    }

    @RequestMapping(value = "/toWorkTime")//去往未打卡说明统计
    public String toWorkTime(Model model){
        JSONObject result = new JSONObject();
        Calendar cal = Calendar.getInstance();
        int month = cal.get(Calendar.MONTH);
        result.put("lastMonth",month);
        result.put("thisMonth",month +1);
        model.addAttribute("month",result);
        return "systemLog/workTimeList";
    }

    @ResponseBody
    @RequestMapping(value = "/getWorkTimeData")//获取未打卡说明数据
    public void getWorkTimeData(HttpServletRequest request,HttpServletResponse response,int page,int limit) throws IOException {
        response.setContentType("text/html;charset=utf-8");
        List<AttendanceVo> data = systemLogService.getAttendance(request,page,limit);
        int count = systemLogService.getAttendanceSize(request);
        JSONObject result = new JSONObject();
        result.put("code",0);
        result.put("msg","提示");
        result.put("count",count);
        result.put("data",data);

        PrintWriter out = response.getWriter();
        out.print(result.toJSONString());
        out.flush();
        out.close();
    }

    @RequestMapping(value = "/toStuHour")//去往宿舍统计页面
    public String toStuHour(Model model){
        List<Map> result = systemLogService.getFloorList();
        model.addAttribute("floorList",result);
        return "systemLog/stuHour";
    }

    @ResponseBody
    @RequestMapping(value = "/getStuHourData")//获取宿舍的数据
    public void getStuHourData(HttpServletRequest request,HttpServletResponse response,int page,int limit) throws IOException {
        response.setContentType("test/html;charset=utf-8");
        //取出数据
        List<Map> data = systemLogService.getStuHourList(request,page,limit);
        int count = systemLogService.getStuHourSize(request);
        //拼接返回数据
        JSONObject result = new JSONObject();
        result.put("code",0);
        result.put("msg","提示");
        result.put("count",count);
        result.put("data",data);
        //使用输出流输出数据
        PrintWriter out = response.getWriter();
        out.print(result.toJSONString());
        out.flush();
        out.close();
    }

    @ResponseBody
    @RequestMapping(value = "/hourByFloor")//通过楼栋获取宿舍信息
    public void hourByFloor(HttpServletResponse response,Integer floorId) throws IOException {
        response.setContentType("test/html;charset=utf-8");
        //取出数据
        List<Map> hourList = systemLogService.getHourListNames(floorId);
        //使用输出流输出数据
        PrintWriter out = response.getWriter();
        JSONObject result = new JSONObject();
        result.put("data",hourList);
        out.print(result);
        out.flush();
        out.close();
    }
}
