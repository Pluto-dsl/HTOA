package com.pluto.controller;

import com.alibaba.fastjson.JSONArray;
import com.pluto.service.Pluto_LogService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.sql.Date;
import java.util.Map;

@Controller
@RequestMapping("/log")
public class LoggingController {

    @Resource
    Pluto_LogService service;

    @RequestMapping("/getLogData")
    @ResponseBody
    public Map getLogData(int page,int limit,String s,String e){

        String stime = s;
        String etime = e;
        Map m = null;
        java.sql.Date d = new Date(new java.util.Date().getTime());
        if(stime==null || "".equals(stime)){
            stime="1900-1-1";
        }
        if(etime==null || "".equals(etime)){
            etime = d.toString();
        }
//        System.out.println(stime+"!!!!!!!!!!!!!!!!"+etime);
        String sql = "select s.*,e.empName from systemLog s INNER JOIN emp e on s.empId = e.empId\n" +
                " where s.optime BETWEEN '"+stime+"' and '"+etime+" 23:59:59'" +
                " GROUP BY(s.logId) desc ";
        System.out.println(sql);
        if((stime!=null || !stime.equals("")) || (etime!=null || !etime.equals(""))){
            m = service.getLogData(sql,page,limit);
        }else {
            m = service.getLogData("select s.*,e.empName from systemLog s INNER JOIN emp e on s.empId = e.empId GROUP BY(s.logId) desc",page,limit);
        }
        return m;
    }

    @RequestMapping("/toLogList")
    public String toLogList(){
        return "log_pluto/logging";
    }

    @RequestMapping("/toNo")
    public String toNo(){
        return "controller_pluto/NO";
    }
}
