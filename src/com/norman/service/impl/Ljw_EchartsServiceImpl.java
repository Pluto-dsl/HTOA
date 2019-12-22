package com.norman.service.impl;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.norman.service.Ljw_EchartsService;
import com.publics.dao.BaseDao;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.Map;

@Service
@Transactional
public class Ljw_EchartsServiceImpl extends BaseDao implements Ljw_EchartsService {

    @Override
    public JSONObject getEmpHolidayCount() {
        JSONObject result = new JSONObject();
        List<String> xAxis = new ArrayList<>();
        List<String> data = new ArrayList<>();
        List<Map> list = super.listBySQL("select e.empName,count(h.holidayid) holiCount FROM emp e\n" +
                "LEFT JOIN holiday h on h.Empid=e.empId\n" +
                "GROUP BY e.empName");
        for (Map map:
             list) {
            xAxis.add(map.get("empName").toString());
            data.add(map.get("holiCount").toString());
        }
        result.put("xAxis",xAxis);
        result.put("data",data);
        return result;
    }

    @Override
    public JSONObject getEmpLineDataCount() {
        JSONObject result = new JSONObject();
        List<String> xAxis = new ArrayList<>();
        List<Integer> data = new ArrayList<>();
        Calendar cal = Calendar.getInstance();
        cal.add(Calendar.MONTH,-11);
        for (int i = 1; i < 13; i++) {
            int year = cal.get(Calendar.YEAR);
            int month = cal.get(Calendar.MONTH);
            month++;
            String sql = "SELECT * FROM holiday " +
                    "WHERE startTime >= '"+year+"-"+month+"-01 00:00:00'" +
                    "";
            xAxis.add(year+"年"+month+"月");

            cal.add(Calendar.MONTH,+1);

            year = cal.get(Calendar.YEAR);
            month = cal.get(Calendar.MONTH);
            month++;
            sql +=" and startTime < '"+year+"-"+month+"-01 00:00:00'";
             //System.out.println(sql);

            data.add(super.listBySQL(sql).size());
        }
        result.put("xAxis",xAxis);
        result.put("data",data);
        return result;
    }

    @Override
    public JSONObject getTitleBingData() {
        JSONObject result = new JSONObject();
        List<String> xAxis = new ArrayList<>();
        JSONArray data = new JSONArray();
        List<Map> list = super.listBySQL("SELECT Title,count(holidayid) holidayCount FROM holiday GROUP BY Title");
        for (Map map:
                list) {
            JSONObject dataObj = new JSONObject();
            xAxis.add(map.get("Title").toString());
            dataObj.put("value",Integer.parseInt(map.get("holidayCount").toString()));
            dataObj.put("name",map.get("Title").toString());
            data.add(dataObj);
        }
        result.put("selected",xAxis);
        result.put("seriesData",data);
        return result;
    }
}
