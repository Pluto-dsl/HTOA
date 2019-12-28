package com.jerry_zhq.controller;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.jerry_zhq.service.Zhq_StuDormService;
import com.publics.service.LoggingService;
import com.publics.vo.empModel.emp.EmpVo;
import com.publics.vo.studentModel.StudentClassVo;
import com.publics.vo.studentModel.StudentDormitoryVo;
import com.publics.vo.studentModel.StudentVo;
import com.publics.vo.studentModel.StudntBuildingVo;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/zhq")
public class Zhq_StuDormController {
    @Resource
    Zhq_StuDormService zhq_stuDormService;


    @Resource
    private LoggingService log;

    @RequestMapping("/stuDorm")
    public String dorm(HttpServletRequest request){
        List<Map> dormitoryVoList =zhq_stuDormService.selFloorName();
        request.setAttribute("floor",dormitoryVoList);
        return "/stu_zhq/stuDorm";
    }
    @RequestMapping("/selDorm")
    @ResponseBody//查询宿舍
    public JSONObject selDorm(HttpServletResponse response,HttpServletRequest request, int page, int limit){
        response.setContentType("text/html;charset=utf-8");
        JSONObject jsonObject = new JSONObject();
        JSONArray jsonArray = new JSONArray();
        String hql = "from StudentDormitoryVo";
        List<StudentDormitoryVo> data = zhq_stuDormService.selDorm(hql,page,limit);
        int count = zhq_stuDormService.selCount();
        for (StudentDormitoryVo s:data ) {
            //根据宿舍中的楼栋id查询楼栋名
            List<Map> dormitoryVoList =zhq_stuDormService.selDormFloor(s.getFloorId());

            Map m2= new HashMap();
            for(Map map2:dormitoryVoList){
                m2.put("a",map2.get("floorName"));
            }
            Map map = new HashMap();
            map.put("hourid",s.getHourid());
            map.put("huorName",s.getHuorName());
            map.put("huoeIddsc",s.getHuoeIddsc());
            map.put("floorId",s.getFloorId());
            map.put("floorName",m2.get("a"));
            map.put("numberBeds",s.getNumberBeds());
            map.put("count",s.getCount());
            map.put("addr",s.getAddr());
            jsonArray.add(map);
        }

        jsonObject.put("msg","");
        jsonObject.put("code",0);
        jsonObject.put("count",count);
        jsonObject.put("data",jsonArray);
        return jsonObject;
    }


    //删除
    @RequestMapping("/deleteStuDorm")
    @ResponseBody
    public String delDept(int hourid, HttpSession session){
        StudentDormitoryVo sd = new StudentDormitoryVo();
        sd.setHourid(hourid);
        int studentsize = zhq_stuDormService.size(hourid);
        if(studentsize<1){
            EmpVo empVo = (EmpVo) session.getAttribute("admin");
            log.addLog(empVo.getEmpId(),empVo.getEmpName()+"删除了宿舍");
            zhq_stuDormService.delStuDorm(sd);
            return "1";
        }else {
            return "0";
        }
    }

    //点击了添加按钮
    @RequestMapping("/addStuDormit")
    public String addStuDormit(HttpServletRequest request){
        List<StudntBuildingVo> list = zhq_stuDormService.selFloorName();
         //System.out.println(list.toString());
        request.setAttribute("list",list);
        return "/stu_zhq/addStuDorm";
    }

    //确定添加
    @RequestMapping("/addDorm")
    @ResponseBody
    public String addDorm(StudentDormitoryVo studentDormitoryVo,HttpSession session){
        List<Map> l = zhq_stuDormService.selDormFloor(studentDormitoryVo.getFloorId());
        String fname = l.get(0).get("floorName").toString();
        String sname = studentDormitoryVo.getHuorName();
        sname = fname+"-"+sname;
        studentDormitoryVo.setHuorName(sname);
        zhq_stuDormService.addDorm(studentDormitoryVo);

        EmpVo empVo = (EmpVo) session.getAttribute("admin");
        log.addLog(empVo.getEmpId(),empVo.getEmpName()+"添加了宿舍");
        return "success";
    }

    //点击了修改
    @RequestMapping("/updateDorm")
    public String updateStuDormit(StudentDormitoryVo studentDormitoryVo,HttpServletResponse response,HttpSession session){
        response.setContentType("text/html;charset=utf-8");
        List<Map> l = zhq_stuDormService.selDormFloor(studentDormitoryVo.getFloorId());
        String fname = l.get(0).get("floorName").toString();
        String name = studentDormitoryVo.getHuorName();
        name = fname+name;
        studentDormitoryVo.setHuorName(name);

        zhq_stuDormService.update(studentDormitoryVo);

        EmpVo empVo = (EmpVo) session.getAttribute("admin");
        log.addLog(empVo.getEmpId(),empVo.getEmpName()+"修改了宿舍");
        return "redirect:/zhq/stuDorm";
    }

    //查询宿舍学生
    @RequestMapping("/selStuDormit")
    @ResponseBody
    public JSONObject selStuDormit(HttpServletRequest request,StudentDormitoryVo studentDormitoryVo,int id,int page,int limit ){
        JSONObject jsonObject= new JSONObject();
        JSONArray jsonArray = new JSONArray();

        //根据ID查询宿舍名
        StudentDormitoryVo  studentDormitoryVo1 = (StudentDormitoryVo) zhq_stuDormService.selIdHourName(studentDormitoryVo.getClass(),id);

        //查询学生表
        List<StudentVo> listStu = zhq_stuDormService.selStudent();

        for (StudentVo studentVo:listStu){
            Map map = new HashMap();
            if(studentVo.getHuor() == studentDormitoryVo1.getHourid()){
                map.put("huorName",studentDormitoryVo1.getHuorName());//宿舍房号名称
                map.put("stuName",studentVo.getStuname());//姓名
                map.put("phone",studentVo.getPhone());//电话
                List<StudentClassVo> studentClassVo = zhq_stuDormService.sleStudentClass();
                for (StudentClassVo classVo :studentClassVo){
                    if(classVo.getClassId() == studentVo.getClazz()){//班级id
                        map.put("className",classVo.getClassName());
                    }
                }
            }
            jsonArray.add(map);
        }

        jsonObject.put("msg","");
        jsonObject.put("code",0);
        jsonObject.put("data",jsonArray);
        return jsonObject;
    }

}
