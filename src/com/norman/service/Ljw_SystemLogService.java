package com.norman.service;

import com.publics.vo.assess.AduitLogVo;
import com.publics.vo.empModel.AttendanceVo;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;

public interface Ljw_SystemLogService {
    /*
    * 日常考核统计
    * */
    List getEmpList(HttpServletRequest request,int page, int limit);//获取员工列表
    int getEmpListSize();//获取员工列表大小
    List<Map> getEveryListById(int empId);//获取指定员工的考核巡查列表
    AduitLogVo getAduitLog(int auditId);//获取指定的考核巡查记录

    /*
    * 未打卡说明统计
    * */
    List<AttendanceVo> getAttendance(int page,int limit);
    int getAttendanceSize();

    List<AttendanceVo> getAttendance();
}
