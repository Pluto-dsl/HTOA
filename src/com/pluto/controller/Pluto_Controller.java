package com.pluto.controller;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.pluto.service.Pluto_LcController;
import com.publics.vo.empModel.emp.EmpVo;
import com.publics.vo.sys.*;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.lang.reflect.Array;
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

    @RequestMapping("/toJson")
    @ResponseBody
    public JSONArray toJson(HttpServletResponse response) throws IOException {
        response.setContentType("text/html;charset=utf-8");
        List list = service.getListByHql("from ModuleVo");
        JSONObject outsideJson = new JSONObject();
        JSONArray children = new JSONArray();

        ModuleVo m = (ModuleVo) list.get(0);
        outsideJson.put("title",m.getModuleName());
        outsideJson.put("id",m.getModuleId());
        outsideJson.put("spread","true");

        for (int i = 0; i < list.size(); i++) {
            ModuleVo moduleVo = (ModuleVo) list.get(i);
            JSONObject ecjson = new JSONObject();
            JSONArray ecja = new JSONArray();
            ecjson.put("title",moduleVo.getModuleName());
            ecjson.put("id",moduleVo.getModuleId());

            for (int i1 = 0; i1 < list.size(); i1++) {
                ModuleVo mtemp = (ModuleVo) list.get(i1);
                if(mtemp.getRoot()==moduleVo.getModuleId()){
                    JSONObject j = new JSONObject();
                    j.put("title",mtemp.getModuleName());
                    j.put("id",mtemp.getModuleId());
                    ecja.add(j);
                }

            }
            ecjson.put("children",ecja);
            if(moduleVo.getRoot()==1){
                children.add(ecjson);
            }
        }
        outsideJson.put("children",children);
        JSONArray jj = new JSONArray();
        jj.add(outsideJson);

       return jj;
    }

    @RequestMapping("/toUpdC")
    public String toUpdC(int id,Model model){
        model.addAttribute("id",id);
        List list = service.getListByHql("from CharModuleVo where characterId="+id);

        JSONArray j = new JSONArray();
        for (int i = 1; i < list.size(); i++) {
            CharModuleVo c = (CharModuleVo) list.get(i);
            j.add(c.getModuleId());
        }

        model.addAttribute("oldData",j);
        return "controller_pluto/updateController";
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

    @RequestMapping("/updC")
    @ResponseBody
    public int updC(int mid, @RequestParam("checkIds[]")int[] cheks) throws IOException {

        boolean flag = service.judge(mid);
        if(flag){//true代表有数据
            service.deleteCharModel(mid);
        }
        for (int i = 0; i < cheks.length; i++) {
            CharModuleVo c = new CharModuleVo();
            c.setModuleId(cheks[i]);
            c.setCharacterId(mid);
            service.addcharModule(c);
        }
        return 0;
    }

    @RequestMapping("/toAccUser")
    public String toAddUser(int id,Model model){


        List deptList = service.getListByHql("from DepVo");
        List empList = service.getListByHql("from EmpVo");
        JSONArray outerJson = new JSONArray();

        for (int i = 0; i < deptList.size(); i++) {
            DepVo d = (DepVo) deptList.get(i);
            JSONObject deptJson = new JSONObject();
            JSONArray deptSons = new JSONArray();
            deptJson.put("id",d.getDepid());
            deptJson.put("title",d.getDepName());
            int tt = 0;
            for (int j = 0; j < empList.size(); j++) {
                EmpVo e = (EmpVo) empList.get(j);
                if(d.getDepid()==e.getDepId()){
                    JSONObject sonJson = new JSONObject();
                    sonJson.put("id",e.getEmpId());
                    sonJson.put("title",e.getEmpName());
                    deptSons.add(sonJson);
                    tt++;
                }
            }
            if(tt!=0){
                deptJson.put("children",deptSons);
            }
            outerJson.add(deptJson);
        }

        JSONArray selected = service.getUAC(id);
        model.addAttribute("selected",selected);

        model.addAttribute("json",outerJson.toJSONString());
        model.addAttribute("id",id);
        return "controller_pluto/accUser";
    }

    @RequestMapping("/addUserCs")
    @ResponseBody
    public String addUserCs(int mid, @RequestParam("checkIds[]")int[] cheks){
        boolean flag = service.judgeUser(mid);
        if(flag){//true代表有数据
            service.deleteUAC(mid);
        }

        for (int i = 0; i < cheks.length; i++) {
            UserAndControllerVo uac = new UserAndControllerVo();
            uac.setEmpId(cheks[i]);
            uac.setCharacterId(mid);
            service.addObject(uac);
        }
        return "1";
    }

//    _____________________________________
    @RequestMapping("/toNo")
    public String toNo(){
        return "controller_pluto/NO";
    }
}
