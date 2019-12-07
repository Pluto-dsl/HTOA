package com.wtt.service.impl;

import com.alibaba.fastjson.JSONObject;
import com.publics.dao.BaseDao;
import com.publics.vo.empModel.WeeklogVo;
import com.publics.vo.empModel.emp.EmpVo;
import com.publics.vo.sys.DepVo;
import com.wtt.service.Wtt_EmpService;
import org.springframework.stereotype.Service;

import java.text.SimpleDateFormat;
import java.util.List;

@Service
public class Wtt_EmpServiceImpl extends BaseDao implements Wtt_EmpService {
    @Override
    public List<WeeklogVo> weekpaper(int currpage,int pagesize) {
        return pageByHql("from WeeklogVo",currpage,pagesize);
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
    public int pagecount() {
        return selTotalRow("select count(*) from weeklog");
    }

}
