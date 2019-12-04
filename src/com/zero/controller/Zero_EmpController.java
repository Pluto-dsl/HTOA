package com.zero.controller;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.zero.service.EmpsService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.*;

@Controller
public class Zero_EmpController {
    @Resource
    EmpsService empService;

    @RequestMapping(value = "/toemp")
    public String toemp() {
        return "emp/emp";
    }

    @RequestMapping(value = "/allemp")
    @ResponseBody
    public String allemp() {
        Map map = new TreeMap();
        map.put("code",0);
        map.put("msg"," ");
        map.put("count",1);
        map.put("data",empService.selectEmp());
        return JSONArray.toJSONString(map);
    }
}
