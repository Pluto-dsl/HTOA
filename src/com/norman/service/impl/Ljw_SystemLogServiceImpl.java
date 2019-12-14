package com.norman.service.impl;

import com.norman.service.Ljw_SystemLogService;
import com.publics.dao.BaseDao;
import com.publics.vo.assess.AduitLogVo;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.List;

@Service
@Transactional
public class Ljw_SystemLogServiceImpl extends BaseDao implements Ljw_SystemLogService {

    @Override
    public List getEmpList(int page,int limit) {
        return pageBySQL(   "select e.empId,e.empName,e.Sex,e.Phone,d.depName,SUM(a.Scores) scores from emp e " +
                            "LEFT JOIN aduitLog a on e.empId = a.Empid " +
                            "LEFT JOIN dep d on e.depId = d.depId " +
                            "GROUP BY e.empId,e.empName,e.Sex,e.Phone,d.depName",page,limit);
    }

    @Override
    public int getEmpListSize() {
        return listByHql("from EmpVo").size();
    }

    @Override
    public List<AduitLogVo> getEveryListById(int empId) {
        return listByHql("from AduitLogVo where Empid = '"+empId+"'");
    }
}
