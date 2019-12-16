package com.norman.service;

import com.publics.vo.assess.AduitLogVo;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;

public interface Ljw_SystemLogService {
    List getEmpList(HttpServletRequest request,int page, int limit);
    int getEmpListSize();
    List<Map> getEveryListById(int empId);
    AduitLogVo getAduitLog(int auditId);
}
