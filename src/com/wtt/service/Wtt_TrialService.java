package com.wtt.service;

import com.publics.vo.educ.TrialVo;

import java.util.List;

public interface Wtt_TrialService {
    //查询试讲培训
    List<TrialVo> trialvo(int currpage, int pagesize);
    //查询总页数
    int pagecount();
}