package com.zero.service;

import com.publics.vo.empModel.HolidayVo;

public interface EmpActivitiService {
    String getLeaveList(String sql);//查询请假列表
    void addLeave(HolidayVo holidayVo);//添加请假
    String assignName(int empid);//查询办理人
    String xiaassignName(int empid);//查询办理人
    HolidayVo seleHoliday(int holidayid);//查询当前
    void updateholiday(HolidayVo holidayVo);//修改
}
