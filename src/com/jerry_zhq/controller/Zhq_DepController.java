package com.jerry_zhq.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.alibaba.fastjson.serializer.SerializerFeature;
import com.jerry_zhq.service.Zhq_DepService;
import com.publics.vo.empModel.emp.EmpVo;
import com.publics.vo.sys.DepVo;
import javafx.print.Printer;
import org.codehaus.jackson.map.Module;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class Zhq_DepController {

    @Resource
    Zhq_DepService zhqDepService;

    @RequestMapping("oamain")
    public String oamain(){
        return "oamain";
    }

    @RequestMapping("/toPage/dep")
    public String dep(){
        return "emp_zhq/dep";
    }

    @RequestMapping("/tree")
    @ResponseBody//部门管理，查询部门
    public void seldep(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String type =request.getParameter("type");
        response.setContentType("text/html;charset=utf-8");
        PrintWriter out = response.getWriter();

        if("tree".equals(type)){
            JSONArray depJsonArray = new JSONArray();
            List<DepVo> depVoList = new ArrayList<>();
            List<DepVo> depVoList2 = new ArrayList<>();
            List<DepVo> depVoList3 = new ArrayList<>();
            //部门
            List<DepVo> depList = zhqDepService.selDep();

            for (DepVo depVo1:depList) {//最高部门
                if(depVo1.getParentId() == 0){
                    depVoList.add(depVo1);
                }
            }

            for (DepVo depVo:depVoList) {//最高部门
                Map map = new HashMap();
                map.put("title",depVo.getDepName());
                map.put("id",depVo.getDepid());

                JSONArray jsonArray = new JSONArray();

                for (DepVo depVo1:depList){
                    if(depVo1.getParentId() == depVo.getDepid()){//第二阶
                        Map chilDep = new HashMap();
                        chilDep.put("title",depVo1.getDepName());
                        chilDep.put("id",depVo1.getDepid());
                        jsonArray.add(chilDep);
                    }
                }
                map.put("children",jsonArray);
                depJsonArray.add(map);
            }
            out.print(depJsonArray.toJSONString());

        }
    }

    @RequestMapping("/selDepAll")
    public void selDepAll(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String type =request.getParameter("type");
        String name = request.getParameter("name");
        response.setContentType("text/html;charset=utf-8");
        PrintWriter out = response.getWriter();

        if("treeOpen".equals(type)){
            List<DepVo> list = zhqDepService.selDepAll(name);
            List<DepVo> depVos = zhqDepService.selDep();
            JSONObject jsonObject = new JSONObject();
            for (DepVo d :depVos) {
                for (DepVo deVo: list) {
                    if(deVo.getParentId() ==d.getDepid()){
                        jsonObject.put("parentId",d.getDepName());//父部门名称
                    }
                    jsonObject.put("depName",deVo.getDepName());//部门名称
                    /*jsonObject.put("parentId",deVo.getParentId());*/
                    jsonObject.put("chaiman",deVo.getChairman());//部门负责人
                    jsonObject.put("personnel",deVo.getPersonnel());//是否为人事部
                    jsonObject.put("remark",deVo.getRemark());//备注
                    request.setAttribute("depName",deVo.getDepName());
                }
            }

            out.print(jsonObject);
        }
    }

    //添加部门
    @RequestMapping("/selDep")
    public String selDep(HttpServletRequest request){
        List<DepVo> depList = zhqDepService.selDep();//查部门
        List<EmpVo> empList = zhqDepService.selEmp();//查员工
        request.setAttribute("depList",depList);
        request.setAttribute("empList",empList);
        return "emp_zhq/addDep";
    }

    //确定添加
    @RequestMapping("/addDep")
    @ResponseBody
    public String addDep(DepVo depVo){
        zhqDepService.addDep(depVo);
        return "success";
    }

    //修改
    @RequestMapping("/delUpdate")
    @ResponseBody
    public String delUpdate(HttpServletRequest request){
        String depName = request.getParameter("depName");
        int deptId = Integer.parseInt(request.getParameter("deptId"));
        DepVo depVo = zhqDepService.selById(deptId);
        depVo.setDepName(depName);

        zhqDepService.updateDep(depVo);

        return "success";
    }

    //删除
    @RequestMapping("/delDept")
    @ResponseBody
    public String delDept(HttpServletRequest request){
        int depId = Integer.valueOf(request.getParameter("depId"));
        DepVo depVo1 = new DepVo();
        depVo1.setDepid(depId);
        zhqDepService.deleteDep(depVo1);
        return "success";
    }


}
