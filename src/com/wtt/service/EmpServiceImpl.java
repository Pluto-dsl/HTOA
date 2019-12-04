package com.wtt.service;

import com.publics.dao.BaseDao;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class EmpServiceImpl extends BaseDao implements EmpService{
    @Override
    public List weekpaper() {
        return listBySQL("select * from weeklog");
    }
}
