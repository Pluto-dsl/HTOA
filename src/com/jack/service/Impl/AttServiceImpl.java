package com.jack.service.Impl;

import com.jack.service.AttService;
import com.publics.dao.BaseDao;
import com.publics.vo.empModel.AttendanceVo;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class AttServiceImpl extends BaseDao implements AttService {

    @Override
    public List selAtt(int currPage,int pageSize) {
        return null;
    }

    @Override
    public int selAttCount() {
        return 0;
    }

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
}
