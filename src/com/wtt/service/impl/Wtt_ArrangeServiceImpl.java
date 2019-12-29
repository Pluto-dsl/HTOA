package com.wtt.service.impl;

import com.publics.dao.BaseDao;
import com.publics.vo.educ.WeekArrangeVo;
import com.publics.vo.empModel.emp.EmpVo;
import com.publics.vo.empModel.emp.PostVo;
import com.wtt.service.Wtt_ArrangeService;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class Wtt_ArrangeServiceImpl extends BaseDao implements Wtt_ArrangeService {

    @Override
    public List<WeekArrangeVo> weekArrangevo(int currpage, int pagesize) {
        return pageByHql("from WeekArrangeVo",currpage,pagesize);
    }

    @Override
    public int pagecount() {
        return selTotalRow("select count(*) from weekArrange");
    }

    @Override
    public List<EmpVo> emp() {
        return listByHql("from EmpVo");
    }

    @Override
    public void add(WeekArrangeVo weekArrangeVo) {
        addObject(weekArrangeVo);
    }

    @Override
    public EmpVo emps(int id) {
        return (EmpVo) getObject(new EmpVo().getClass(),id);
    }

    @Override
    public void delete(int id) {
        WeekArrangeVo weekArrangeVo = new WeekArrangeVo();
        weekArrangeVo.setWeekArrangeId(id);
        delObject(weekArrangeVo);
    }

    @Override
    public List<PostVo> postvo() {
        return listByHql("from PostVo");
    }
}