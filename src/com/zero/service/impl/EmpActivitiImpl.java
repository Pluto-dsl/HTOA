package com.zero.service.impl;

import com.alibaba.fastjson.JSONObject;
import com.publics.dao.BaseDao;
import com.publics.vo.empModel.HolidayVo;
import com.publics.vo.empModel.emp.EmpVo;
import com.zero.service.EmpActivitiService;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

@Service
public class EmpActivitiImpl extends BaseDao implements EmpActivitiService {
    @Override
    public String getLeaveList(String sql) {
        List list = super.listBySQL(sql);
        JSONObject json = new JSONObject();
        json.put("code",0);
        json.put("msg","员工请假表");
        json.put("count",list.size());
        json.put("data",list);
        return json.toJSONString();
    }

    @Override
    public void addLeave( HolidayVo holidayVo) {
        super.addObject(holidayVo);
    }

    @Override
    public String assignName(int empid) {
        String sql ="select personnel from dep where depid = (select depid from emp where empId = "+empid+")";
        Map map = (Map) super.listBySQL(sql).get(0);
        return map.get("personnel").toString();
    }

    @Override
    public String assignDep(int depid) {
        Map map = (Map) super.listBySQL("select personnel from dep where depid = (select parentId from dep where depid = "+depid+")").get(0);
        return map.get("personnel").toString();
    }

    @Override
    public String xiaassignName(int empid) {
        String sql = "select personnel from dep where depid = (select parentId from dep where depid = (select depid from emp where empId = "+empid+"))";
        Map map = (Map) super.listBySQL(sql).get(0);
        return  map.get("personnel").toString();
    }

    @Override
    public HolidayVo seleHoliday(int holidayid) {
        return (HolidayVo) super.listByHql("from HolidayVo where holidayid ="+holidayid).get(0);
    }

    @Override
    public String name(int empid) {
        List<Map> list = super.listBySQL("select empName from emp where empId ="+empid);
        return list.get(0).get("empName").toString();
    }

    @Override
    public void updateholiday(HolidayVo holidayVo) {
        super.updObject(holidayVo);
    }

    @Override
    public List<Map> mytask(int holidayid) {
        return super.listBySQL("select h.*,e.empName from holiday h " +
                " left join emp e on e.empId = h.Empid where h.holidayid = "+holidayid);
    }

    @Override
    public String isper(int depid, int empid) {
        List list =  super.listBySQL("select * from dep where depid = "+depid+" and personnel = "+empid);
        String res ="";
        if (list.size()==1){
            res = "yes";
        }else {
            res = "no";
        }
        return res;
    }

    @Override
    public String isper(int empid) {
        List list =  super.listBySQL("select * from dep where  personnel = "+empid);
        String res ="";
        if (list.size()==1){
            res = "yes";
        }else {
            res = "no";
        }
        return res;
    }
}
