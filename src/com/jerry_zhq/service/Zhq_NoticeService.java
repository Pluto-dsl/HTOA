package com.jerry_zhq.service;

import java.util.List;

public interface Zhq_NoticeService {
    //分页查询
    List selNotice(String hql, int page, int pageSize);
    //查询总条数
    int selCount();
}
