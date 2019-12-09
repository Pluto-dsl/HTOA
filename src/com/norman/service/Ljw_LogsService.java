package com.norman.service;

import com.alibaba.fastjson.JSONArray;
import com.publics.vo.logistics.EquipmentRepairVo;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;

public interface Ljw_LogsService {
    void newRepair(EquipmentRepairVo repairVo);
    JSONArray getMyEmpRepairData(HttpServletRequest request,int depId, int page, int limit);
    int getMyEmpRepairSize(int empId);
}
