package com.wtt.service;

import com.publics.dao.BaseDao;
import com.publics.vo.empModel.WeeklogVo;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class Wtt_EmpServiceImpl extends BaseDao implements Wtt_EmpService {
    @Override
    public List<Map> weekpaper() {
        return listBySQL("select * from weeklog");
    }

    @Override
    public void add(WeeklogVo weeklogVo) {
        addObject(weeklogVo);
    }

    @Override
    public WeeklogVo wekk(int id) {
        return (WeeklogVo) getObject(new WeeklogVo().getClass(),id);
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
}
