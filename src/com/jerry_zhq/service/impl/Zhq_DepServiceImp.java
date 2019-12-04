package com.jerry_zhq.service.impl;

import com.jerry_zhq.service.Zhq_DepService;
import com.publics.dao.BaseDao;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class Zhq_DepServiceImp extends BaseDao implements Zhq_DepService {
    //查询部门
    @Override
    public List selDep() {
        return listByHql("from DepVo");
    }

    @Override
    public List selEmp() {
        return listBySQL("select * from emp");
    }
}
