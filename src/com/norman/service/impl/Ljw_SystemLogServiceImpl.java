package com.norman.service.impl;

import com.norman.service.Ljw_SystemLogService;
import com.publics.dao.BaseDao;
import com.publics.vo.assess.AduitLogVo;
import com.publics.vo.empModel.AttendanceVo;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import javax.transaction.Transactional;
import java.util.List;
import java.util.Map;

@Service
@Transactional
public class Ljw_SystemLogServiceImpl extends BaseDao implements Ljw_SystemLogService {

    @Override
    public List getEmpList(HttpServletRequest request,int page, int limit) {

        String empName = request.getParameter("empName");
        String depIdStr = request.getParameter("depId");
        String sql ="select e.empId,e.empName,e.Sex,e.Phone,d.depName,SUM(a.Scores) scores from emp e \n" +
                "LEFT JOIN aduitLog a on e.empId = a.Empid \n" +
                "LEFT JOIN dep d on e.depId = d.depId \n" +
                "GROUP BY e.empId,e.empName,e.Sex,e.Phone,d.depName \n" +
                "HAVING 1=1 ";

        int depId;//判断员工id
        if ("".equals(depIdStr) || null == depIdStr){
            depId = 0;
        }else {
            depId = Integer.parseInt(depIdStr);
        }
        if (depId!=0){
            sql +=" and Empid in (SELECT empId FROM emp where depId="+depId+")";
        }

        if (!("".equals(empName) || null == empName)){//部门
            List<Integer> emps = super.getEmpNames(empName);
            if (emps.size()>=1){
                String empIds = "";
                for (int id:emps) {
                    empIds +=+id+",";
                }
                System.out.println(empIds);
                empIds = empIds.substring(0,empIds.length()-1);
                sql +=" and Empid in ("+empIds+")";
            }else {
                sql +=" and Empid in (0)";
            }
        }
        return super.pageBySQL(sql,page,limit);
    }

    @Override
    public int getEmpListSize() {
        return listByHql("from EmpVo").size();
    }

    @Override
    public List<Map> getEveryListById(int empId) {
        return super.listBySQL("SELECT al.aduitLogid,e.empName,am.aduitName,al.Scores,al.auditDate,al.Image,ap.empName auditPerson,al.Remark FROM aduitLog al \n" +
                "LEFT JOIN aduitModel am on al.aduitModelid=am.aduitModelid \n" +
                "LEFT JOIN emp e on al.Empid=e.empId \n" +
                "LEFT JOIN emp ap on al.auditPerson=ap.Empid\n" +
                "WHERE al.Empid = "+empId);
    }

    @Override
    public AduitLogVo getAduitLog(int auditId) {
        return (AduitLogVo) super.getObject(AduitLogVo.class,auditId);
    }

    @Override
    public List<AttendanceVo> getAttendance(int page,int limit) {
        return super.pageBySQL("SELECT att.*,e.empName FROM attendance att\n" +
                "LEFT JOIN emp e on e.empId=att.empId",page,limit);
    }

    @Override
    public int getAttendanceSize() {
        return 0;
    }
}
