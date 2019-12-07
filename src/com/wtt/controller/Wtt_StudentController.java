package com.wtt.controller;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.publics.vo.studentModel.StudentLeaveVo;
import com.publics.vo.studentModel.StudentVo;
import com.wtt.service.Wtt_StudentService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@Controller
@RequestMapping("/student")
public class Wtt_StudentController {
    @Resource
    Wtt_StudentService studentService;
    //去到学生请假页面
    @RequestMapping(value = "leave")
    public String leave(){
        return "student_wtt/studentleave";
    }

    //查询
    @RequestMapping(value = "selectleave")
    public void toEmpPaper(HttpServletResponse response, int page, int limit){
        response.setContentType("text/html;charset=utf-8");
        //当前页
        List<StudentLeaveVo> list = studentService.studentleave(page,limit);
        JSONArray jsonArray = new JSONArray();
        for(StudentLeaveVo studentLeaveVo:list){
            StudentVo studentVo = studentService.student(studentLeaveVo.getHolidayid());
            System.out.println("学生姓名:"+studentVo.getStuname());
            JSONObject jsonObject1 = new JSONObject();
            jsonObject1.put("holidayid",studentLeaveVo.getHolidayid());
            jsonObject1.put("StudentId",studentVo.getStuname());
            jsonObject1.put("holidayDay",studentLeaveVo.getHolidayDay());
            jsonObject1.put("startTime",studentLeaveVo.getStartTime());
            jsonObject1.put("endTime",studentLeaveVo.getEndTime());
            jsonObject1.put("Title",studentLeaveVo.getTitle());
            jsonObject1.put("Remark",studentLeaveVo.getRemark());
            jsonObject1.put("Status",studentLeaveVo.getStatus());
            jsonArray.add(jsonObject1);
        }
        //获取总行数
        int rows =studentService.pagecounts();
        JSONObject jsonObjects = new JSONObject();
        jsonObjects.put("msg","提示");
        jsonObjects.put("code",0);
        jsonObjects.put("data",jsonArray);
        jsonObjects.put("count",rows);
        try {
            PrintWriter pw = response.getWriter();
            pw.print(jsonObjects.toJSONString());
            pw.flush();
            pw.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}