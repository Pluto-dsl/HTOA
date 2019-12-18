package com.jerry_zhq.service.impl;

import com.jerry_zhq.service.Zhq_NoticeService;
import com.publics.dao.BaseDao;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class Zhq_NoticeServiceImpl extends BaseDao implements Zhq_NoticeService {
    //分页查询
    @Override
    public List selNotice(String hql, int page, int pageSize) {
        return  pageByHql(hql,page,pageSize);
    }

    @Override
    public int selCount() {
        return selTotalRow("select count(*) from notice");
    }
}
