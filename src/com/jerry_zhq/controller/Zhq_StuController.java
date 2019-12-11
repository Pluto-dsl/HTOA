package com.jerry_zhq.controller;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.jerry_zhq.service.Zhq_StuService;
import com.publics.vo.studentModel.StudntBuildingVo;
import com.publics.vo.sys.DepVo;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class Zhq_StuController {
    @Resource
    Zhq_StuService zhq_stuService;

    @RequestMapping("/toPage/stuFloor")
    public String stuFloor(){
        return "stu_zhq/stuFloor";
    }

    @RequestMapping("/selFloor")
    @ResponseBody
    public JSONObject stuFloor2(HttpServletResponse response,int page,int limit) throws IOException {//查询楼栋
        response.setContentType("text/html;charset=utf-8");

        JSONObject jsonObject = new JSONObject();
        String hql = "from StudntBuildingVo";
        List<StudntBuildingVo> data= zhq_stuService.selFloor(hql,page,limit);
        int count = zhq_stuService.selCount();

        jsonObject.put("msg","");
        jsonObject.put("code",0);
        jsonObject.put("count",count);
        jsonObject.put("data",data);
        return jsonObject;
    }

    //删除
    @RequestMapping("/deleteStu")
    @ResponseBody
    public String delDept(int stuId){
        System.out.println("获取到的id是"+stuId);
        StudntBuildingVo sb = new StudntBuildingVo();
        sb.setFloorId(stuId);
        zhq_stuService.deleteStuBiu(sb);
        return "success";
    }
    //添加
    @RequestMapping("/addStuFloor")
    public String addStuFloor(StudntBuildingVo studntBuildingVo){
        zhq_stuService.addStuBiu(studntBuildingVo);
        return "redirect:/toPage/stuFloor";
    }
}
