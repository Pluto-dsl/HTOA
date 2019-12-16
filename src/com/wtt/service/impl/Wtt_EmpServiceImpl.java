package com.wtt.service.impl;

import com.alibaba.fastjson.JSONObject;
import com.publics.dao.BaseDao;
import com.publics.vo.empModel.WeeklogVo;
import com.publics.vo.empModel.emp.EducationVo;
import com.publics.vo.empModel.emp.EmpVo;
import com.publics.vo.empModel.emp.JobVo;
import com.publics.vo.sys.DepVo;
import com.wtt.service.Wtt_EmpService;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Map;

@Service
public class Wtt_EmpServiceImpl extends BaseDao implements Wtt_EmpService {
    @Override
    public List<WeeklogVo> weekpaper(HttpServletRequest request,int currpage, int pagesize) {
        String starttime = request.getParameter("startTime");
        String endtitme = request.getParameter("endTime");
        String sql = "select w.weeklogid,e.empName,w.Idea,w.Workday,w.studentQuestion,w.weekCur,w.weekNext from weeklog w\n" +
                "left join emp e on w.Empid = e.empId\n" +
                "where w.Workday";
        if(!("".equals(starttime) || starttime == null)){
            sql+=" between '"+starttime+" 00:00:00'";
        }
        if(!("".equals(endtitme) || endtitme == null)){
            sql+=" and '"+endtitme+" 23:59:59'";
        }
        return pageBySQL(sql,currpage,pagesize);
    }

    @Override
    public void add(WeeklogVo weeklogVo) {
        addObject(weeklogVo);
    }

    @Override
    public JSONObject wekk(int id) {
        WeeklogVo weeklogVo = (WeeklogVo) getObject(WeeklogVo.class,id);
        EmpVo empVo = (EmpVo) getObject(EmpVo.class,weeklogVo.getEmpid());
        DepVo dep = (DepVo) getObject(DepVo.class,empVo.getDepId());

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");

        JSONObject jsonObject = new JSONObject();
        jsonObject.put("depName",dep.getDepName());
        jsonObject.put("empName",empVo.getEmpName());
        jsonObject.put("workDay",sdf.format(weeklogVo.getWorkday()));
        jsonObject.put("weekCur",weeklogVo.getWeekCur());
        jsonObject.put("studentQuestion",weeklogVo.getStudentQuestion());
        jsonObject.put("idea",weeklogVo.getIdea());
        jsonObject.put("weekNext",weeklogVo.getWeekNext());
        return jsonObject;
    }

    @Override
    public EmpVo emp(int id) {
        return (EmpVo) getObject(new EmpVo().getClass(),id);
    }

    @Override
    public void update(WeeklogVo weeklogVo) {
        updObject(weeklogVo);
    }

    @Override
    public void delete(int id) {
        WeeklogVo weeklogVo = new WeeklogVo();
        weeklogVo.setWeeklogid(id);
        delObject(weeklogVo);
    }

    @Override
    public int pagecount(HttpServletRequest request) {
        String starttime = request.getParameter("startTime");
        String endtitme = request.getParameter("endTime");
        String sql = "select count(*) from weeklog w left join emp e on w.Empid = e.empId where w.Workday";
        if(!("".equals(starttime) || starttime == null)){
            sql+=" between '"+starttime+" 00:00:00'";
        }
        if(!("".equals(endtitme) || endtitme == null)){
            sql+=" and '"+endtitme+" 23:59:59'";
        }
        return selTotalRow(sql);
    }

    @Override
    public String name (int id) {
            String sql = "select d.depName from emp e\n" +
                    "left join dep d on d.depid = e.depId\n" +
                    "where e.empId = '"+id+"'";
        List<Map> list = listBySQL(sql);
        for (Map map:list) {
            return map.get("depName").toString();
        }
        return null;
    }

    @Override
    public List edmap(int id) {
        String sql = "select d.collegeName,d.degree,d.startDate,d.endDate from emp e left join education d on d.Empid= e.empId where e.empId = '"+id+"'";
        return listBySQL(sql);
    }

    @Override
    public List jobmap(int id) {
        String sql ="select j.companyName,j.degree,j.startDate,j.endDate from emp e left join job j on j.Empid= e.empId where e.empId = '"+id+"'";
        /*List<Map> list = listBySQL(sql);
        for (Map map:list) {
            return map;
        }
        return null;*/
        return listBySQL(sql);
    }

    @Override
    public List familymap(int id) {
        String sql = "select f.contactName,f.relationship,f.Phone from emp e left join familyInfo f on f.Empid= e.empId where e.empId = '"+id+"'";
        return listBySQL(sql);
    }

}