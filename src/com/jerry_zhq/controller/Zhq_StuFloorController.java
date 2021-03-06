package com.jerry_zhq.controller;

import com.alibaba.fastjson.JSONObject;
import com.jerry_zhq.service.Zhq_StuFloorService;
import com.publics.service.LoggingService;
import com.publics.vo.empModel.emp.EmpVo;
import com.publics.vo.studentModel.StudentDormitoryVo;
import com.publics.vo.studentModel.StudntBuildingVo;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@Controller
@RequestMapping("/zhq")
public class Zhq_StuFloorController {
    @Resource
    Zhq_StuFloorService zhq_stuFloorService;

    @Resource
    private LoggingService log;

    @RequestMapping("/toNo")
    public String toNo(){
        return "controller_pluto/NO";
    }

    @RequestMapping("/stuFloor")
    public String stuFloor(){
        return "stu_zhq/stuFloor";
    }

    @RequestMapping("/selFloor")
    @ResponseBody
    public JSONObject stuFloor2(HttpServletResponse response,int page,int limit) throws IOException {//查询宿舍
        response.setContentType("text/html;charset=utf-8");

        JSONObject jsonObject = new JSONObject();
        String hql = "from StudntBuildingVo";
        List<StudntBuildingVo> data= zhq_stuFloorService.selFloor(hql,page,limit);
        int count = zhq_stuFloorService.selCount();

        jsonObject.put("msg","");
        jsonObject.put("code",0);
        jsonObject.put("count",count);
        jsonObject.put("data",data);
        return jsonObject;
    }

    //删除
    @RequestMapping("/deleteStu")
    @ResponseBody
    public String delDept(int floorId, HttpSession session){
         //System.out.println("获取到的id是"+floorId);
        StudntBuildingVo sb = new StudntBuildingVo();
        sb.setFloorId(floorId);
        List<StudentDormitoryVo> list = zhq_stuFloorService.list(floorId);
        /*System.out.println("宿舍："+list);*/
        if(list.size()<1){
            EmpVo empVo = (EmpVo) session.getAttribute("admin");
            log.addLog(empVo.getEmpId(),empVo.getEmpName()+"删除了楼栋");
            zhq_stuFloorService.deleteStuBiu(sb);
            return "1";
        }else {
            return "0";
        }
    }
    //添加
    @RequestMapping("/addStuFloor")
    public String addStuFloor(StudntBuildingVo studntBuildingVo,HttpServletResponse response,HttpSession session){
        response.setContentType("text/html;charset=utf-8");
        zhq_stuFloorService.addStuBiu(studntBuildingVo);

        EmpVo empVo = (EmpVo) session.getAttribute("admin");
        log.addLog(empVo.getEmpId(),empVo.getEmpName()+"添加了楼栋");
        return "redirect:/zhq/stuFloor";
    }
}
