package com.norman.service;

import com.alibaba.fastjson.JSONArray;
import com.publics.vo.logistics.EquipmentRepairVo;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;

public interface Ljw_LogsService {
    void newRepair(EquipmentRepairVo repairVo);
    JSONArray getRepairData(HttpServletRequest request,int userType, int page, int limit);
    JSONArray getMyEmpRepairData(HttpServletRequest request,int userId,int page,int limit);
    int getRepairSize(int userType);
    int getMyEmpRepairSize(int userId);
}
