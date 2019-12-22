package com.pluto.service.impl;

import com.alibaba.fastjson.JSONObject;
import com.pluto.service.Pluto_LeaveService;
import com.publics.dao.BaseDao;
import com.publics.vo.empModel.HolidayVo;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

@Service
public class Pluto_LeaveServiceImpl extends BaseDao implements Pluto_LeaveService {


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
    public void addLeave( HttpServletRequest request) {
        String title = request.getParameter("Title");
        String stime = request.getParameter("startTime");
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        Date startDate = new Date();
        String etime = request.getParameter("endTime");
        Date endDate = new Date();
        try {
            startDate = sdf.parse(stime);
            endDate = sdf.parse(etime);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        String day = request.getParameter("holidayDay");
        String hour = request.getParameter("hour");
        String Remark = request.getParameter("Remark");
        HolidayVo holidayVo = new HolidayVo();
        holidayVo.setTitle(title);
        holidayVo.setStartTime(startDate);
        holidayVo.setEndTime(endDate);
        holidayVo.setHolidayDay(Integer.parseInt(day));
        holidayVo.setHour(Integer.parseInt(hour));
        holidayVo.setRemark(Remark);
        holidayVo.setStatus(1);//状态 1:审批中 2：已完成 3：不批准
        holidayVo.setEmpid(1);//设置请假员工
         //System.out.println(holidayVo.toString());
        super.addObject(holidayVo);
    }
}
