package com.zero.service;

import com.publics.vo.empModel.HolidayVo;

import java.util.List;
import java.util.Map;

public interface EmpActivitiService {
    String getLeaveList(String sql);//查询请假列表
    void addLeave(HolidayVo holidayVo);//添加请假
    String assignName(int empid);//设置办理人
    String assignDep(int depid);//设置办理人 是部门负责人
    String xiaassignName(int empid);//查询办理人
    HolidayVo seleHoliday(int holidayid);//查询当前任务
    String name(int empid);//查询任务人名称
    void updateholiday(HolidayVo holidayVo);//修改
    List<Map> mytask(int holidayid);//我的任务
    String isper(int depid,int empid);//是否部门负责人
}
