package com.jerry_zhq.service.impl;

import com.jerry_zhq.service.Zhq_FlowService;
import com.publics.dao.BaseDao;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class Zhq_FlowServiceImpl extends BaseDao implements Zhq_FlowService {
    @Override
    public List selFlow(String sql, int page, int limit) {
        return pageBySQL(sql,page,limit);
    }

    @Override
    public int selCount() {
        return selTotalRow("select count(*) from ACT_RE_PROCDEF");
    }
}
