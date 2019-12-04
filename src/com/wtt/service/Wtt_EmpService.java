package com.wtt.service;

import com.publics.vo.empModel.WeeklogVo;

import java.util.List;

public interface Wtt_EmpService {
    List weekpaper();
    //新增周报
    void add(WeeklogVo weeklogVo);
}