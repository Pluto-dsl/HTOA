package com.jack.service;

import java.util.List;

public interface AttService {
    List selAtt(int currPage,int pageSize); //查询考勤表
    int selAttCount(); //查询总页数

}
