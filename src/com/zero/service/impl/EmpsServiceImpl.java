package com.zero.service.impl;

import com.publics.dao.BaseDao;
import com.publics.vo.educ.WeekArrangeVo;
import com.publics.vo.empModel.WeeklogVo;
import com.publics.vo.empModel.emp.EmpVo;
import com.zero.service.EmpsService;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Map;
@Service
public class EmpsServiceImpl extends BaseDao implements EmpsService {
    @Override
    public List<Map> selectEmp() {
        List<Map> mapList=  super.listBySQL("SELECT e.empId,e.empName,d.depName,e.postName,e.Sex,e.Phone,e.Address,e.`status` FROM emp e left join dep d on e.depId = d.depid");
        return mapList;
    }

    @Override
    public void addEmp(EmpVo empVo) {
        super.addObject(empVo);
    }

    @Override
    public void update(EmpVo empVo) {
        super.updObject(empVo);
    }

    @Override
    public List allDep() {
        return super.listByHql("from DepVo");
    }

    @Override
    public void deleteEmp(EmpVo empVo) {
        super.delObject(empVo);
    }

    @Override
    public Map toemp(int empId) {
        return (Map) super.listBySQL("SELECT e.*,d.depName FROM emp e left join dep d on e.depId = d.depid where e.empId = "+empId).get(0);

    }

    @Override
    public void resetPwd(int empId) {
        super.executeSQL("update emp set password = '123456' where empId = "+empId);
    }

    @Override
    public List<Map> seekEmp(String sql) {
        return super.listBySQL("SELECT e.*,d.depName FROM emp e left join dep d on e.depId = d.depid "+sql);
    }

    @Override
    public int statue(int empId) {
        return (int) ((Map)super.listBySQL("SELECT status from emp where empId = "+empId).get(0)).get("status");
    }

    @Override
    public void status(int state, int empId) {
        super.executeSQL("update emp set status = "+state+" where empId = "+empId);
    }

    @Override
    public void updatePwd(int empId, String pwd1) {
        super.executeSQL("UPDATE emp set `password` = '"+pwd1+"' where empId = "+empId);
    }

    @Override
    public int selDep(String name, String depName) {
        return selTotalRow("select count(*) jl from dep where chairman = '"+name+"' and depName ='"+depName+"'");
    }

    @Override
    public int selStudentClass(int empId) {
        return selTotalRow("select count(*) jl from studentClass where classTeacher ="+empId+" or teacher ="+empId+"");
    }

    @Override
    public int selStuRepScore(int empId) {
       return selTotalRow("select count(*) jl from studentReplyScore where empId= "+empId);
    }

    @Override
    public void deleteWeekLog(int empId) {
        super.executeSQL("delete from weeklog where Empid ="+empId+"");
    }

    @Override
    public void deleteWeekArrange(int empId) {
        super.executeSQL("delete from weekArrange where empId ="+empId+"");
    }

    @Override
    public void deleteChatRecord(int empId) {
        super.executeSQL("delete from chatRecord where teacher ="+empId+"");
    }

   @Override
    public void deleteAssTotal(int empId) {
        super.executeSQL("delete from aduitLog where Empid ="+empId+"");
    }


}
