package com.pluto.service.impl;

import com.pluto.service.Pluto_LeaveService;
import com.publics.dao.BaseDao;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class Pluto_LeaveServiceImpl extends BaseDao implements Pluto_LeaveService {


    @Override
    public List<Map> getLeaveList(String sql) {
        return super.listBySQL(sql);
    }
}
