package com.jerry_zhq.controller;

import com.alibaba.fastjson.JSONArray;
import com.jerry_zhq.service.Zhq_DepService;
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
    @ResponseBody
    public void seldep(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String type =request.getParameter("type");
        System.out.println("获取到的type是:"+ type);
        response.setContentType("text/html;charset=utf-8");
        PrintWriter out = response.getWriter();

        if("tree".equals(type)){
            System.out.println("进来判断了");
            JSONArray depJsonArray= new JSONArray();//装部门
            //部门
            List depList = zhqDepService.selDep();
            //员工
            List empList = zhqDepService.selEmp();

            for (int i = 0; i < depList.size(); i++) {
                DepVo dep = (DepVo) depList.get(i);
                JSONArray empJsonArray = new JSONArray();//装员工
                for (int j = 0; j <empList.size() ; j++) {

                }
                depJsonArray.add(empJsonArray);
            }

            System.out.println(depJsonArray.toJSONString());
            out.print(depJsonArray.toJSONString());
        }

    }
}
