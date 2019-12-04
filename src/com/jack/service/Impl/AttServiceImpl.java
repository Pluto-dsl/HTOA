package com.jack.service.Impl;

import com.jack.service.AttService;
import com.publics.dao.BaseDao;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AttServiceImpl extends BaseDao implements AttService {

    @Override
    public List selAtt(int currPage,int pageSize) {
        return pageByHql("from AttendanceVo",currPage,pageSize);
    }

    @Override
    public int selAttCount() {
        return selTotalRow("select count(*) from attendance");
    }
}
