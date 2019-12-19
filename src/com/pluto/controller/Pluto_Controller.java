package com.pluto.controller;

import com.alibaba.fastjson.JSONObject;
import com.pluto.service.Pluto_LcController;
import com.publics.vo.sys.CharactersVo;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@Controller
@RequestMapping("/controller")
public class Pluto_Controller {

    @Resource
    private Pluto_LcController service;

    @RequestMapping("/toUserList")
    public String toUserList(){
        return "controller_pluto/user";
    }
    @RequestMapping("/toAddUser")
    public String toAddUser(){
        return "controller_pluto/addUser";
    }

    @RequestMapping("/delUser")
    @ResponseBody
    public String deleteUser(int id){
        service.delUser(id);
        return "1";
    }

    @RequestMapping("/addUser")
    @ResponseBody
    public String addUser(CharactersVo charactersVo) {
        service.addUser(charactersVo);
        return "1";
    }

    @RequestMapping("/getUserData")
    @ResponseBody
    public void getUserData(HttpServletResponse response) throws IOException {
        response.setContentType("text/html;charset=utf-8");
        List list = service.getListByHql("from CharactersVo");
        JSONObject json = new JSONObject();
        json.put("code",0);
        json.put("msg","角色列表");
        json.put("count",0);
        json.put("data",list);

        PrintWriter pw = response.getWriter();
        pw.print(json.toJSONString());
        pw.flush();
        pw.close();
    }

}
