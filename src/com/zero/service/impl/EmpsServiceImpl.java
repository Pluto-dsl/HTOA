package com.zero.service.impl;

import com.publics.dao.BaseDao;
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


}
