package com.zero.controller;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.zero.service.EmpService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class Zero_EmpController {
    @Resource
    EmpService empService;

    @RequestMapping(value = "/toemp")
    public String toemp() {
        return "emp/emp";
    }

    @RequestMapping(value = "/allemp")
    @ResponseBody
    public String allemp() {
        Map map = new HashMap();
        map.put("code",0);
        map.put("msg","");
        map.put("count",1);
        map.put("data",empService.selectEmp());
        System.out.println(JSONArray.toJSONString(map));
        return JSONArray.toJSONString(map);
    }
}
