package com.norman.service;

import com.alibaba.fastjson.JSONArray;
import com.publics.vo.empModel.emp.EmpVo;
import com.publics.vo.logistics.EquipmentRepairVo;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;

public interface Ljw_LogsService {
    void newRepair(EquipmentRepairVo repairVo);//新增报修申请
    EquipmentRepairVo getRepair(int id);
    JSONArray getRepairData(HttpServletRequest request,int userType, int page, int limit);//根据用户类型查出对应的报修申请列表
    JSONArray getMyEmpRepairData(HttpServletRequest request,int userId,int page,int limit);//根据登录的用户查出对应的报修申请列表
    int getRepairSize(int userType);//根据用户类型查找数据条数
    int getMyEmpRepairSize(int userId);//根据用户id查找数据条数
    void delRepair(int id);
    EmpVo getEmpVo(int empId);
    void updRepair(EquipmentRepairVo vo);
}
