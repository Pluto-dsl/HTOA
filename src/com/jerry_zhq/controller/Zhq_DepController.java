package com.jerry_zhq.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.alibaba.fastjson.serializer.SerializerFeature;
import com.jerry_zhq.service.Zhq_DepService;
import com.publics.service.LoggingService;
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
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/zhq")
public class Zhq_DepController {


    @Resource
    Zhq_DepService zhqDepService;

    @Resource
    private LoggingService log;

    @RequestMapping("/dep")
    public String dep(HttpServletRequest request){
        //部门
        List<DepVo> depList = zhqDepService.selParentId();
        //员工
        List<EmpVo> empList = zhqDepService.selEmp();

        request.setAttribute("depList",depList);//部门
        request.setAttribute("empList",empList);//员工
        return "emp_zhq/dep";
    }

    @RequestMapping("/tree")
    @ResponseBody//部门管理，查询部门
    public void seldep(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("text/html;charset=utf-8");
        PrintWriter out = response.getWriter();

        JSONArray depJsonArray = new JSONArray();
        List<DepVo> depVoList = new ArrayList<>();
        //部门
        List<DepVo> depList = zhqDepService.selDep();

        Map ht = new HashMap();
        ht.put("title","宏图软件");
        ht.put("id","10007");
        ht.put("spread","true");

        JSONArray jsonArray = new JSONArray();
        for (int i = 0; i < depList.size(); i++) {
            DepVo depVo = depList.get(i);
            if(depVo.getDepid()==10007){
                continue;
            }else if(depVo.getParentId() != 10007){
                continue;
            }
            Map m = new HashMap();
            m.put("title",depVo.getDepName());
            m.put("id",depVo.getDepid());
            m.put("spread","true");
            JSONArray js = new JSONArray();
            for (int i1 = 0; i1 < depList.size(); i1++) {
                DepVo d = depList.get(i1);
                if(d.getParentId()==depVo.getDepid()){
                    Map m2 = new HashMap();
                    m2.put("title",d.getDepName());
                    m2.put("id",d.getDepid());
                    m2.put("parentId",d.getParentId());
                    m2.put("remark",d.getRemark());
                    m2.put("spread","true");
                    js.add(m2);
                }
            }
            m.put("children",js);
            jsonArray.add(m);
        }
        ht.put("children",jsonArray);
        JSONArray rt = new JSONArray();
        rt.add(ht);
        out.print(rt.toJSONString());
    }

    @RequestMapping("/selDepAll")
    public void selDepAll(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        response.setContentType("text/html;charset=utf-8");
        PrintWriter out = response.getWriter();
        JSONObject jsonObject = new JSONObject();
        DepVo depVo = new DepVo();
        DepVo list = (DepVo)zhqDepService.selDepAll(depVo.getClass(),id);  //根据id查询部门
        jsonObject.put("list",list);
        out.print(jsonObject);


    }

    //添加部门
    @RequestMapping("/selDep")
    public String selDep(HttpServletRequest request){
        List<DepVo> depList = zhqDepService.selParentId();//查部门
        List<EmpVo> empList = zhqDepService.selEmp();//查员工
        request.setAttribute("depList",depList);
        request.setAttribute("empList",empList);
        return "emp_zhq/addDep";
    }

    //确定添加
    @RequestMapping("/addDep")
    @ResponseBody
    public String addDep(DepVo depVo, HttpSession session){
        zhqDepService.addDep(depVo);
        EmpVo empVo = (EmpVo) session.getAttribute("admin");
        log.addLog(empVo.getEmpId(),empVo.getEmpName()+"添加了部门");
        return "success";
    }

    //修改
    @RequestMapping("/delUpdate")
    public String delUpdate(HttpServletResponse response,HttpServletRequest request,HttpSession session){
        response.setContentType("text/html;charset=utf-8");
        String chairman = request.getParameter("chairman");
        int gang = 0;
        for (int i = 0; i < chairman.length(); i++) {
            char ss = chairman.charAt(i);
            if('/'==ss){
                gang=i;
                break;
            }
        }
        int depid = Integer.parseInt(chairman.substring(gang+1,chairman.length()));
        int depId= Integer.valueOf(request.getParameter("depid"));
        String remark= request.getParameter("remark");
        String depName = request.getParameter("depName");
        int parentId = Integer.valueOf(request.getParameter("parentIdName"));



        DepVo depVo = new DepVo();

        depVo.setDepid(depId);
        depVo.setDepName(depName);
        depVo.setParentId(parentId);
        depVo.setChairman(chairman.substring(0,gang));
        depVo.setRemark(remark);
        depVo.setPersonnel(depid);


        zhqDepService.updateDep(depVo);
        EmpVo empVo = (EmpVo) session.getAttribute("admin");
        log.addLog(empVo.getEmpId(),empVo.getEmpName()+"修改了部门");
        return "redirect:/zhq/dep";
    }

    //删除
    @RequestMapping("/delDept")
    @ResponseBody
    public String delDept(HttpServletRequest request,HttpSession session){
        int depId = Integer.valueOf(request.getParameter("depId"));

        int i =zhqDepService.selDepEmp(depId);
        if(i>0){
            return "0";
        }else {
            DepVo depVo1 = new DepVo();
            depVo1.setDepid(depId);
            zhqDepService.deleteDep(depVo1);
            EmpVo empVo = (EmpVo) session.getAttribute("admin");
            log.addLog(empVo.getEmpId(),empVo.getEmpName()+"删除了部门");
            return "1";
        }


    }


}
