package com.zero.service.impl;

import com.publics.dao.BaseDao;
import com.zero.service.EmpService;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Map;
@Service
public class EmpServiceImpl extends BaseDao implements EmpService {
    @Override
    public List<Map> selectEmp() {
        List<Map> mapList=  super.listBySQL("SELECT * FROM emp left join dep on emp.depId = dep.depid");
        return mapList;
    }
}
