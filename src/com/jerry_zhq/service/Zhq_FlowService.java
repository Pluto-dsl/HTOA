package com.jerry_zhq.service;

import java.util.List;

public interface Zhq_FlowService {
    //查询流程
    List selFlow(String hql, int page, int limit);
    //查询总数
    int selCount();
}
