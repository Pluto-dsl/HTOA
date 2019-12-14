package com.norman.service;

import com.publics.vo.assess.AduitLogVo;

import java.util.List;

public interface Ljw_SystemLogService {
    List getEmpList(int page,int limit);
    int getEmpListSize();
    List<AduitLogVo> getEveryListById(int empId);
}
