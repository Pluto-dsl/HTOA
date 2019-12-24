package com.pluto.service.impl;

import com.pluto.service.Pluto_LogService;
import com.publics.dao.BaseDao;
import com.publics.vo.sys.SystemLogVo;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class Pluto_LogsericeImpl extends BaseDao implements Pluto_LogService {
    @Override
    public Map getLogData(String sql,int page,int limit) {
        List list = super.pageBySQL(sql,page,limit);
        Map m = new HashMap();
        m.put("code",0);
        m.put("msg","学生列表");
        m.put("count",super.selTotalRow("select count(*) from systemLog"));
        m.put("data",list);
        return m;
    }
}
