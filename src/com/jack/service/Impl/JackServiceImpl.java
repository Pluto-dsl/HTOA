package com.jack.service.Impl;

import com.jack.service.Jack_Service;
import com.publics.dao.BaseDao;
import com.publics.vo.educ.CourseTypeVo;
import com.publics.vo.empModel.AttendanceVo;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class JackServiceImpl extends BaseDao implements Jack_Service {

    @Override
    public List selAtt(String Aname, int currPage, int pageSize) {
        return null;
    }

    @Override
    public int selAttCount(String Aname) {
        return 0;
    }

    @Override
    public String selDepChairman(String AName) {
        List list =  super.listBySQL("SELECT chairman FROM emp join dep on emp.depId = dep.depid where dep.depid =(select depId from emp where empName = '"+AName+"')");
        Map m = (Map) list.get(0);
        return (String) m.get("chairman");
    }

    @Override
    public void insertAtt(AttendanceVo attVo) {
        addObject(attVo);
    }

    @Override
    public void updataAtt(AttendanceVo att) {
         executeSQL("UPDATE attendance set examineTime = sysdate() , examineExplain = '"+att.getExamineExplain()+"',state= "+att.getState()+" where attId= "+att.getAttId()+"");
    }

    @Override
    public List selApprover(String Aname,int state) {
       return listByHql("from AttendanceVo where auditor = '"+Aname+"' and state = "+state+"");
    }

    /**  课程类型 */
    @Override
    public List selCourse(int currPage, int pageSize) {
        return pageByHql("from CourseTypeVo ",currPage,pageSize);
    }

    @Override
    public int selCouCount() {
        return selTotalRow("select count(*) from courseType");
    }

    @Override
    public int UpdateCourse(CourseTypeVo course) {
        updObject(course);
        return 1;
    }

    @Override
    public int delCourse(int id) {
        executeSQL("DELETE FROM courseType where courseTypeId = "+id+"");
        return 1;
    }

    @Override
    public int AddCurse(CourseTypeVo courseTypeVo) {
        addObject(courseTypeVo);
        return 1;
    }
}
