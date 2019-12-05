package com.jerry_zhq.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.alibaba.fastjson.serializer.SerializerFeature;
import com.jerry_zhq.service.Zhq_DepService;
import com.publics.vo.empModel.emp.EmpVo;
import com.publics.vo.sys.DepVo;
import javafx.print.Printer;
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
        System.out.println("获取到的type是:"+ type);
        response.setContentType("text/html;charset=utf-8");
        PrintWriter out = response.getWriter();

        if("tree".equals(type)){
            System.out.println("进来判断了");
            JSONObject jsonObject = new JSONObject();//装部门
            JSONArray depJsonArray1 = new JSONArray();//子部门
            JSONArray depJsonArray2 = new JSONArray();//子部门
            //部门
            List depList = zhqDepService.selDep();
            System.out.println(depList);

            System.out.println("部门长度是"+depList.size());
            for (int i = 0; i < depList.size(); i++) {
                DepVo dep = (DepVo) depList.get(i);
                if(dep.getParentId() == 0){
                    jsonObject.put("title",dep.getDepName());
                }else if(dep.getParentId() == 1){
                    Map map = new HashMap();
                    map.put("title",dep.getDepName());
                    depJsonArray2.add(map);
                }
            }
            jsonObject.put("children",depJsonArray2);
            depJsonArray1.add(jsonObject);

            System.out.println(depJsonArray1.toJSONString());
            out.print(depJsonArray1.toJSONString());

        }

    }
}
