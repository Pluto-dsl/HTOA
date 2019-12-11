package com.wtt.service.impl;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.publics.dao.BaseDao;
import com.publics.vo.educ.CourseTypeVo;
import com.publics.vo.educ.CourseVo;
import com.publics.vo.educ.TrialVo;
import com.publics.vo.empModel.emp.EmpVo;
import com.publics.vo.studentModel.StudentVo;
import com.wtt.service.Wtt_TrialService;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class Wtt_TrialServiceImpl extends BaseDao implements Wtt_TrialService {

    @Override
    public List<TrialVo> trialvo(int currpage, int pagesize) {
        return pageByHql("from TrialVo",currpage,pagesize);
    }

    @Override
    public int pagecount() {
        return selTotalRow("select count(*) from trial");
    }

    @Override
    public List<CourseVo> coursevo() {
        return listByHql("from CourseVo");
    }

    @Override
    public List<EmpVo> emp() {
        return listByHql("from EmpVo");
    }

    @Override
    public void add(TrialVo trialVo) {
        addObject(trialVo);
    }

    @Override
    public CourseVo courseid(int id) {
        return (CourseVo) getObject(new CourseVo().getClass(),id);
    }

    @Override
    public EmpVo emp(int id) {
        return (EmpVo) getObject(new EmpVo().getClass(),id);
    }

    @Override
    public void delete(int id) {
        TrialVo trialVo = new TrialVo();
        trialVo.setTrialId(id);
        delObject(trialVo);
    }
}