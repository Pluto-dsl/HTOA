package com.zero.service.impl;

import com.alibaba.fastjson.JSONObject;
import com.publics.dao.BaseDao;
import com.publics.vo.empModel.HolidayVo;
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
        json.put("count",1000);
        json.put("data",list);
        return json.toJSONString();
    }

    @Override
    public void addLeave( HolidayVo holidayVo) {
        super.addObject(holidayVo);
    }

    @Override
    public String assignName(int empid) {
        Map map = (Map) super.listBySQL("select chairman from dep where depid = (select depid from emp where empId = "+empid+")").get(0);
        return (String) map.get("chairman");
    }

    @Override
    public String xiaassignName(int empid) {
        Map map = (Map) super.listBySQL("select chairman from dep where depid = (select parentId from dep where depid = (select depid from emp where empId = "+empid+"))").get(0);
        return (String) map.get("chairman");
    }

    @Override
    public HolidayVo seleHoliday(int holidayid) {
        return (HolidayVo) super.listByHql("from HolidayVo where holidayid ="+holidayid).get(0);
    }

    @Override
    public void updateholiday(HolidayVo holidayVo) {
        super.updObject(holidayVo);
    }
}
