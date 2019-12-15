package com.norman.service.impl;

import com.norman.service.Ljw_SystemLogService;
import com.publics.dao.BaseDao;
import com.publics.vo.assess.AduitLogVo;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.List;
import java.util.Map;

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
    public List<Map> getEveryListById(int empId) {
        return listBySQL("SELECT al.aduitLogid,e.empName,am.aduitName,al.Scores,al.auditDate,al.Image,ap.empName auditPerson,al.Remark FROM aduitLog al\n" +
                "LEFT JOIN aduitModel am on al.aduitModelid=am.aduitModelid\n" +
                "LEFT JOIN emp e on al.Empid=e.empId \n" +
                "LEFT JOIN emp ap on al.auditPerson=ap.Empid\n" +
                "WHERE al.Empid = "+empId);
    }

    @Override
    public AduitLogVo getAduitLog(int auditId) {
        return (AduitLogVo) getObject(AduitLogVo.class,auditId);
    }
}
